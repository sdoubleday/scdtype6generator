﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace SCDType6Generator
{
    public class LineProcessor
    {
        #region Properties
        public String input { get; set; }
        public LineProcessorConfig lineProcessorConfig { get; set; }
        public CommentTagElements commentTagElements { get; set; }
        #endregion Properties

        #region Constructors
        public LineProcessor () {}
        public LineProcessor (String input)
        {
            this.input = input;
        }
        public LineProcessor(String input, String targetTag) : this(input)
        {
            LineProcessorConfig lineProcessorConfig = new LineProcessorConfig();
            lineProcessorConfig.targetTag = targetTag;
            this.lineProcessorConfig = lineProcessorConfig;
        }
        public LineProcessor (String input, String targetTag, List<String> perLineSubstitutions) : this(input, targetTag)
        {
            this.lineProcessorConfig.perLineSubstitutions = perLineSubstitutions;
        }
        public LineProcessor (String input, LineProcessorConfig lineProcessorConfig) : this(input)
        {
            this.lineProcessorConfig = lineProcessorConfig;
        }
        #endregion Constructors

        #region Methods
        public Boolean CheckHasComment()
        {
            Regex regex = new Regex("/\\*.*\\*/");
            Boolean returnable = regex.Match(input, 0).Success;
            return returnable;
        }

        public String GetComment()
        {
            Regex regex = new Regex("(?<=/\\*).*(?=\\*/)");
            String returnable = regex.Match(input, 0).Value;
            return returnable;
        }

        public virtual char GetSplitterChar()
        {
            char returnable = '|';
            return returnable;
        }

        public List<String> SplitCommentToList()
        {
            List<String> returnable = this.GetComment().Split(this.GetSplitterChar()).ToList<String>();
            return returnable;
        }
        
        public virtual int GetExpectedElementCount()
        {
            int returnable = 2;
            return returnable;
        }

        public void ValidateSplitList()
        {
            List<String> list = this.SplitCommentToList();
            int ExpectedElementCount = this.GetExpectedElementCount();
            if (list.Count != ExpectedElementCount)
            {
                throw new ExpectedNumberOfElementsNotFoundException("Input", ExpectedElementCount);
            }
        }

        public void PopulateCommentTagElements()
        {
            //No branching logic that I haven't already tested. Move on.
            CommentTagElements elements = new CommentTagElements();
            List<String> list = this.SplitCommentToList();
            elements.Tag = list[0];
            elements.Pattern = list[1];
            this.commentTagElements = elements;
        }

        public Boolean DetermineControlFlow_JustReturnLine()
        {
            Boolean returnable = false;
            if (!this.CheckHasComment())
            {
                returnable = true;
            }
            else
            {
                this.ValidateSplitList();
            }
            return returnable;
        }

        public string GetLine()
        {
            String returnable = "";
            if (this.DetermineControlFlow_JustReturnLine())
            {
                returnable = this.input;
            }
            else
            {
                this.PopulateCommentTagElements();
                
                if (this.lineProcessorConfig.targetTag == this.commentTagElements.Tag)
                { 
                    StringBuilder stringBuilder = new StringBuilder();
                    Boolean isFirst = true;

                    foreach (String substitution in this.lineProcessorConfig.perLineSubstitutions)
                    {
                        string intermediate = this.GetInputWithoutComment();
                        intermediate = intermediate.Replace(this.commentTagElements.Pattern, substitution);

                        //Looks like this wound up being superfluous. IF so, plan to remove it from the template as well.
                        //stringBuilder.Append(this.FormatJoinString(this.commentTagElements.JoinString, isFirst));
                        stringBuilder.AppendLine(intermediate);

                        isFirst = false;
                    }

                    returnable = stringBuilder.ToString();
                }
                else
                {
                    returnable = this.input;
                }
            }
            return returnable;
        }

        public string FormatJoinString(String joinString, bool isFirst)
        {
            string prependable = null;
            if (isFirst)
            {
                prependable = "";
            }
            else
            {
                prependable = joinString + " ";
            }
            return prependable;
        }

        public string GetInputWithoutComment()
        {
            String returnable = this.input.Replace(this.GetComment(), "");
            returnable = returnable.Replace("/**/", "").Trim();
            return returnable;
        }
        #endregion Methods

    }
}
