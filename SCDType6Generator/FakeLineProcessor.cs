using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class FakeLineProcessor : LineProcessorBase
    {
        #region Constructors
        public FakeLineProcessor() : base() { }
        public FakeLineProcessor(String Input) : base(Input) { }
        #endregion Constructors

        public override string GetLine()
        {
            StringBuilder stringBuilder = new StringBuilder();
            Boolean isFirst = true;

            this.ValidateSplitList();
            
            List<String> list = this.SplitCommentToList();
            String templateReplacementString = list[0];
            String joinString = list[1];

            List<String> listTestStrings = new List<String> { "Test1", "Test2", "Test3" };

            foreach (String testString in listTestStrings)
            {
                string intermediate = this.GetInputWithoutComment();
                intermediate = intermediate.Replace(templateReplacementString, testString);
                
                stringBuilder.Append(this.FormatJoinString(joinString, isFirst));
                stringBuilder.AppendLine(intermediate);
                
                isFirst = false;
            }

            return stringBuilder.ToString();
        }

        public string FormatJoinString(String joinString, bool isFirst)
        {
            string prependable = null;
            if (isFirst)
            {
                prependable = "";
            }
            else
            {
                prependable = joinString + " ";
            }
            return prependable;
        }
    }
}
