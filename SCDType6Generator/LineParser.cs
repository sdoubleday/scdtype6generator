using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace SCDType6Generator
{
    public class LineParser : LineProcessorBase
    {
        #region Constructors
        public LineParser() : base() { }
        public LineParser(String Input) : base(Input) { }
        public LineParser(String Input, ColumnListManager columnListManager) : base(Input, columnListManager) { }
        #endregion Constructors


        #region Methods
        public override char GetSplitterChar()
        {
            char returnable = '^';
            return returnable;
        }
        
        public Boolean DetermineControlFlow_JustReturnLine()
        {
            Boolean returnable = false;
            if(!this.CheckHasComment())
            {
                returnable = true;
            }
            else
            {
                this.ValidateSplitList();
            }
            return returnable;
        }

        public override String GetLine()
        {
            String returnable = "";
            if (this.DetermineControlFlow_JustReturnLine())
            {
                returnable = this.Input;
            }
            else
            {
                List<String> list = this.SplitCommentToList();
                String lineProcessorTypeString = list[0];
                String inputMinus_lineProcessorTypeString = this.Input.Replace(lineProcessorTypeString, "").Replace("^", "");
                LineProcessorTypeEnum lineProcessorTypeEnum;
                Boolean parseSuccess = Enum.TryParse<LineProcessorTypeEnum>(list[0], out lineProcessorTypeEnum);

                if(lineProcessorTypeEnum == LineProcessorTypeEnum.ReplacementPointLineProcessor_DimensionAttribute)
                {
                    ReplacementPointLineProcessor_DimensionAttribute rplp_DimensionAttribute = new ReplacementPointLineProcessor_DimensionAttribute(inputMinus_lineProcessorTypeString, columnListManager);
                    returnable = rplp_DimensionAttribute.GetLine();
                }
                else if (lineProcessorTypeEnum == LineProcessorTypeEnum.FakeLineProcessor)
                {
                    FakeLineProcessor fakeLineProcessor = new FakeLineProcessor(inputMinus_lineProcessorTypeString);
                    returnable = fakeLineProcessor.GetLine();
                }
                else
                {
                    throw new NotImplementedException(); //This should probably be a specific control flow error.
                }

            }
            return returnable;
        }
        #endregion Methods
    }
}
