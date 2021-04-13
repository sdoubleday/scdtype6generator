using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class CommentTagProcessorTests
    {
        [TestCase]
        public void HasCommentBlock_TrueIfHasSQLBlockComment()
        {
            //Arrange
            Boolean Expected = true;
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor();
            //Act
            String Input = "A String /*SqlComment*/ asdf";
            Boolean Actual = commentTagProcessor.HasCommentBlock(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void HasCommentBlock_FalseIfHasSQLLineComment()
        {
            //Arrange
            Boolean Expected = false;
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor();
            //Act
            String Input = "A String --SqlComment asdf";
            Boolean Actual = commentTagProcessor.HasCommentBlock(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void HasCommentBlock_FalseIfNoSQLComment()
        {
            //Arrange
            Boolean Expected = false;
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor();
            //Act
            String Input = "A String //NotASqlComment";
            Boolean Actual = commentTagProcessor.HasCommentBlock(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void GetCommentBlock()
        {
            //Arrange
            String Expected = "SqlComm*en/t";
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor();
            //Act
            String Input = "A String /*SqlComm*en/t*/ asdf";
            String Actual = commentTagProcessor.GetCommentBlock(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void CheckCommentBlockIsPipeDelimited_FalseIfNot()
        {
            //Arrange
            Boolean Expected = false;
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor();
            //Act
            String Input = "aaaaaaa";
            Boolean Actual = commentTagProcessor.CheckCommentBlockIsPipeDelimited(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void CheckCommentBlockIsPipeDelimited_TrueIfSo()
        {
            //Arrange
            Boolean Expected = true;
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor();
            //Act
            String Input = "aaa|asf|adfasdf|aaaa";
            Boolean Actual = commentTagProcessor.CheckCommentBlockIsPipeDelimited(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void Constructor_WithInputNoComment_SetsFlagToFalse()
        {
            //Arrange
            String Input = "blah";
            Boolean Expected = false;

            //Act
            CommentTagProcessor commentTagProcessor = new CommentTagProcessor(Input);
            Boolean Actual = commentTagProcessor.IsColumnListReplacementPoint;

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void GetListFromPipeDelimitedCommentBlock_ReturnsListSplitOnPipe()
        {
            //Arrange
            List<String> Expected = new List<String> { "a", "bbb", "cccc" };
            String Input = "a|bbb|cccc";
            CommentTagProcessor sut = new CommentTagProcessor();

            //Act
            List<String> Actual = sut.GetListFromPipeDelimitedCommentBlock(Input);

            //Assert
            Assert.AreEqual(Expected, Actual);
        }
    }
}
