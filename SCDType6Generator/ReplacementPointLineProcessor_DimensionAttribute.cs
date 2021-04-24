using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class ReplacementPointLineProcessor_DimensionAttribute : LineProcessorBase
    {
        #region Constructors
        public ReplacementPointLineProcessor_DimensionAttribute() : base() { }
        public ReplacementPointLineProcessor_DimensionAttribute(String Input) : base(Input) { }
        public ReplacementPointLineProcessor_DimensionAttribute(String Input, ColumnListManager columnListManager) : base(Input, columnListManager) { }
        #endregion Constructors

        public override string GetLine()
        {
            //This should PROBABLY get picked apart into more methods and stuff...

            this.ValidateSplitList();
            List<String> list = this.SplitCommentToList();
            StringBuilder stringBuilder = new StringBuilder();

            int i = 0;
            foreach (IColumn column in this.columnListManager.dimensionalAttributeColumnList.columns)
            {
                if(i > 0)
                {
                    stringBuilder.Append(list[1]);
                    stringBuilder.Append(" ");
                }
                String intermediate = this.Input.Replace(this.GetComment(), "");
                intermediate = intermediate.Replace("/**/", "");
                intermediate = intermediate.Replace(list[0], column.COLUMN_NAME);
                stringBuilder.AppendLine( intermediate.Trim() );
                i++;
            }

            return stringBuilder.ToString();
        }

    }
}
