using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator.Tests
{
    public class FakeColumn : IColumn
    {
        public IColumnDefault COLUMN_DEFAULT { get; set; }
        public string COLUMN_NAME { get; set; }
        public IDataType DATA_TYPE { get; set; }
        public Nullability IS_NULLABLE { get; set; }
        public int ORDINAL_POSITION { get; set; }

        public IColumn Clone()
        {
            IColumn returnable = new FakeColumn();
            return returnable;
        }

        public string Script()
        {
            String returnable = "FakeColumn";
            return returnable;
        }
    }
}
