﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SqlServer.Dac;
using Microsoft.SqlServer.Dac.Model;
using Microsoft.SqlServer.TransactSql.ScriptDom;
using SCDType6Generator;


//Normally the problems I'm having here would make me think I should keep trying
//but it seems like there's only ONE GUY out there on the internet answering questions
//about the dacpac api. And he didn't write it. And I cannot make his samples work.
//So search for these libraries on GitHub. IF there are not cool projects there doing cool
//stuff with recent edits, then it is time to turn back to getting my metadata from deployed
//sql code.

//Checked github, and its basically crickets for that library. Don't expect non-obvious
//success to bubble up out of it if I stir it enough.



//I've moved away from trying to fully interrogate the metadata of view columns, which the Microsoft.SqlServer.Dac.Model library was doing very poorly.

namespace ReadDacPacNormalDotNet
{
    class Program
    {
        static void Main(string[] args)
        {
            string DacPacFileName = args[0];
            string SCDType6TemplateDirectory = AppDomain.CurrentDomain.BaseDirectory + "\\..\\..\\..\\SCDType6Template\\templateSchema\\";
            string SCDType6DimensionDirectory = AppDomain.CurrentDomain.BaseDirectory + "\\..\\..\\..\\SCDType6Template\\dimensionSchema\\";
            string OutputDirectory = args[1];
            string DimensionSchema = args[2];
            string templateSchema = args[3];

            Microsoft.SqlServer.Dac.Model.TSqlModel sqlModel = new Microsoft.SqlServer.Dac.Model.TSqlModel(DacPacFileName);

            //Where takes a predicate thing. No, I haven't figured out how to do that without lambda stuff yet. But this is tolerably readable for main control flow, I think.
            var tables = sqlModel.GetObjects(DacQueryScopes.Default, Table.TypeClass).ToList().Where(table => table.Name.ToString().EndsWith("_dimSrc_stg]") );
            var views = sqlModel.GetObjects(DacQueryScopes.Default, View.TypeClass).ToList().Where(view => view.Name.ToString().EndsWith("_dimSrc_stg]") );

            foreach (var table in tables)
            {
                ProcessTSqlObjectIntoDimensionScriptFiles(SCDType6TemplateDirectory, SCDType6DimensionDirectory, OutputDirectory, DimensionSchema, templateSchema, table, Table.Columns, Table.Schema);
            }
            foreach (var view in views)
            {
                ProcessTSqlObjectIntoDimensionScriptFiles(SCDType6TemplateDirectory, SCDType6DimensionDirectory, OutputDirectory, DimensionSchema, templateSchema, view, View.Columns, View.Schema);
            }

            Console.WriteLine("Press any key to close!");
            Console.ReadLine();

        }

        public static void ProcessTSqlObjectIntoDimensionScriptFiles(string SCDType6TemplateDirectory, string SCDType6DimensionDirectory, string OutputDirectory, string DimensionSchema, string templateSchema, TSqlObject table, ModelRelationshipClass relationshipTypeColumns, ModelRelationshipClass relationshipTypeSchema)
        {
            string stagingSchemaName = GetSchemaName( table );
            string templateDimCoreName = GetObjectName(table).Replace("_dimSrc_stg", "");
            List<String> listOfColumns = new List<String>();
            foreach (var col in table.GetReferenced(relationshipTypeColumns, DacQueryScopes.UserDefined))
            {
                String column = GetColumnName(col);
                listOfColumns.Add(column);
            }
            GenerateDimension(listOfColumns, templateDimCoreName, SCDType6TemplateDirectory, SCDType6DimensionDirectory, OutputDirectory, DimensionSchema, templateSchema, stagingSchemaName);
        }

