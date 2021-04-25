using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class LineParserTests
    {
        [TestCase]
        public void DetermineControlFlow_JustReturnLine__TrueIfNoSQLBlockComment()
        {
            //Arrange
            Boolean Expected = true;
            String Input = "A String asdf";
            LineParser lineParser = new LineParser(Input);
            
            //Act
            Boolean Actual = lineParser.DetermineControlFlow_JustReturnLine();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void DetermineControlFlow_JustReturnLine__ExceptionIfHasSQLBlockCommentButNoSplitChar()
        {
            //Arrange
            String Input = "A String /*SqlComment*/ asdf";
            LineParser lineParser = new LineParser(Input);
            //Act

            //Assert
            Assert.Throws<ExpectedNumberOfElementsNotFoundException>(delegate { lineParser.DetermineControlFlow_JustReturnLine(); });
        }

        [TestCase]
        public void DetermineControlFlow_JustReturnLine__FalseIfPassesValidation()
        {
            //Arrange
            Boolean Expected = false;
            String Input = "A String /*Sql^Comment*/ asdf";
            LineParser lineParser = new LineParser(Input);
            //Act
            Boolean Actual = lineParser.DetermineControlFlow_JustReturnLine();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        [TestCase]
        public void GetSplitterChar()
        {
            //Arrange
            char Expected = '^';
            LineParser lineParser = new LineParser();
            //Act
            char Actual = lineParser.GetSplitterChar();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }
    }
}
