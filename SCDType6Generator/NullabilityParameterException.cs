using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    [Serializable]
    public class NullabilityParameterException : Exception
    {
        public string DataType { get; }

        public NullabilityParameterException() { }

        public NullabilityParameterException(string message)
            : base(message) { }

        public NullabilityParameterException(string message, Exception inner)
            : base(message, inner) { }

    }
}
