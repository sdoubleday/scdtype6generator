namespace SCDType6Generator
{
    public interface IDataType
    {
        string DataTypeName { get; set; }

        IDataType Clone();
        void ParameterValidation();
        string Script();
    }
}