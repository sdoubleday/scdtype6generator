using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

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
            List<String> list = this.SplitToList();
            StringBuilder stringBuilder = new StringBuilder();
            Regex regex = new Regex(list[0]);
            int i = 0;
            foreach (IColumn column in this.columnListManager.dimensionalAttributeColumnList.columns)
            {
                if(i > 0)
                {
                    stringBuilder.Append(list[1]);
                }
                stringBuilder.AppendLine( regex.Replace(this.Input, column.COLUMN_NAME) );
                i++;
            }

            return stringBuilder.ToString();
        }

    }
}
