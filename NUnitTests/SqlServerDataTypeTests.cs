using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class SqlServerDataTypeTests
    {
        [TestCase]
        public void ParameterValidation_ErrorIfNotOnList()
        {
            //Arrange
            String Actual = "NotADataType";
            //Act

            //Assert
            Assert.Throws<DataTypeNotRecognizedException>(delegate { new SqlServerDataType(Actual); });
        }

        [TestCase]
        public void ParameterValidation_ErrorIfUnsupported()
        {
            //Arrange
            String Actual = "sql_variant";
            //Act

            //Assert
            Assert.Throws<DataTypeNotSupportedException>(delegate { new SqlServerDataType(Actual); });
        }

        [TestCase]
        public void ParameterValidation_NothingIfSupported()
        {
            //Arrange
            String Actual = "int";
            //Act

            //Assert
            Assert.That(delegate { new SqlServerDataType(Actual); }, Throws.Nothing);
        }
    }
}
