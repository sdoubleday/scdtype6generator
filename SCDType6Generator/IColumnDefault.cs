namespace SCDType6Generator
{
    public interface IColumnDefault
    {
        string columnDefaultString { get; set; }

        IColumnDefault Clone();
        string Script();
    }
}