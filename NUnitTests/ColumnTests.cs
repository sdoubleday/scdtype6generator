using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class ColumnTests
    {
        [TestCase]
        public void Script()
        {
            //Arrange
            String ColumnName = "ColumnName";
            int OrdinalPosition = 1;
            IDataType dataType = new FakeDataType();
            IColumnDefault columnDefault = new FakeColumnDefault();
            Nullability nullability = new Nullability("NO");
            String Expected = "ColumnName FakeDataType NOT NULL FakeColumnDefault";
            //Act
            Column column = new Column(ColumnName,OrdinalPosition,columnDefault,nullability,dataType);
            String Actual = column.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }
        
        [TestCase]
        public void Clone()
        {   //Arrange
            String ColumnName = "ColumnName";
            int OrdinalPosition = 1;
            IDataType dataType = new FakeDataType();
            IColumnDefault columnDefault = new FakeColumnDefault();
            Nullability nullability = new Nullability("NO");
            String Expected = "ColumnName FakeDataType NOT NULL FakeColumnDefault";
            //Act
            Column ColumnDolly = new Column(ColumnName,OrdinalPosition,columnDefault,nullability,dataType);
            IColumn ColumnDollyPrime = ColumnDolly.Clone();
            ColumnDollyPrime.COLUMN_NAME = "NotExpected";
            String Actual = ColumnDollyPrime.Script();

            //Assert
            Assert.AreNotEqual(Expected, Actual);
        }
    }
}
