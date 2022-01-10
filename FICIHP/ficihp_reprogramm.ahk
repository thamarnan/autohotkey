SetCapsLockState, AlwaysOff

;Right macro

Insert::Insert
Home::Home
Del::Del
End::End
Pause::Pause
PgUp::PgUp
PgDn::PgDn


;Main 60 Keys with Capslock to Layer 1
;Mimic Pok3r Keyboard

Capslock & ESC:: Send, {`}
Shift & ESC:: Send, {~}

CapsLock & 1:: F1
CapsLock & 2:: F2
CapsLock & 3:: F3
CapsLock & 4:: F4
CapsLock & 5:: F5
CapsLock & 6:: F6
CapsLock & 7:: F7
CapsLock & 8:: F8
CapsLock & 9:: F9
CapsLock & 0:: F10
CapsLock & -:: F11
CapsLock & =:: F12

CapsLock & j:: left
CapsLock & l:: right
CapsLock & k:: down
CapsLock & i:: up

CapsLock & p:: Send {PrintScreen}

CapsLock & h:: Home
CapsLock & n:: End
CapsLock & o:: PgDn
CapsLock & u:: PgUp
CapsLock & BackSpace:: Send {Delete}
Capslock & `;:: Send, {Insert}`

CapsLock & q:: Send {Media_Prev}
CapsLock & w:: Send {Media_Play_Pause}
CapsLock & e:: Send {Media_Next}

CapsLock & s:: Send {Volume_Down}
CapsLock & d:: Send {Volume_Up}
CapsLock & f:: Send {Volume_Mute}

;My custom keys
RAlt::RWin
