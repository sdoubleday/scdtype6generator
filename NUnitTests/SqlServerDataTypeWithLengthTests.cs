using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class SqlServerDataTypeWithLengthTests
    {
        [TestCase]
        public void ParameterValidation_ErrorIfNotOnList()
        {
            //Arrange
            String Actual = "NotADataType";
            int Length = 10;
            //Act

            //Assert
            Assert.Throws<DataTypeNotRecognizedException>(delegate { new SqlServerDataTypeWithLength(Actual,Length); });
        }

        [TestCase]
        public void ParameterValidation_ErrorIfUnsupported()
        {
            //Arrange
            String Actual = "sql_variant";
            int Length = 10;
            //Act

            //Assert
            Assert.Throws<DataTypeNotSupportedException>(delegate { new SqlServerDataTypeWithLength(Actual,Length); });
        }

        [TestCase]
        public void ParameterValidation_NothingIfSupported()
        {
            //Arrange
            String Actual = "varchar";
            int Length = 10;
            //Act

            //Assert
            Assert.That(delegate { new SqlServerDataTypeWithLength(Actual,Length); }, Throws.Nothing);
        }
        
        [TestCase]
        public void Script()
        {
            //Arrange
            String Expected = "[nchar](10)";
            int Length = 10;
            //Act
            String dataType = "nchar";
            SqlServerDataTypeWithLength SqlServerDataTypeWithLength = new SqlServerDataTypeWithLength(dataType,Length);
            String Actual = SqlServerDataTypeWithLength.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ScriptWithLengthNegativeOne()
        {
            //Arrange
            String Expected = "[nchar](MAX)";
            int Length = -1;
            //Act
            String dataType = "nchar";
            SqlServerDataTypeWithLength SqlServerDataTypeWithLength = new SqlServerDataTypeWithLength(dataType, Length);
            String Actual = SqlServerDataTypeWithLength.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void Clone()
        {   //Arrange
            String dataType = "varbinary";
            int Length = 10;
            SqlServerDataTypeWithLength SqlServerDataTypeWithLengthDolly = new SqlServerDataTypeWithLength(dataType,Length);
            String Expected = SqlServerDataTypeWithLengthDolly.Script();
         
            //Act
            IDataType SqlServerDataTypeWithLengthDollyPrime = SqlServerDataTypeWithLengthDolly.Clone();
            SqlServerDataTypeWithLengthDollyPrime.DataTypeName = "datetime2";
            String Actual = SqlServerDataTypeWithLengthDollyPrime.Script();

            //Assert
            Assert.AreNotEqual(Expected, Actual);
        }
    }
}
