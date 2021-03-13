using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class SqlServerDataTypeWithPrecisionAndScaleTests
    {
        [TestCase]
        public void ParameterValidation_ErrorIfNotOnList()
        {
            //Arrange
            String Actual = "NotADataType";
            int Precision = 10;
            int Scale = 2;
            //Act

            //Assert
            Assert.Throws<DataTypeNotRecognizedException>(delegate { new SqlServerDataTypeWithPrecisionAndScale(Actual,Precision,Scale); });
        }

        [TestCase]
        public void ParameterValidation_ErrorIfUnsupported()
        {
            //Arrange
            String Actual = "sql_variant";
            int Precision = 10;
            int Scale = 2;
            //Act

            //Assert
            Assert.Throws<DataTypeNotSupportedException>(delegate { new SqlServerDataTypeWithPrecisionAndScale(Actual,Precision,Scale); });
        }

        [TestCase]
        public void ParameterValidation_NothingIfSupported()
        {
            //Arrange
            String Actual = "numeric";
            int Precision = 10;
            int Scale = 2;
            //Act

            //Assert
            Assert.That(delegate { new SqlServerDataTypeWithPrecisionAndScale(Actual,Precision,Scale); }, Throws.Nothing);
        }
        
        [TestCase]
        public void Script()
        {
            //Arrange
            String Expected = "[decimal](10,2)";
            int Precision = 10;
            int Scale = 2;
            //Act
            String dataType = "decimal";
            SqlServerDataTypeWithPrecisionAndScale SqlServerDataTypeWithPrecisionAndScale = new SqlServerDataTypeWithPrecisionAndScale(dataType,Precision,Scale);
            String Actual = SqlServerDataTypeWithPrecisionAndScale.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }
        
        [TestCase]
        public void Clone()
        {   //Arrange
            String dataType = "decimal";
            int Precision = 10;
            int Scale = 2;
            SqlServerDataTypeWithPrecisionAndScale SqlServerDataTypeWithPrecisionAndScaleDolly = new SqlServerDataTypeWithPrecisionAndScale(dataType,Precision,Scale);
            String Expected = SqlServerDataTypeWithPrecisionAndScaleDolly.Script();
         
            //Act
            IDataType SqlServerDataTypeWithPrecisionAndScaleDollyPrime = SqlServerDataTypeWithPrecisionAndScaleDolly.Clone();
            SqlServerDataTypeWithPrecisionAndScaleDollyPrime.DataTypeName = "bigint";
            String Actual = SqlServerDataTypeWithPrecisionAndScaleDollyPrime.Script();

            //Assert
            Assert.AreNotEqual(Expected, Actual);
        }
    }
}
