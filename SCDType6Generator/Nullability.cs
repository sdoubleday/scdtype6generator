using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class Nullability
    {
        public Boolean IsNullable { get; set; }

        #region Constructors
        public Nullability (String IsNullable)
        {
            if (IsNullable.ToUpper() == "NO")
            {
                this.IsNullable = false;
            }
            else if (IsNullable.ToUpper() == "YES")
            {
                this.IsNullable = true;
            }
            else
            {
                throw new NullabilityParameterException("Provided value was not supported. String YES for true, NO for false. Or try boolean or int.");
            }
        }

        public Nullability (int IsNullable)
        {
            if(IsNullable == 0)
            {
                this.IsNullable = false;
            }
            else if(IsNullable == 1)
            {
                this.IsNullable = true;
            }
            else
            {
                throw new NullabilityParameterException("Provided value was not supported. Int 1 for true, 0 for false. Or try boolean or string.");
            }
        }

        public Nullability (Boolean IsNullable)
        {
            this.IsNullable = IsNullable;
        }
        #endregion Constructors

        public Nullability Clone()
        {
            Nullability returnable = new Nullability(this.IsNullable);
            return returnable;
        }

        public String Script()
        {
            String returnable = "";
            if(this.IsNullable)
            {
                returnable = "NULL";
            }
            else
            {
                returnable = "NOT NULL";
            }
            return returnable;
        }

    }
}
