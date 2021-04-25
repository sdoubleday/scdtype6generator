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
            return returnable;
        }
        #endregion Methods
    }
}
