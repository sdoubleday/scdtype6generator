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

    }
}
