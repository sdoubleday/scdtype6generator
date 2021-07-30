using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SqlServer.Dac;
using Microsoft.SqlServer.Dac.Model;
using Microsoft.SqlServer.TransactSql.ScriptDom;
using SqlTemplateColumnExpander;

namespace GenerateSCDType6Files
{
    class Program
    {
        static void Main(string[] args)
        {
            ParsedArgs parsedArgs = new ParsedArgs(args);

            Microsoft.SqlServer.Dac.Model.TSqlModel sqlModel = new Microsoft.SqlServer.Dac.Model.TSqlModel(parsedArgs.DacPacFileName);

            //Where takes a predicate thing. No, I haven't figured out how to do that without lambda stuff yet. But this is tolerably readable for main control flow, I think.
            var tables = sqlModel.GetObjects(DacQueryScopes.Default, Table.TypeClass).ToList().Where(table => table.Name.ToString().EndsWith("_dimSrc_stg]"));
            var views = sqlModel.GetObjects(DacQueryScopes.Default, View.TypeClass).ToList().Where(view => view.Name.ToString().EndsWith("_dimSrc_stg]"));

            foreach (var table in tables)
            {
                ProcessTSqlObjectIntoDimensionScriptFiles(parsedArgs, table, Table.Columns, Table.Schema);
            }
            foreach (var view in views)
            {
                ProcessTSqlObjectIntoDimensionScriptFiles(parsedArgs, view, View.Columns, View.Schema);
            }

            Console.WriteLine("Press any key to close!");
            Console.ReadLine();

        }

        public static void ProcessTSqlObjectIntoDimensionScriptFiles(ParsedArgs parsedArgs, TSqlObject table, ModelRelationshipClass relationshipTypeColumns, ModelRelationshipClass relationshipTypeSchema)
        {
            string stagingSchemaName = GetSchemaName(table);
            string templateDimCoreName = GetObjectName(table).Replace("_dimSrc_stg", "");
            List<String> listOfColumns = new List<String>();
            foreach (var col in table.GetReferenced(relationshipTypeColumns, DacQueryScopes.UserDefined))
            {
                String column = GetColumnName(col);
                listOfColumns.Add(column);
            }
            GenerateDimension(listOfColumns, templateDimCoreName, parsedArgs, stagingSchemaName);
        }

        public static void GenerateDimension(List<string> listOfColumns, String templateDimCoreName, ParsedArgs parsedArgs, String StagingSchema)
        {
            List<String> listOfNks = listOfColumns.Where(mystring => mystring.StartsWith("NK_")).ToList<String>();
            LineProcessorConfig lineProcessorConfigNK = new LineProcessorConfig("NaturalKey_ReplacementPoint", listOfNks);
            List<String> listOfDims = listOfColumns.Where(mystring => !mystring.StartsWith("Ctl_")).Where(mystring => !mystring.StartsWith("NK_")).ToList<String>();
            LineProcessorConfig lineProcessorConfigDim = new LineProcessorConfig("DimensionAttribute_ReplacementPoint", listOfDims);
            List<String> listOfCtl = listOfColumns.Where(mystring => mystring.StartsWith("Ctl_")).ToList<String>();
            //We should error out if table/view exists and listOfCtl <> List<String>{"Ctl_EffectiveDate"}

            StringReplacementPair stringReplacementPair_1 = new StringReplacementPair("templateDimCoreName", templateDimCoreName);
            StringReplacementPair stringReplacementPair_2 = new StringReplacementPair("templateSchema", parsedArgs.templateSchema);
            StringReplacementPair stringReplacementPair_3 = new StringReplacementPair("dimensionSchema", parsedArgs.DimensionSchema);
            StringReplacementPair stringReplacementPair_4 = new StringReplacementPair("StagingSchema", StagingSchema);


            List<StringReplacementPair> replacementPairs = new List<StringReplacementPair> {
                     stringReplacementPair_1
                    ,stringReplacementPair_2
                    ,stringReplacementPair_3
                    ,stringReplacementPair_4
            } ;
            List<LineProcessorConfig> lineProcessorConfigs = new List<LineProcessorConfig> { lineProcessorConfigNK, lineProcessorConfigDim };

            FileListerReplacerPairer fileListerReplacerPairer = new FileListerReplacerPairer(parsedArgs.SCDType6TemplateDirectory, parsedArgs.OutputDirectory,replacementPairs);
            FileListerReplacerPairer fileListerReplacerPairer_dimSchema = new FileListerReplacerPairer(parsedArgs.SCDType6DimensionDirectory, parsedArgs.OutputDirectory, replacementPairs);

            List<FilePathPair> filePathPairs = new List<FilePathPair>();
            filePathPairs.AddRange(fileListerReplacerPairer.sourceAndDestinationFilePaths);
            filePathPairs.AddRange(fileListerReplacerPairer_dimSchema.sourceAndDestinationFilePaths);

            FileInFlightTransformer fileInFlightTransformer = new FileInFlightTransformer(filePathPairs, replacementPairs, lineProcessorConfigs);
            fileInFlightTransformer.ReadTransformWrite();
        }

        public static string GetObjectName(TSqlObject obj)
        {
            return obj.Name.ToString().Split('.')[1].Replace("[", "").Replace("]", "");
            //This parses the [schema].[object] format that we get back
        }

        public static string GetSchemaName(TSqlObject obj)
        {
            Console.WriteLine(obj.Name.ToString());

            string returnable = obj.Name.ToString().Split('.')[0].Replace("[", "").Replace("]", "");
            Console.WriteLine(returnable);
            return returnable;
            //This parses the [schema].[object] format that we get back
        }

        public static string GetColumnName(TSqlObject col)
        {
            return col.Name.ToString().Split('.')[2].Replace("[", "").Replace("]", "");
            //This parses the [schema].[object].[column] format that we get back
        }
    }
}
