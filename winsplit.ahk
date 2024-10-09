#simulate the original winsplit actions

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Define the screen dimensions
SysGet, MonitorCount, MonitorCount

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
    global currentLayout, layouts, lastHotkey, MonitorCount
    WinGet, activeWindow, ID, A
    
    ; Check if the window is maximized
    WinGet, isMaximized, MinMax, ahk_id %activeWindow%
    if (isMaximized == 1) {
        WinRestore, ahk_id %activeWindow%
    }
    
    ; Get the current monitor index for the active window
    WinGetPos, winX, winY, winWidth, winHeight, ahk_id %activeWindow%
    currentMonitor := getMonitorIndexFromWindow(activeWindow)
    
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
    
    ; Get the work area for the current monitor
    SysGet, MonitorWorkArea, MonitorWorkArea, %currentMonitor%
    
    x := MonitorWorkAreaLeft + (MonitorWorkAreaRight - MonitorWorkAreaLeft) * layout.x / 100
    y := MonitorWorkAreaTop + (MonitorWorkAreaBottom - MonitorWorkAreaTop) * layout.y / 100
    w := (MonitorWorkAreaRight - MonitorWorkAreaLeft) * layout.w / 100
    h := (MonitorWorkAreaBottom - MonitorWorkAreaTop) * layout.h / 100
    
    WinMove, ahk_id %activeWindow%,, x, y, w, h
}

getMonitorIndexFromWindow(windowHandle) {
    global MonitorCount
    WinGetPos, winX, winY, winWidth, winHeight, ahk_id %windowHandle%
    winMidX := winX + winWidth / 2
    winMidY := winY + winHeight / 2
    
    Loop, %MonitorCount%
    {
        SysGet, MonitorWorkArea%A_Index%, MonitorWorkArea, %A_Index%
        if (winMidX >= MonitorWorkArea%A_Index%Left && winMidX <= MonitorWorkArea%A_Index%Right && winMidY >= MonitorWorkArea%A_Index%Top && winMidY <= MonitorWorkArea%A_Index%Bottom) {
            return A_Index
        }
    }
    return 1  ; Default to primary monitor if not found
}
