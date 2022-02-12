#SingleInstance force
;@Ahk2Exe-AddResource icon_key_blocked.ico, 159 ; Replaces main icon
;@Ahk2Exe-AddResource icon_key_normal.ico,  206 ; Replaces suspend icon
;@Ahk2Exe-SetCompanyName prog4food
;@Ahk2Exe-SetCopyright prog4food (c) 2o22
;@Ahk2Exe-SetProductName MumHotDi
;@Ahk2Exe-SetDescription MumbleHotkeyDisabler
;@Ahk2Exe-Obey U_bits, = %A_PtrSize% * 8
;@Ahk2Exe-Obey U_type, = "%A_IsUnicode%" ? "U" : "A"

aVersion  := "v0.6"
;@Ahk2Exe-Obey U_ver, U_ver := "0.6"

;@Ahk2Exe-ExeName MumHotDi_%U_type%%U_bits%_v%U_ver%.exe
;@Ahk2Exe-SetVersion %U_ver%

MuWasHWND := false
MuNowHWND := false
Suspend, On

if (A_Args.Length() < 1) {
  MsgBox, 0x40, Help, MumHotDi %aVersion% by prog4food (c) 2o22`n`nMumHotDi.exe <ahk_key-from_hook> [ahk_key-to_hook] [pre_run_exe_full_path]
  ExitApp
}

if (A_Args.Length() == 2)
  TargKey := A_Args[2]
else
  TargKey := ""

if (A_Args.Length() == 3) {
  Run % A_Args[3]
  Sleep, 5000
}

SrcKey := A_Args[1]

if (TargKey == "") {
  TargKey := "Disable"
  Hotkey, %SrcKey%, KeyNop
} else {
  Hotkey, %SrcKey%, KeyMap
  Hotkey, %SrcKey% up, KeyMapUp
}

SetTitleMatchMode, 1
DetectHiddenWindows, On

Menu, Tray, NoStandard
Menu, Tray, Add, %aVersion% by prog4food (c) 2o22, MenuAbout
Menu, Tray, Tip, MumHotDi`nKeyMap: %SrcKey%=%TargKey%`nDoubleClick: Check Mumble is running
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

; See: https://www.autohotkey.com/docs/misc/Remap.htm#remarks
KeyMap:
SetKeyDelay -1
Send {Blind}{%TargKey% DownR}
return
KeyMapUp:
SetKeyDelay -1
Send {Blind}{%TargKey% up}
return

KeyNop:
Return
