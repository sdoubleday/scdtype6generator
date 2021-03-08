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
        int CHARACTER_MAXIMUM_LENGTH;// int Maximum length, in characters, for binary data, character data, or text and image data.
            //-1 for xml and large-value type data.Otherwise, NULL is returned.For more information, see Data Types(Transact-SQL).
        int CHARACTER_OCTET_LENGTH; //int Maximum length, in bytes, for binary data, character data, or text and image data.
        //-1 for xml and large-value type data.Otherwise, NULL is returned.
        int NUMERIC_PRECISION;// tinyint Precision of approximate numeric data, exact numeric data, integer data, or monetary data.Otherwise, NULL is returned.
        int NUMERIC_PRECISION_RADIX;// smallint    Precision radix of approximate numeric data, exact numeric data, integer data, or monetary data.Otherwise, NULL is returned.
        int NUMERIC_SCALE;//   int Scale of approximate numeric data, exact numeric data, integer data, or monetary data.Otherwise, NULL is returned.
        int DATETIME_PRECISION;// smallint
        #endregion Properties

#region Constructors
        public Column(
             String COLUMN_NAME
            ,int ORDINAL_POSITION
            ,String COLUMN_DEFAULT
            ,String IS_NULLABLE
            , SqlServerDataType DATA_TYPE
            ,int CHARACTER_MAXIMUM_LENGTH
            ,int CHARACTER_OCTET_LENGTH
            ,int NUMERIC_PRECISION
            ,int NUMERIC_PRECISION_RADIX
            ,int NUMERIC_SCALE
            ,int DATETIME_PRECISION
        ) {
            this.COLUMN_NAME = COLUMN_NAME;
            this.ORDINAL_POSITION = ORDINAL_POSITION;
            this.COLUMN_DEFAULT = COLUMN_DEFAULT;
            this.IS_NULLABLE = IS_NULLABLE;
            this.DATA_TYPE = DATA_TYPE;
            this.CHARACTER_MAXIMUM_LENGTH = CHARACTER_MAXIMUM_LENGTH;
            this.CHARACTER_OCTET_LENGTH = CHARACTER_OCTET_LENGTH;
            this.NUMERIC_PRECISION = NUMERIC_PRECISION;
            this.NUMERIC_PRECISION_RADIX = NUMERIC_PRECISION_RADIX;
            this.NUMERIC_SCALE = NUMERIC_SCALE;
            this.DATETIME_PRECISION = DATETIME_PRECISION;
        }
        #endregion Constructors

        #region Methods
        #endregion Methods
    }
}
