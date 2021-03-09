using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    [Serializable]
    public class DataTypeNotRecognizedException : Exception
    {
        public string DataType { get; }

        public DataTypeNotRecognizedException() { }

        public DataTypeNotRecognizedException(string message)
            : base(message) { }

        public DataTypeNotRecognizedException(string message, Exception inner)
            : base(message, inner) { }

        public DataTypeNotRecognizedException(string message, string dataType)
            : this(message)
        {
            this.DataType = dataType;
        }
    }
}
