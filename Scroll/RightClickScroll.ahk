$*RButton::
Hotkey, $*RButton Up, RButtonup, off
KeyWait, RButton, T0.3
If ErrorLevel = 1
{
   Hotkey, $*RButton Up, RButtonup, on
   MouseGetPos, ox, oy
   SetTimer, WatchTheMouse, 5
   movedx := 0
   movedy := 0
   ;TrayTip, Scrolling started, Scrolling mode has been started
}
Else
   Send {RButton}
return

RButtonup:
Hotkey, $*RButton Up, RButtonup, off
SetTimer, WatchTheMouse, off
TrayTip
return

WatchTheMouse:
MouseGetPos, nx, ny
movedx := movedx+nx-ox
movedy := movedy+ny-oy

level := 40

timesX := Abs(movedx) / level
ControlGetFocus, control, A
Loop, %timesX%
{
    If (movedx > 0)
    {
        SendMessage, 0x114, 1, 0, %control%, A ; 0x114 is WM_HSCROLL
        movedx := movedx - level
    }
    Else
    {
        SendMessage, 0x114, 0, 0, %control%, A ; 0x114 is WM_HSCROLL
        movedx := movedx + level
    }
}

timesY := Abs(movedy) / level
Loop, %timesY%
{
    If (movedy > 0)
    {
        Click WheelDown
        movedy := movedy - level
    }
    Else
    {
        Click WheelUp
        movedy := movedy + level
    }
}   

MouseMove ox, oy
return
