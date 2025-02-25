local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node


return {
    s("axaml", {
        t({ '<UserControl xmlns="https://github.com/avaloniaui"', 
            '             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"', 
            '             x:Class="' }), i(1, "MyAvaloniaApp.Views.MyControl"), t({ '">', 
            "    <StackPanel>", 
            '        <TextBlock Text="' }), i(2, "Hello World!"), t({ '" />',
            '        <Button Content="Click Me" Click="OnButtonClick"/>', 
            "    </StackPanel>", 
            "</UserControl>" })
    }),

    s("axamlcs", {
        t({ 'using Avalonia.Controls;', 
            'using Avalonia.Interactivity;', '', 
            'namespace ' }), i(1, "MyAvaloniaApp.Views"), t({ ' {', 
            '    public partial class ' }), i(2, "MyControl"), t({ ' : UserControl', 
            '    {', 
            '        public ' }), i(2), t({ '()', 
            '        {', 
            '            InitializeComponent();', 
            '        }', '', 
            '        private void OnButtonClick(object? sender, RoutedEventArgs e)', 
            '        {', 
            '            var messageBox = new Window', 
            '            {', 
            '                Content = new TextBlock { Text = "' }), i(3, "Button Clicked!"), t({ '",', 
            '                HorizontalAlignment = Avalonia.Layout.HorizontalAlignment.Center,', 
            '                VerticalAlignment = Avalonia.Layout.VerticalAlignment.Center', 
            '            },', 
            '            Width = 200,', 
            '            Height = 100', 
            '            };', 
            '            messageBox.Show();', 
            '        }', 
            '    }', 
            '}' })
    }),
}
