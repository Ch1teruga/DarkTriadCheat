-- =========================
-- DarkTriad Library.lua
-- =========================

local Library = {}

Library.Windows = {}

local Themes = {
    RJTheme3 = {
        SchemeColor = Color3.fromRGB(150, 72, 148),
        Background = Color3.fromRGB(15,15,15),
        Header = Color3.fromRGB(15,15,15),
        TextColor = Color3.fromRGB(255,255,255),
        ElementColor = Color3.fromRGB(20,20,20)
    }
}

function Library.CreateLib(WindowName, ThemeName)
    local Window = {}
    Window.Name = WindowName
    Window.Theme = Themes[ThemeName] or Themes.RJTheme3
    Window.Tabs = {}

    function Window:NewTab(TabName)
        local Tab = {}
        Tab.Name = TabName
        Tab.Sections = {}

        function Tab:NewSection(SectionName)
            local Section = {}
            Section.Name = SectionName
            Section.Elements = {}

            function Section:NewLabel(Text)
                table.insert(self.Elements, {Type="Label", Text=Text})
            end

            function Section:NewText(Text)
                self:NewLabel(Text)
            end

            function Section:NewButton(Name, Info, Callback)
                table.insert(self.Elements, {Type="Button", Name=Name, Info=Info, Callback=Callback})
            end

            function Section:NewToggle(Name, Info, Callback)
                table.insert(self.Elements, {Type="Toggle", Name=Name, Info=Info, Callback=Callback})
            end

            function Section:NewSlider(Name, Info, Max, Min, Callback)
                table.insert(self.Elements, {Type="Slider", Name=Name, Info=Info, Max=Max, Min=Min, Callback=Callback})
            end

            function Section:NewTextBox(Name, Info, Callback)
                table.insert(self.Elements, {Type="TextBox", Name=Name, Info=Info, Callback=Callback})
            end

            function Section:NewKeybind(Name, Info, DefaultKey, Callback)
                table.insert(self.Elements, {Type="Keybind", Name=Name, Info=Info, Key=DefaultKey, Callback=Callback})
            end

            function Section:NewDropdown(Name, Info, Options, Callback)
                table.insert(self.Elements, {Type="Dropdown", Name=Name, Info=Info, Options=Options, Callback=Callback})
            end

            self.Sections[SectionName] = Section
            return Section
        end

        self.Tabs[TabName] = Tab
        return Tab
    end

    Library.Windows[WindowName] = Window
    return Window
end

return Library
