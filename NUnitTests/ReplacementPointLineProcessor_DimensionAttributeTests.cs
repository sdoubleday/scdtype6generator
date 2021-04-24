using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class ReplacementPointLineProcessor_DimensionAttributeTests
    {
        [TestCase]
        public void GetLine()
        {
            //I am already worried about what's getting passed here as input. The LineParser will do something - will it extract the enum from the comment?
            //I guess it might have to. Not the worst idea.
            //I need a column list, clearly. And another for natural key, since I want to prove we use the right one and only that one.

            //Arrange
            String Input = "a.SampleString = b.SampleString /*SampleString|AND*/";
            IColumn fakeColumn_Dim1 = new FakeColumn();
            fakeColumn_Dim1.COLUMN_NAME = "DimFake1";
            IColumn fakeColumn_Dim2 = new FakeColumn();
            fakeColumn_Dim2.COLUMN_NAME = "DimFake2";
            IColumn fakeColumn_Dim3 = new FakeColumn();
            fakeColumn_Dim3.COLUMN_NAME = "DimFake3";
            IColumn fakeColumn_NK1 = new FakeColumn();
            fakeColumn_NK1.COLUMN_NAME = "NK_Fake1";
            IColumn fakeColumn_NK2 = new FakeColumn();
            fakeColumn_NK2.COLUMN_NAME = "NK_Fake2";
            IColumn fakeColumn_NK3 = new FakeColumn();
            fakeColumn_NK3.COLUMN_NAME = "NK_Fake3";
            List<IColumn> listDim = new List<IColumn> { fakeColumn_Dim1, fakeColumn_Dim2, fakeColumn_Dim3};
            List<IColumn> listNK = new List<IColumn> { fakeColumn_NK1, fakeColumn_NK2, fakeColumn_NK3 };
            ColumnList columnList_Dim = new ColumnList(listDim);
            ColumnList columnList_NK = new ColumnList(listNK);
            ColumnListManager columnListManager = new ColumnListManager();
            columnListManager.dimensionalAttributeColumnList = columnList_Dim;
            columnListManager.naturalKeyColumnList = columnList_NK;
            ReplacementPointLineProcessor_DimensionAttribute rplp_DimensionAttribute = new ReplacementPointLineProcessor_DimensionAttribute(Input, columnListManager);

            String Expected = "a.DimFake1 = b.DimFake1" +
                "\r\nAND a.DimFake2 = b.DimFake2" +
                "\r\nAND a.DimFake3 = b.DimFake3";

            //Act
            String Actual = rplp_DimensionAttribute.GetLine();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }
    }
}
