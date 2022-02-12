#SingleInstance force
;@Ahk2Exe-AddResource icon_key_blocked.ico, 159 ; Replaces main icon
;@Ahk2Exe-AddResource icon_key_normal.ico,  206 ; Replaces suspend icon
;@Ahk2Exe-SetCompanyName prog4food
;@Ahk2Exe-SetCopyright prog4food (c) 2o22
;@Ahk2Exe-SetProductName MumHotDi
;@Ahk2Exe-SetDescription MumbleHotkeyDisabler
;@Ahk2Exe-SetVersion 0.5
aVersion := "v0.5"
MuWasHWND := false
MuNowHWND    := false
Suspend, On

if (A_Args.Length() < 1) {
  MsgBox, 0x40, Help, MumHotDi %aVersion% by prog4food (c) 2o22`n`nMumHotDi.exe <ahk hotkey modifier> [mumble exe full path]
  ExitApp
}

if (A_Args.Length() == 2) {
  Run % A_Args[2]
  Sleep, 5000
}

TargKey := A_Args[1]
Hotkey, %TargKey%, KeyNop

SetTitleMatchMode, 1
DetectHiddenWindows, On

Menu, Tray, NoStandard 
Menu, Tray, Add, %aVersion% by prog4food (c) 2o22, MenuAbout
Menu, Tray, Tip, MumHotDi`nHotKey: %TargKey%`nDoubleClick: Check Mumble is running
Menu, Tray, Add, Check Mumble is running, MenuCheck
Menu, Tray, Add, Force enable/disable hotkey, MenuToggleHotkey
Menu, Tray, Add, Exit, MenuExit
Menu, Tray, Default, Check Mumble is running

MuLoop:
  Gosub, MuCheck
  Sleep, 30000
Goto, MuLoop

MuCheck:
  MuNowHWND := WinExist("Mumble -- ")
  if (MuNowHWND != MuWasHWND) {
    MuWasHWND := MuNowHWND
    if (MuNowHWND != 0)
      Suspend, Off
    else
      Suspend, On
  }
Return

MenuCheck:
  Gosub, MuCheck
  if (MuNowHWND != 0)
    WinActivate, ahk_id %MuNowHWND%
Return

MenuToggleHotkey:
  MuWasHWND := MuNowHWND
  Suspend, Toggle
Return

MenuAbout:
  Run, https://github.com/prog4food/MumHotDi
Return

MenuExit:
  ExitApp
Return

KeyNop:
Return
