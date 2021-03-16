using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator.Tests
{
    public class FakeDataType : IDataType
    {
        public string DataTypeName { get; set; }

        public IDataType Clone()
        {
            IDataType returnable = new FakeDataType();
            return returnable;
        }

        public void ParameterValidation()
        {
            return;
        }

        public string Script()
        {
            String returnable = "FakeDataType";
            return returnable;
        }
    }
}
