﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class SqlServerDataType : IDataType
    {
        public String DataTypeName { get; set; }

        public SqlServerDataType(String DataTypeName)
        {
            this.DataTypeName = DataTypeName;
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
                throw new DataTypeNotRecognizedException("DataType must be a known SQL Server Data Type.", this.DataTypeName);
            }
        }

        public String Script()
        {
            String returnable = "[" + this.DataTypeName + "]";
            return returnable;
        }

        public IDataType Clone()
        {
            SqlServerDataType returnable = new SqlServerDataType(this.DataTypeName);
            return returnable;
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
            list.Add("smalldatetime");
            list.Add("text");
            list.Add("ntext");

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