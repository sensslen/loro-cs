namespace LoroCs.Extensions;

public static class StringExtensions
{
    public static ContainerIdLike ToLoroContainerIdLike(this string value) =>
        new InternalContainerId(value);

    private sealed class InternalContainerId(string id) : ContainerIdLike
    {
        public ContainerId AsContainerId(ContainerType ty) => new ContainerId.Root(id, ty);
    }
}
