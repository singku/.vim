syntax match K_time "^\[\d\d:\d\d:\d\d\]" nextgroup=K_pid skipwhite
syntax match K_pid "\[\d\+\]" nextgroup=K_flag skipwhite contained
syntax match K_flag "\w\+" nextgroup=K_cmdid skipwhite contained
syntax match K_cmdid "\[\d\+\]" nextgroup=K_protolen skipwhite contained
syntax match K_protolen "\[\d\+\]" nextgroup=K_userid skipwhite contained
syntax match K_userid "\[\d\+\]" nextgroup=K_result skipwhite contained
syntax match K_result "\[\d\+\]" nextgroup=K_mid_1 skipwhite contained
syntax match K_mid_1 "\[" nextgroup=K_msgheader skipwhite contained
syntax match K_msgheader "\(\w\w \)\{18\}" nextgroup=K_pri skipwhite contained
syntax match K_pri   "\(\w\w \)*" nextgroup=K_mid_2 skipwhite contained
syntax match K_mid_2 "\]" 


highlight K_time ctermfg=darkgreen guifg=green
highlight K_pid ctermfg=brown guifg=brown
highlight K_flag    ctermfg=darkcyan
highlight K_cmdid    ctermfg=darkblue
highlight K_protolen    ctermfg=darkcyan
highlight K_userid    ctermfg=darkgray
highlight K_result    ctermfg=red
highlight K_msgheader    ctermfg=darkmagenta
highlight K_pri ctermfg=darkred
