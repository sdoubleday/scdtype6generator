using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

namespace SCDType6Generator
{
    public class CommentTagProcessor
    {
        public String OriginalInput { get; set; }
        public Boolean IsColumnListReplacementPoint { get; set; }
        public CommentTagElements commentTagElements { get; set; }

        public CommentTagProcessor() { }

        public CommentTagProcessor(String Input)
        {
            this.OriginalInput = Input;
            if (! this.HasCommentBlock(this.OriginalInput))
            {
                this.IsColumnListReplacementPoint = false;
            }

        }

        public void Set_IsColumnListReplacementPoint()
        {

        }

        public void Set_ColumnListType()
        {

        }

        public void Set_CommentTag()
        {

        }

        public CommentTagElements SplitTagToElements()
        {
            //use CheckCommentBlockFormattedAsExpected
            //if passes then split on pipe to array
            //then check to make sure first element is in the enum
            //error if not
            //need method for that ^^
            //then assign elements to the object VV
            CommentTagElements returnable = new CommentTagElements();
            return returnable;
        }

        public Boolean HasCommentBlock(String Input)
        {
            Regex regex = new Regex("/\\*.*\\*/");
            Boolean returnable = regex.Match(Input,0).Success;
            return returnable;
        }

        public String GetCommentBlock(String Input)
        {
            Regex regex = new Regex("(?<=/\\*).*(?=\\*/)");
            String returnable = regex.Match(Input, 0).Value;
            return returnable;
        }
        public Boolean CheckCommentBlockIsPipeDelimited(String Input)
        {
            String CommentBlock = this.GetCommentBlock(Input);
            Regex regex = new Regex(".*\\|.*\\|.*\\|.*");
            Boolean returnable = regex.Match(Input,0).Success;
            return returnable;
        }
        //check for first thing says "ReplacementPoint"
        //Then check for second element is in the ENUM


        public String GetPattern()
        {
            String returnable = "";
            return returnable;
        }

        public String GetJoinString()
        {
            String returnable = "";
            return returnable;
        }

        public String GetInputWithoutComment()
        {
            String returnable = "";
            return returnable;
        }
    }
}
