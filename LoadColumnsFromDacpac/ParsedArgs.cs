﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReadDacPacNormalDotNet
{
    public class ParsedArgs
    {
        public string DacPacFileName { get; set; }
        public string SCDType6TemplateDirectory { get; set; }
        public string SCDType6DimensionDirectory { get; set; }
        public string OutputDirectory { get; set; }
        public string DimensionSchema { get; set; }
        public string templateSchema { get; set; }

        public ParsedArgs(string[] args)
        { 
            this.DacPacFileName = args[0];
            this.SCDType6TemplateDirectory = AppDomain.CurrentDomain.BaseDirectory + "\\..\\..\\..\\SCDType6Template\\templateSchema\\";
            this.SCDType6DimensionDirectory = AppDomain.CurrentDomain.BaseDirectory + "\\..\\..\\..\\SCDType6Template\\dimensionSchema\\";
            this.OutputDirectory = args[1];
            this.DimensionSchema = args[2];
            this.templateSchema = args[3];
        }

    }
}
