namespace SCDType6Generator
{
    public interface IColumn
    {
        IColumnDefault COLUMN_DEFAULT { get; set; }
        string COLUMN_NAME { get; set; }
        IDataType DATA_TYPE { get; set; }
        Nullability IS_NULLABLE { get; set; }
        int ORDINAL_POSITION { get; set; }

        IColumn Clone();
        string Script();
    }
}