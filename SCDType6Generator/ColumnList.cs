using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class ColumnList
    {
        public List<IColumn> columns;
        String separator;

        #region Constructors
        public ColumnList (List<IColumn> columns)
        {
            this.columns = columns;
            this.separator = System.Environment.NewLine + ",";
        }
        public ColumnList(List<IColumn> columns, String separator)
        {
            this.columns = columns;
            this.separator = separator;
        }
        #endregion Constructors

        public ColumnList Clone() {
            ColumnList returnable = new ColumnList(this.columns, this.separator);
            return returnable;
        }

        public String Script()
        {
            String returnable = "";
            foreach (IColumn column in this.columns)
            {
                returnable = returnable + column.Script() + this.separator;
            }
            return returnable;
        }

    }
}
