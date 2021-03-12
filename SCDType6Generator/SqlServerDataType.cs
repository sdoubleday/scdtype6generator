using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class SqlServerDataType
    {
        String DataTypeName;
        int CHARACTER_MAXIMUM_LENGTH;// int Maximum length, in characters, for binary data, character data, or text and image data.
                                     //-1 for xml and large-value type data.Otherwise, NULL is returned.For more information, see Data Types(Transact-SQL).
        int NUMERIC_PRECISION;// tinyint Precision of approximate numeric data, exact numeric data, integer data, or monetary data.Otherwise, NULL is returned.
        int NUMERIC_SCALE;//   int Scale of approximate numeric data, exact numeric data, integer data, or monetary data.Otherwise, NULL is returned.
        int DATETIME_PRECISION;// smallint


        public SqlServerDataType(String DataTypeName)
        {
            this.DataTypeName = DataTypeName;
            this.ParameterValidation();
        }

        public void ParameterValidation ()
        {
            List<String> list = GetValidList();
            List<String> knownUnsupportedList = GetKnownButUnsupportedList();


            if (list.Contains(this.DataTypeName)) { 
                //Do nothing! Yay!
            }
            else if (knownUnsupportedList.Contains(this.DataTypeName)) { 
                throw new DataTypeNotSupportedException("DataType must be a primitive SQL Server Data Type.",this.DataTypeName);
            }
            else {
                throw new DataTypeNotRecognizedException("DataType must be a known SQL Server Data Type.",this.DataTypeName);
            }
        }

        private static List<string> GetValidList()
        {
            List<String> list = new List<string>();
            list.Add("bigint");
            list.Add("bit");
            list.Add("decimal");
            list.Add("int");
            list.Add("money");
            list.Add("numeric");
            list.Add("smallint");
            list.Add("smallmoney");
            list.Add("tinyint");
            list.Add("float");
            list.Add("real");
            list.Add("date");
            list.Add("datetime");
            list.Add("datetime2");
            list.Add("datetimeoffset");
            list.Add("smalldatetime");
            list.Add("time");
            list.Add("char");
            list.Add("text");
            list.Add("varchar");
            list.Add("nchar");
            list.Add("ntext");
            list.Add("nvarchar");
            list.Add("binary");
            list.Add("varbinary");

            return list;
        }

        private static List<string> GetKnownButUnsupportedList()
        {
            List<String> list = new List<string>();
            list.Add("image");
            list.Add("cursor");
            list.Add("hierarchyid");
            list.Add("sql_variant");
            list.Add("table");
            list.Add("rowversion");
            list.Add("timestamp");
            list.Add("uniqueidentifier");
            list.Add("xml");
            list.Add("geometry");
            list.Add("geography");

            return list;
        }

    }
}
