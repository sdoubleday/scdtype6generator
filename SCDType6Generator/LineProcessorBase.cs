﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace SCDType6Generator
{
    public class LineProcessorBase
    {
        #region Properties
        public String Input { get; set; }
        public ColumnListManager columnListManager { get; set; }
        #endregion Properties

        #region Constructors
        public LineProcessorBase () {}
        public LineProcessorBase (String Input)
        {
            this.Input = Input;
        }
        public LineProcessorBase (String Input, ColumnListManager columnListManager) : this(Input)
        {
            this.columnListManager = columnListManager;
        }
        #endregion Constructors

        #region Methods
        public Boolean ConfirmHasComment()
        {
            Regex regex = new Regex("/\\*.*\\*/");
            Boolean returnable = regex.Match(Input, 0).Success;
            if(! returnable)
            {
                throw new ExpectedSqlCommentNotFoundException();
            }
            return returnable;
        }

        public String GetComment()
        {
            Regex regex = new Regex("(?<=/\\*).*(?=\\*/)");
            String returnable = regex.Match(Input, 0).Value;
            return returnable;
        }

        public virtual char GetSplitterChar()
        {
            char returnable = '|';
            return returnable;
        }

        public List<String> SplitToList()
        {
            List<String> returnable = Input.Split(this.GetSplitterChar()).ToList<String>();
            return returnable;
        }
        
        public virtual int GetExpectedElementCount()
        {
            int returnable = 2;
            return returnable;
        }

        public void ValidateSplitList()
        {
            List<String> list = this.SplitToList();
            int ExpectedElementCount = this.GetExpectedElementCount();
            if (list.Count != ExpectedElementCount)
            {
                throw new ExpectedNumberOfElementsNotFoundException("Input", ExpectedElementCount);
            }
        }

        public virtual String GetLine()
        {
            throw new NotImplementedException();
        }
        #endregion Methods

    }
}
