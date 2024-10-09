#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Define the screen dimensions
SysGet, MonitorWorkArea, MonitorWorkArea

; Initialize variables
global lastHotkey := ""
global currentLayout := 1
global layouts := {}

; Define the layouts
layouts["DownLeft"] := [{x: 0, y: 50, w: 50, h: 50}, {x: 0, y: 50, w: 33.33, h: 50}, {x: 0, y: 50, w: 66.67, h: 50}]
layouts["Down"] := [{x: 0, y: 50, w: 100, h: 50}, {x: 33.33, y: 50, w: 33.33, h: 50}]
layouts["DownRight"] := [{x: 50, y: 50, w: 50, h: 50}, {x: 66.67, y: 50, w: 33.33, h: 50}, {x: 33.33, y: 50, w: 66.67, h: 50}]
layouts["Left"] := [{x: 0, y: 0, w: 50, h: 100}, {x: 33.33, y: 0, w: 33.33, h: 100}, {x: 0, y: 0, w: 66.67, h: 100}]
layouts["Center"] := [{x: 0, y: 0, w: 100, h: 100}, {x: 33.33, y: 0, w: 33.33, h: 100}, {x: 16.67, y: 0, w: 66.67, h: 100}]
layouts["Right"] := [{x: 50, y: 0, w: 50, h: 100}, {x: 66.67, y: 0, w: 33.33, h: 100}, {x: 33.33, y: 0, w: 66.67, h: 100}]
layouts["UpRight"] := [{x: 50, y: 0, w: 50, h: 50}, {x: 66.67, y: 0, w: 33.33, h: 50}, {x: 33.33, y: 0, w: 66.67, h: 50}]
layouts["UpLeft"] := [{x: 0, y: 0, w: 50, h: 50}, {x: 0, y: 0, w: 33.33, h: 50}, {x: 0, y: 0, w: 66.67, h: 50}]
layouts["Up"] := [{x: 0, y: 0, w: 100, h: 50}, {x: 33.33, y: 0, w: 33.33, h: 50}]

; Define the hotkeys
^!z::moveWindow("DownLeft")
^!x::moveWindow("Down") 
^!c::moveWindow("DownRight")
^!a::moveWindow("Left")
^!s::moveWindow("Center")
^!d::moveWindow("Right")
^!q::moveWindow("UpLeft")
^!w::moveWindow("Up")
^!e::moveWindow("UpRight")
^!f::WinMaximize, A
^!i::WinMinimizeAll
^!1::WinMove, A,, -1920, 0 #move to left Monitor
^!3::WinMove, A,, 1920, 0 #move to right Monitor

moveWindow(layoutName) {
    global currentLayout, layouts, MonitorWorkArea, MonitorWorkAreaBottom, MonitorWorkAreaLeft, MonitorWorkAreaRight, MonitorWorkAreaTop, lastHotkey
    WinGet, activeWindow, ID, A
    
    ; Check if the window is maximized
    WinGet, isMaximized, MinMax, ahk_id %activeWindow%
    if (isMaximized == 1) {
        WinRestore, ahk_id %activeWindow%
    }
    
    if (layoutName != lastHotkey) {
        currentLayout := 1
    } else {
        if (currentLayout >= layouts[layoutName].Length())
            currentLayout := 1
        else 
            currentLayout++
    }
    
    lastHotkey := layoutName
    
    layout := layouts[layoutName][currentLayout]
    
    x := MonitorWorkAreaLeft + (MonitorWorkAreaRight - MonitorWorkAreaLeft) * layout.x / 100
    y := MonitorWorkAreaTop + (MonitorWorkAreaBottom - MonitorWorkAreaTop) * layout.y / 100
    w := (MonitorWorkAreaRight - MonitorWorkAreaLeft) * layout.w / 100
    h := (MonitorWorkAreaBottom - MonitorWorkAreaTop) * layout.h / 100
    
    WinMove, ahk_id %activeWindow%,, x, y, w, h
}
