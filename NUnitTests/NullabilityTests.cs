using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace SCDType6Generator.Tests
{
    [TestFixture]
    public class NullabilityTests
    {
        [TestCase]
        public void ConstructorIntOutOfBoundsLow()
        {
            //Arrange
            int IsNullable = -1;
            //Act

            //Assert
            Assert.Throws<NullabilityParameterException>(delegate { new Nullability(IsNullable); });
        }
        
        [TestCase]
        public void ConstructorIntOutOfBoundsHigh()
        {
            //Arrange
            int IsNullable = 2;
            //Act

            //Assert
            Assert.Throws<NullabilityParameterException>(delegate { new Nullability(IsNullable); });
        }
        
        [TestCase]
        public void ConstructorInt0EqualsFalse()
        {
            //Arrange
            int IsNullable = 0;
            Boolean Expected = false;
            //Act
            Nullability nullability = new Nullability(IsNullable);
            Boolean Actual = nullability.IsNullable;
            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ConstructorInt1EqualsTrue()
        {
            //Arrange
            int IsNullable = 1;
            Boolean Expected = true;
            //Act
            Nullability nullability = new Nullability(IsNullable);
            Boolean Actual = nullability.IsNullable;
            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ConstructorStringEmpty()
        {
            //Arrange
            String IsNullable = "";
            //Act

            //Assert
            Assert.Throws<NullabilityParameterException>(delegate { new Nullability(IsNullable); });
        }

        [TestCase]
        public void ConstructorStringNotYesOrNo()
        {
            //Arrange
            String IsNullable = "Fred";
            //Act

            //Assert
            Assert.Throws<NullabilityParameterException>(delegate { new Nullability(IsNullable); });
        }

        [TestCase]
        public void ConstructorStringNoEqualsFalse()
        {
            //Arrange
            String IsNullable = "no";
            Boolean Expected = false;
            //Act
            Nullability nullability = new Nullability(IsNullable);
            Boolean Actual = nullability.IsNullable;
            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ConstructorStringYesEqualsTrue()
        {
            //Arrange
            String IsNullable = "Yes";
            Boolean Expected = true;
            //Act
            Nullability nullability = new Nullability(IsNullable);
            Boolean Actual = nullability.IsNullable;
            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ConstructorBooleanFalseEqualsFalse()
        {
            //Arrange
            Boolean IsNullable = false;
            Boolean Expected = false;
            //Act
            Nullability nullability = new Nullability(IsNullable);
            Boolean Actual = nullability.IsNullable;
            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ConstructorBooleanEqualsTrue()
        {
            //Arrange
            Boolean IsNullable = true;
            Boolean Expected = true;
            //Act
            Nullability nullability = new Nullability(IsNullable);
            Boolean Actual = nullability.IsNullable;
            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ScriptNotNullable()
        {
            //Arrange
            String Expected = "NOT NULL";
            //Act
            Boolean IsNullable = false;
            Nullability Nullability = new Nullability(IsNullable);
            String Actual = Nullability.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void ScriptNullable()
        {
            //Arrange
            String Expected = "NULL";
            //Act
            Boolean IsNullable = true;
            Nullability Nullability = new Nullability(IsNullable);
            String Actual = Nullability.Script();

            //Assert
            Assert.AreEqual(Expected, Actual);
        }

        [TestCase]
        public void Clone()
        {   //Arrange
            String IsNullable = "Yes";
            Nullability NullabilityDolly = new Nullability(IsNullable);
            String Expected = NullabilityDolly.Script();

            //Act
            Nullability NullabilityDollyPrime = NullabilityDolly.Clone();
            NullabilityDollyPrime.IsNullable = false;
            String Actual = NullabilityDollyPrime.Script();

            //Assert
            Assert.AreNotEqual(Expected, Actual);
        }
    }
}
