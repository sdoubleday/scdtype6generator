using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SCDType6Generator
{
    public class Column
    {
#region Properties
        String COLUMN_NAME;
        int ORDINAL_POSITION;
        String COLUMN_DEFAULT;
        String IS_NULLABLE;
        SqlServerDataType DATA_TYPE;
        #endregion Properties

#region Constructors
        public Column(
             String COLUMN_NAME
            ,int ORDINAL_POSITION
            ,String COLUMN_DEFAULT
            ,String IS_NULLABLE
            , SqlServerDataType DATA_TYPE
        ) {
            this.COLUMN_NAME = COLUMN_NAME;
            this.ORDINAL_POSITION = ORDINAL_POSITION;
            this.COLUMN_DEFAULT = COLUMN_DEFAULT;
            this.IS_NULLABLE = IS_NULLABLE;
            this.DATA_TYPE = DATA_TYPE;
        }
        #endregion Constructors

        #region Methods
        #endregion Methods
    }
}
