using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class SqlServerDataTypeWithPrecisionAndScale : IDataType
    {
        public String DataTypeName { get; set; }
        int Precision;
        int Scale;

        public SqlServerDataTypeWithPrecisionAndScale(String DataTypeName, int Precision, int Scale)
        {
            this.DataTypeName = DataTypeName;
            this.Precision = Precision;
            this.Scale = Scale;
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
                throw new DataTypeNotRecognizedException("DataType must be a known SQL Server Data Type. (Did you also specify scale when you only meant length?)", this.DataTypeName);
            }
        }

        public String Script()
        {
            String returnable = "[" + this.DataTypeName + "](" + this.Precision + "," + this.Scale + ")";
            return returnable;
        }

        public IDataType Clone()
        {
            SqlServerDataTypeWithPrecisionAndScale returnable = new SqlServerDataTypeWithPrecisionAndScale(
                this.DataTypeName
                ,this.Precision
                ,this.Scale);
            return returnable;
        }

        private static List<string> GetValidList()
        {
            List<String> list = new List<string>();
            list.Add("decimal");
            list.Add("numeric");

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
