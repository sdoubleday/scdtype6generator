﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class ReplacementPointLineProcessor_NaturalKey : LineProcessorBase
    {
        #region Constructors
        public ReplacementPointLineProcessor_NaturalKey() : base() { }
        public ReplacementPointLineProcessor_NaturalKey(String Input) : base(Input) { }
        public ReplacementPointLineProcessor_NaturalKey(String Input, ColumnListManager columnListManager) : base(Input, columnListManager) { }
        #endregion Constructors

        public override string GetLine()
        {
            StringBuilder stringBuilder = new StringBuilder();
            Boolean isFirst = true;

            this.ValidateSplitList();
            
            List<String> list = this.SplitCommentToList();
            String templateReplacementString = list[0];
            String joinString = list[1];

            foreach (IColumn column in this.columnListManager.naturalKeyColumnList.columns)
            {
                string intermediate = this.GetInputWithoutComment();
                intermediate = intermediate.Replace(templateReplacementString, column.COLUMN_NAME);
                
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