using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator.Tests
{
    public class FakeColumnDefault : IColumnDefault
    {
        public string columnDefaultString { get; set; }

        public IColumnDefault Clone()
        {
            IColumnDefault returnable = new FakeColumnDefault();
            return returnable;
        }

        public string Script()
        {
            String returnable = "FakeColumnDefault";
            return returnable;
        }
    }
}
