using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    public class FakeLineProcessorBase : LineProcessorBase { 
        public FakeLineProcessorBase (String Input) : base(Input)
        { }
        public override char GetSplitterChar()
        {
            char returnable = ',';
            return returnable;
        }
        public override int GetExpectedElementCount()
        {
            int returnable = 3;
            return returnable;
        }

    }

    [TestFixture]
    public class LineProcessorBaseTests
    {
        [TestCase]
        public void ConfirmHasComment_TrueIfHasSQLBlockComment()
        {
            //Arrange
            Boolean Expected = true;
            String Input = "A String /*SqlComment*/ asdf";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);
            
            //Act
            Boolean Actual = lineProcessorBase.ConfirmHasComment();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ConfirmHasComment_ExceptionIfHasSQLLineComment()
        {
            //Arrange
            String Input = "A String --SqlComment asdf";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);
            //Act

            //Assert
            Assert.Throws<ExpectedSqlCommentNotFoundException>(delegate { lineProcessorBase.ConfirmHasComment(); });
        }

        [TestCase]
        public void ConfirmHasComment_ExceptionIfNoSQLComment()
        {
            //Arrange
            String Input = "A String //NotASqlComment";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);
            //Act

            //Assert
            Assert.Throws<ExpectedSqlCommentNotFoundException>(delegate { lineProcessorBase.ConfirmHasComment(); });
        }

        [TestCase]
        public void GetComment()
        {
            //Arrange
            String Expected = "SqlComm*en/t";
            String Input = "A String /*SqlComm*en/t*/ asdf";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);
            //Act
            String Actual = lineProcessorBase.GetComment();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void SplitToList_ReturnsListSplitOnPipe()
        {
            //Arrange
            List<String> Expected = new List<String> { "a", "bbb", "cccc" };
            String Input = "a|bbb|cccc";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);

            //Act
            List<String> Actual = lineProcessorBase.SplitToList();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void SplitToList_Uses_GetSplitterChar()
        {
            //Arrange
            List<String> Expected = new List<String> { "a", "bbb", "cccc" };
            String Input = "a,bbb,cccc";
            FakeLineProcessorBase lineProcessorBase = new FakeLineProcessorBase(Input);

            //Act
            List<String> Actual = lineProcessorBase.SplitToList();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ValidateSplitList_NothingIfValid()
        {
            //Arrange
            String Input = "a|bbb";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);
            //Act

            //Assert
            Assert.That(delegate { lineProcessorBase.ValidateSplitList(); }, Throws.Nothing);
        }

        [TestCase]
        public void ValidateSplitList_ExceptionIfNotValid()
        {
            //Arrange
            String Input = "a|bbb|ccc";
            LineProcessorBase lineProcessorBase = new LineProcessorBase(Input);
            //Act

            //Assert
            Assert.Throws<ExpectedNumberOfElementsNotFoundException>(delegate { lineProcessorBase.ValidateSplitList(); });
        }

        [TestCase]
        public void ValidateSplitList_Uses_GetExpectedElementCount()
        {
            //Arrange
            String Input = "a|bbb";
            FakeLineProcessorBase lineProcessorBase = new FakeLineProcessorBase(Input);
            int Expected = 3;
            //Act

            //Assert
            ExpectedNumberOfElementsNotFoundException ex = Assert.Throws<ExpectedNumberOfElementsNotFoundException>(delegate { lineProcessorBase.ValidateSplitList(); });
            int Actual = ex.ExpectedElementCount;
            Assert.AreEqual(Expected, Actual);
        }
    }
}
