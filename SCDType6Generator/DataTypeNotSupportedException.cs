using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    [Serializable]
    public class DataTypeNotSupportedException : Exception
    {
        public string DataType { get; }

        public DataTypeNotSupportedException() { }

        public DataTypeNotSupportedException(string message)
            : base(message) { }

        public DataTypeNotSupportedException(string message, Exception inner)
            : base(message, inner) { }

        public DataTypeNotSupportedException(string message, string dataType)
            : this(message)
        {
            this.DataType = dataType;
        }
    }
}
