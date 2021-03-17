using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class Column : IColumn
    {
        #region Properties
        public String COLUMN_NAME { get; set; }
        public int ORDINAL_POSITION { get; set; }
        public IColumnDefault COLUMN_DEFAULT { get; set; }
        public Nullability IS_NULLABLE { get; set; }
        public IDataType DATA_TYPE { get; set; }
        #endregion Properties

        #region Constructors
        public Column(
             String COLUMN_NAME
            , int ORDINAL_POSITION
            , IColumnDefault COLUMN_DEFAULT
            , Nullability IS_NULLABLE
            , IDataType DATA_TYPE
        )
        {
            this.COLUMN_NAME = COLUMN_NAME;
            this.ORDINAL_POSITION = ORDINAL_POSITION;
            this.COLUMN_DEFAULT = COLUMN_DEFAULT;
            this.IS_NULLABLE = IS_NULLABLE;
            this.DATA_TYPE = DATA_TYPE;
        }
        #endregion Constructors

        #region Methods
        public IColumn Clone()
        {
            IColumn returnable = new Column(
                 this.COLUMN_NAME
                , this.ORDINAL_POSITION
                , this.COLUMN_DEFAULT.Clone()
                , this.IS_NULLABLE.Clone()
                , this.DATA_TYPE.Clone()
                );
            return returnable;
        }

        public String Script()
        {
            String returnable =
                COLUMN_NAME + " " +
                DATA_TYPE.Script() + " " +
                IS_NULLABLE.Script() + " " +
                COLUMN_DEFAULT.Script();
            return returnable;

        }
        #endregion Methods
    }
}