        public static void GenerateDimension(List<string> listOfColumns, String templateDimCoreName, String SCDType6TemplateDirectory, String SCDType6DimensionDirectory, String OutputDirectory, String DimensionSchema, String templateSchema, String StagingSchema)
        {
            List<String> listOfNks = listOfColumns.Where(mystring => mystring.StartsWith("NK_")).ToList<String>();
            LineProcessorConfig lineProcessorConfigNK = new LineProcessorConfig("NaturalKey_ReplacementPoint", listOfNks);
            List<String> listOfDims = listOfColumns.Where(mystring => !mystring.StartsWith("Ctl_")).Where(mystring => !mystring.StartsWith("NK_")).ToList<String>();
            LineProcessorConfig lineProcessorConfigDim = new LineProcessorConfig("DimensionAttribute_ReplacementPoint", listOfDims);
            List<String> listOfCtl = listOfColumns.Where(mystring => mystring.StartsWith("Ctl_")).ToList<String>();
            //We should error out if table/view exists and listOfCtl <> List<String>{"Ctl_EffectiveDate"}


            //Something like:
            //method list all files in template directory to output directory, get string renaming them to swap out the templateDimCoreName in the file name.
            //StreamReader the source file. Foreach line, create line processor for nk, get back line. Create line processor for dim (with that returned line), get back line.
            //StreamWriter out the line to a file with the new name in output directory.
            //

            List<String> templateFiles = new List<string>{
                 "Stored Procedures\\templateDimCoreName_dimSrc_clearTables_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_dimUpsert_Step1_Update_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_dimUpsert_Step2_Insert_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_orchestration_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_ControlFlow_IsStgATable_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_orchestration_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_setup_clearTables_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_Step1_copycurrent_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_Step2_prep_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_Step3_prep_updateSCDStatus_usp.sql"
                ,"Stored Procedures\\templateDimCoreName_predim_Step4_prep_DeleteIgnorable.sql"
                //,"Tables\\templateDimCoreName_dimSrc_stg.sql"
                ,"Tables\\templateDimCoreName_predim_copycurrent.sql"
                ,"Tables\\templateDimCoreName_predim_prep.sql"
                ,"Views\\templateDimCoreName_dimUpsert_GetMaxSK_vw.sql"
                ,"Views\\templateDimCoreName_dimUpsert_Step2_Insert_SelectClause_vw.sql"
                ,"Views\\templateDimCoreName_FindUpdates_vw.sql"
                ,"Views\\templateDimCoreName_predim_Step2_prep_columnTransformations_vw.sql"
                };

            foreach(String file in templateFiles)
            {
                TransformFileInFlight(templateDimCoreName, SCDType6TemplateDirectory, OutputDirectory, DimensionSchema, templateSchema, StagingSchema, lineProcessorConfigNK, lineProcessorConfigDim, file);

            }

            string dimFile = "Tables\\templateDimCoreName_Dim.sql";
            TransformFileInFlight(templateDimCoreName, SCDType6DimensionDirectory, OutputDirectory, DimensionSchema, templateSchema, StagingSchema, lineProcessorConfigNK, lineProcessorConfigDim, dimFile);


            Console.WriteLine(templateDimCoreName);
            Console.WriteLine(String.Join("\r\n", lineProcessorConfigDim.perLineSubstitutions.ToArray()));
            Console.WriteLine(String.Join("\r\n", lineProcessorConfigNK.perLineSubstitutions.ToArray()));
        }

        public static void TransformFileInFlight(string templateDimCoreName, string SCDType6TemplateDirectory, string OutputDirectory, string DimensionSchema, string templateSchema, string StagingSchema, LineProcessorConfig lineProcessorConfigNK, LineProcessorConfig lineProcessorConfigDim, string file)
        {
            String source = SCDType6TemplateDirectory + file;
            String destination = OutputDirectory + file.Replace("templateDimCoreName", templateDimCoreName);
            using (StreamReader reader = new StreamReader(source))
            using (StreamWriter writer = new StreamWriter(destination, false, Encoding.UTF8))
            {
                while (!reader.EndOfStream)
                {
                    string line = reader.ReadLine();
                    line = line.Replace("templateDimCoreName", templateDimCoreName).Replace("templateSchema", templateSchema).Replace("dimensionSchema", DimensionSchema).Replace("StagingSchema", StagingSchema);
                    if (!line.Contains("/*Sample*/"))
                    {
                        LineProcessor lineProcessorNK = new LineProcessor(line, lineProcessorConfigNK);
                        line = lineProcessorNK.GetLine();
                        LineProcessor lineProcessorDim = new LineProcessor(line, lineProcessorConfigDim);
                        line = lineProcessorDim.GetLine();

                        writer.WriteLine(line);
                    }

                }

            }
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
