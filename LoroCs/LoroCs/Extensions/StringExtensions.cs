namespace LoroCs.Extensions;

public static class StringExtensions
{
    public static LoroValueLike ToLoroValueLike(this LoroValue value) => new ValueLike(value);

    private sealed class ValueLike(LoroValue value) : LoroValueLike
    {
        public LoroValue AsLoroValue() => value;
    }
}
