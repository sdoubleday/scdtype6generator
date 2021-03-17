using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.SqlServer.Dac;
using Microsoft.SqlServer.Dac.Model;
using Microsoft.SqlServer.TransactSql.ScriptDom;

namespace ReadDacPacNormalDotNet
{
    class Program
    {
        static void Main(string[] args)
        {
            string filepath = args[0];

            Microsoft.SqlServer.Dac.Model.TSqlModel sqlModel = new Microsoft.SqlServer.Dac.Model.TSqlModel(filepath);

            var tables = sqlModel.GetObjects(DacQueryScopes.Default, Table.TypeClass).ToList();
            var views = sqlModel.GetObjects(DacQueryScopes.Default, View.TypeClass).ToList();
            SCDType6Generator.Nullability nullability = new SCDType6Generator.Nullability("No");
            SCDType6Generator.IColumnDefault columnDefault = new SCDType6Generator.ColumnDefault("! Value Unknown");
            SCDType6Generator.IDataType dataType = new SCDType6Generator.SqlServerDataTypeWithLength("varchar", 500);


            foreach (var table in tables)
            {
                List<SCDType6Generator.IColumn> listOfColumns = new List<SCDType6Generator.IColumn>();
                foreach (var col in table.GetReferenced(Table.Columns, DacQueryScopes.UserDefined))
                {
                    int i = 1;
                    SCDType6Generator.IColumn column = new SCDType6Generator.Column(col.Name.ToString(), i, columnDefault.Clone(), nullability.Clone(), dataType.Clone());

                    ////We will want this bit in the future.
                    //var type = col.GetReferenced(Column.DataType);
                    ////This next bit has a null problem. Borrowed code from https://the.agilesql.club/2019/04/dacfx-how-to-get-the-data-type-from-a-column-a-discussion-of-properties-relationships-and-the-tsqlmodel/
                    //var typeFirstOrDefault = type.SingleOrDefault();
                    //Console.WriteLine(typeFirstOrDefault.Name);
                    //var sqlDataType = typeFirstOrDefault.GetProperty<SqlDataType>(DataType.SqlDataType);

                    listOfColumns.Add(column);
                }
                SCDType6Generator.ColumnList columnList = new SCDType6Generator.ColumnList(listOfColumns);
                Console.WriteLine(columnList.Script());
            }


            //Normally the problems I'm having here would make me think I should keep trying
            //but it seems like there's only ONE GUY out there on the internet answering questions
            //about the dacpac api. And he didn't write it. And I cannot make his samples work.
            //So search for these libraries on GitHub. IF there are not cool projects there doing cool
            //stuff with recent edits, then it is time to turn back to getting my metadata from deployed
            //sql code.

            //Checked github, and its basically crickets for that library. Don't expect non-obvious
            //success to bubble up out of it if I stir it enough.
            foreach (var view in views)
            {
                List<SCDType6Generator.IColumn> listOfColumns = new List<SCDType6Generator.IColumn>();
                foreach (var col in view.GetReferenced(View.Columns, DacQueryScopes.UserDefined))
                {
                    int i = 1;
                    SCDType6Generator.IColumn column = new SCDType6Generator.Column(col.Name.ToString(), i, columnDefault.Clone(), nullability.Clone(), dataType.Clone());

                    ////We will want this bit in the future.
                    //var type = col.GetReferenced(Column.DataType);
                    ////This next bit has a null problem. Borrowed code from https://the.agilesql.club/2019/04/dacfx-how-to-get-the-data-type-from-a-column-a-discussion-of-properties-relationships-and-the-tsqlmodel/
                    //var typeFirstOrDefault = type.SingleOrDefault();
                    //Console.WriteLine(typeFirstOrDefault.Name);
                    //var sqlDataType = typeFirstOrDefault.GetProperty<SqlDataType>(DataType.SqlDataType);

                    listOfColumns.Add(column);
                }
                SCDType6Generator.ColumnList columnList = new SCDType6Generator.ColumnList(listOfColumns);
                Console.WriteLine(columnList.Script());
            }

            Console.WriteLine("Press any key to close!");
            Console.ReadLine();
        }
    }
}
