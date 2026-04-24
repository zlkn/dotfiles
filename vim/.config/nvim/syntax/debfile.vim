if exists("b:current_syntax")
  finish
endif

syn match   debfileComment   "^\s*#.*$"

syn keyword debfileKeyword   keyring source package nextgroup=debfileName skipwhite

syn match   debfileName      "\S\+" contained nextgroup=debfileUrl skipwhite

syn match   debfileUrl       "https\?://\S\+" contained

syn region  debfileHeredoc   start=+<<EOF+ end=+^EOF$+ contains=debfileDebLine,debfileComment

syn match   debfileDebLine   "^deb\s.*" contained contains=debfileDebKw,debfileUrl,debfileOpt
syn keyword debfileDebKw     deb contained
syn match   debfileOpt       "\[[^]]*\]" contained

hi def link debfileComment  Comment
hi def link debfileKeyword  Keyword
hi def link debfileName     Identifier
hi def link debfileUrl      Underlined
hi def link debfileHeredoc  String
hi def link debfileDebKw    Type
hi def link debfileOpt      Special

let b:current_syntax = "debfile"
