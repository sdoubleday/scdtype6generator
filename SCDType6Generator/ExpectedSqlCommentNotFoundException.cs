using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    [Serializable]
    public class ExpectedSqlCommentNotFoundException : Exception
    {
        public ExpectedSqlCommentNotFoundException()
        {
        }

        public ExpectedSqlCommentNotFoundException(string message) : base(message)
        {
        }

        public ExpectedSqlCommentNotFoundException(string message, Exception innerException) : base(message, innerException)
        {
        }

        protected ExpectedSqlCommentNotFoundException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
