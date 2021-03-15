using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class SqlServerDataTypeWithLength : IDataType
    {
        public String DataTypeName { get; set; }
        int Length;

        public SqlServerDataTypeWithLength(String DataTypeName, int Length)
        {
            this.DataTypeName = DataTypeName;
            this.Length = Length;
            this.ParameterValidation();
        }

        public void ParameterValidation()
        {
            List<String> list = GetValidList();
            List<String> knownUnsupportedList = GetKnownButUnsupportedList();


            if (list.Contains(this.DataTypeName))
            {
                //Do nothing! Yay!
            }
            else if (knownUnsupportedList.Contains(this.DataTypeName))
            {
                throw new DataTypeNotSupportedException("DataType must be a primitive SQL Server Data Type.", this.DataTypeName);
            }
            else
            {
                throw new DataTypeNotRecognizedException("DataType must be a known SQL Server Data Type. (Did you specify length when you needed either also scale or nothing?)", this.DataTypeName);
            }
        }

        public String Script()
        {
            String returnable = "";
            if (this.Length == -1)
            {
                returnable = "[" + this.DataTypeName + "](MAX)";
            }
            else { 
                returnable = "[" + this.DataTypeName + "](" + this.Length + ")";
            }
            return returnable;
        }

        public IDataType Clone()
        {
            SqlServerDataTypeWithLength returnable = new SqlServerDataTypeWithLength(
                this.DataTypeName
                ,this.Length);
            return returnable;
        }

        private static List<string> GetValidList()
        {
            List<String> list = new List<string>();
            list.Add("datetime2");
            list.Add("datetimeoffset");
            list.Add("time");
            list.Add("char");
            list.Add("varchar");
            list.Add("nchar");
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
