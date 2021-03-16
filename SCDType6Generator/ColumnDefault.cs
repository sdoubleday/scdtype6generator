using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class ColumnDefault : IColumnDefault
    {
        public String columnDefaultString { get; set; }

        public ColumnDefault(String columnDefaultString)
        {
            this.columnDefaultString = columnDefaultString;
        }

        public IColumnDefault Clone()
        {
            IColumnDefault returnable = new ColumnDefault(this.columnDefaultString);
            return returnable;
        }

        public String Script()
        {
            String returnable = "(" + this.columnDefaultString + ")";
            return returnable;
        }

    }
}
