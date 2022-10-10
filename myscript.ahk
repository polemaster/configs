#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; My custom shortcuts and keybindings
CapsLock::Escape
return

#w::            ; Windows + w
WinClose A      ; Closes active window
return

#f::            ; Windows + f
Run, firefox.exe
return

#t::            ; Windows + t
Run, wt.exe     ; Launches windows terminal
return