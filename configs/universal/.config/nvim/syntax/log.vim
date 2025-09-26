if exists('b:current_syntax')
  finish
endif

syntax clear
syntax case match

" Find the first severity word on each line and color the whole line.
"
" The first character class corresponds to the first character of all
" severity words:
"
"   c d e f i q w
"
" This prevents us from simply matching a later severity word after another
" possible severity word.

syn match logsCritical
      \ "^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(crit\|critical\|fatal\|QFATAL\)\>.*$"

syn match logsError
      \ "^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(err\|error\|fail\|failure\|QCRITICAL\)\>.*$"

syn match logsWarning
      \ "^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(warn\|warning\|QWARN\)\>.*$"

syn match logsDebug
      \ "^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(debug\|QDEBUG\)\>.*$"

syn match logsInformation
      \ "^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(info\|information\|QINFO\)\>.*$"

hi def link logsDebug       Todo
hi def link logsInformation DiagnosticInfo
hi def link logsWarning     DiagnosticWarn
hi def link logsError       DiagnosticError
hi def link logsCritical    DiagnosticError


let b:current_syntax = "logs"
