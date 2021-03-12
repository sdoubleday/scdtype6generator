namespace SCDType6Generator
{
    public interface IDataType
    {
        string DataTypeName { get; set; }

        SqlServerDataType Clone();
        void ParameterValidation();
        string Script();
    }
}