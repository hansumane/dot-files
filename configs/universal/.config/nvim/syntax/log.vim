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
      \ "\c^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(crit\|critical\|fatal\|QFATAL\)\>.*$"

syn match logsError
      \ "\c^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(err\|error\|fail\|failed\|failure\|QCRITICAL\)\>.*$"

syn match logsWarning
      \ "\c^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(warn\|warning\|QWARN\)\>.*$"

syn match logsDebug
      \ "\c^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(debug\|QDEBUG\)\>.*$"

syn match logsInformation
      \ "\c^\%([^cdefiqw]*\%([cdefiqw]\)\?\)*\<\%(info\|information\|QINFO\)\>.*$"

hi def link logsDebug       DiagnosticVirtualTextOk
hi def link logsInformation DiagnosticVirtualTextInfo
hi def link logsWarning     DiagnosticVirtualTextWarn
hi def link logsError       DiagnosticVirtualTextError
hi def link logsCritical    DiagnosticVirtualTextError


let b:current_syntax = "logs"
