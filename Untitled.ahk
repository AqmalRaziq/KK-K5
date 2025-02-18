Gui, +AlwaysOnTop
Gui, Add, Text,, ============Roblox Virtual Piano In-Game Styled Autoplayer (v 1.1)============
Gui, Add, Text,, -----------------------------------------------PASTE SHEETS HERE------------------------------------------------
Gui, Add, Edit, R10 w400 vPianoMusic
Gui, Add, Text,, Press the - = [ ] keybinds to start autoplaying. you'll need to play by rhythm.
Gui, Add, Text,, Click the "Reset" button after playing a song/changing a song. (IMPORTANT)
Gui, Add, Text,, Based on the old AutoHotkey Virtual Piano Autoplayer (the one with F4 and F8)
Gui, Add, Text,, This also works in Virtual Pianos outside of Roblox.
Gui, Add, Text,, Modifications done by: Crimsxn K1ra
Gui, Add, Text,, ------------------------------------------------------------Progress------------------------------------------------------------
Gui, Add, Edit, ReadOnly w400 vNextNotes
Gui, Add, Button, gResetProgress, Reset
Gui, Show

PianoMusic := ""
CurrentPos := 1
DisplayPos := 1
KeyPressStartTime := 0
KeyDelay := 0.1

PlayNextNote()
{
    global PianoMusic, CurrentPos, DisplayPos, KeyDelay, KeyPressStartTime
    Gui, Submit, Nohide
    DisplayMusic := PianoMusic
    PianoMusic := RegExReplace(PianoMusic, "`n|`r|/| ")

    if (CurrentPos > StrLen(PianoMusic))
    {
        CurrentPos := 1
        DisplayPos := 1
    }

    if (CurrentPos <= StrLen(PianoMusic) && A_TickCount - KeyPressStartTime < 3000)
    {
        if (RegExMatch(PianoMusic, "U)(\[.*]|.)", Keys, CurrentPos))
        {
            CurrentPos += StrLen(Keys)

            while (DisplayPos <= StrLen(DisplayMusic) && InStr(" `n`r/", SubStr(DisplayMusic, DisplayPos, 1)))
                DisplayPos++

            DisplayPos += StrLen(Keys)

            Keys := Trim(Keys, "[]")
            SendInput, {Raw}%Keys%

            NextNotes := SubStr(DisplayMusic, DisplayPos, 90)
            GuiControl,, NextNotes, %NextNotes%
            
            Sleep, %KeyDelay%
        }
    }
}

-::
=::
[::
]::
    KeyPressStartTime := A_TickCount
    PlayNextNote()
    KeyPressStartTime := 0
return

GuiClose:
    ExitApp

ResetProgress:
    CurrentPos := 1
    DisplayPos := 1
    GuiControl,, NextNotes
return