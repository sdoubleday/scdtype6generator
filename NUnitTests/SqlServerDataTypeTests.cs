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
            SqlServerDataType sqlServerDataType = new SqlServerDataType(Actual);
            //Assert
            Assert.Throws<System.ArgumentOutOfRangeException>(delegate { sqlServerDataType.ParameterValidation(); });
        }

        [TestCase]
        public void ParameterValidation_ErrorIfUnsupported()
        {
            //Arrange
            String Actual = "sql_variant";
            //Act
            SqlServerDataType sqlServerDataType = new SqlServerDataType(Actual);
            //Assert
            Assert.Throws<System.ArgumentOutOfRangeException>(delegate { sqlServerDataType.ParameterValidation(); });
        }

        [TestCase]
        public void ParameterValidation_NothingIfSupported()
        {
            //Arrange
            String Actual = "smallmoney";
            //Act
            SqlServerDataType sqlServerDataType = new SqlServerDataType(Actual);
            //Assert
            Assert.That(delegate { sqlServerDataType.ParameterValidation(); }, Throws.Nothing);
        }
    }
}
