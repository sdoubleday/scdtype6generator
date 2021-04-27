using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public enum LineProcessorTypeEnum : ushort
    {
        ReplacementPointLineProcessor_DimensionAttribute = 0
        ,FakeLineProcessor = 1
        ,ReplacementPointLineProcessor_NaturalKey = 2
    }
}
