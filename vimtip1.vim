function! GetProtoLine()
  let ret       = ""
  let line_save = line(".")
  let col_save  = col(".")
  let top       = line_save - winline() + 1
  let so_save = &so
  let &so = 0
  let istypedef = 0
  " find closing brace
  let closing_lnum = search('^}','cW')
  if closing_lnum > 0
    if getline(line(".")) =~ '\w\s*;\s*$'
      let istypedef = 1
      let closingline = getline(".")
    endif
    " go to the opening brace
    normal! %
    " if the start position is between the two braces
    if line(".") <= line_save
      if istypedef
        let ret = matchstr(closingline, '\w\+\s*;')
      else
        " find a line contains function name
        let lnum = search('^\w','bcnW')
        if lnum > 0
          let ret = getline(lnum)
        endif
      endif
    endif
  endif
  " restore position and screen line
  exe "normal! " . top . "Gz\<CR>"
  call cursor(line_save, col_save)
  let &so = so_save
  return ret
endfunction

function! WhatFunction()
  if &ft != "c" && &ft != "cpp"
    return ""
  endif
  let proto = GetProtoLine()
  if proto == ""
    return "?"
  endif
  if stridx(proto, '(') > 0
    let ret = matchstr(proto, '\w\+(\@=')
  elseif proto =~# '\<struct\>'
    let ret = matchstr(proto, 'struct\s\+\w\+')
  elseif proto =~# '\<class\>'
    let ret = matchstr(proto, 'class\s\+\w\+')
  else
    let ret = strpart(proto, 0, 15) . "..."
  endif
  return ret
endfunction

" You may want to call WhatFunction in the statusline
set statusline=%f:%{WhatFunction()}\ %m%=\ %l-%v\ %p%%\ %02B
