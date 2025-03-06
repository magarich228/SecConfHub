using Avalonia.Controls;

namespace SecConfHub.Desktop
{
    internal static class WindowSizeHelper
    {
        public static void SizeTo(this Window source, Window target)
        {
            source.Position = target.Position;
            source.Width = target.Width;
            source.Height = target.Height;
        }
    }
}
