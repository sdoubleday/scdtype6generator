using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class ColumnDefaultTests
    {
        [TestCase]
        public void Script()
        {
            //Arrange
            String Expected = "(GETDATE())";
            //Act
            String defaultString = "GETDATE()";
            ColumnDefault columnDefault = new ColumnDefault(defaultString);
            String Actual = columnDefault.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }
        
        [TestCase]
        public void Clone()
        {   //Arrange
            //Arrange
            String defaultString = "GETDATE()";
            ColumnDefault columnDefaultDolly = new ColumnDefault(defaultString);
            String Expected = columnDefaultDolly.Script();

            //Act
            IColumnDefault columnDefaultDollyPrime = columnDefaultDolly.Clone();
            columnDefaultDollyPrime.columnDefaultString = "bob()";
            String Actual = columnDefaultDollyPrime.Script();

            //Assert
            Assert.AreNotEqual(Expected, Actual);
        }
    }
}
