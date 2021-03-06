" This is my personal script for unicode concealing in vim when using idris
" It's pretty much a slightly modified https://github.com/Twinside/vim-haskellConceal
"
" It needs vim >= 7.3, set nocompatible, set enc=utf-8
"
" If you want to turn this off, let g:no_idris_conceal = 1

if exists('g:no_idris_conceal') || !has('conceal') || &enc != 'utf-8'
    finish
endif

" vim: set fenc=utf-8:
syntax match idrNiceOperator "\\\ze[[:alpha:][:space:]_([]" conceal cchar=λ
syntax match idrNiceOperator "<-" conceal cchar=←
syntax match idrNiceOperator "->" conceal cchar=→
syntax match idrNiceOperator "\<sum\>" conceal cchar=∑
syntax match idrNiceOperator "\<product\>" conceal cchar=∏
syntax match idrNiceOperator "\<sqrt\>" conceal cchar=√
syntax match idrNiceOperator "\<pi\>" conceal cchar=π
syntax match idrNiceOperator "==" conceal cchar=≡
syntax match idrNiceOperator "\/=" conceal cchar=≠


let s:extraConceal = 1

let s:doubleArrow = 1
" Set this to 0 to use the more technically correct arrow from bar

" Some windows font don't support some of the characters,
" so if they are the main font, we don't load them :)
if has("win32")
    let s:incompleteFont = [ 'Consolas'
                        \ , 'Lucida Console'
                        \ , 'Courier New'
                        \ ]
    let s:mainfont = substitute( &guifont, '^\([^:,]\+\).*', '\1', '')
    for s:fontName in s:incompleteFont
        if s:mainfont ==? s:fontName
            let s:extraConceal = 0
            break
        endif
    endfor
endif

if s:extraConceal
    syntax match idrNiceOperator "_|_" conceal cchar=⊥

    " Match greater than and lower than w/o messing with Kleisli composition
    syntax match idrNiceOperator "<=\ze[^<]" conceal cchar=≤
    syntax match idrNiceOperator ">=\ze[^>]" conceal cchar=≥

    if s:doubleArrow
      syntax match idrNiceOperator "=>" conceal cchar=⇒
    else
      syntax match idrNiceOperator "=>" conceal cchar=↦
    endif

    syntax match idrNiceOperator "=\zs<<" conceal cchar=«

    syntax match idrNiceOperator "++" conceal cchar=⧺
    syntax match idrNiceOperator "-<" conceal cchar=↢
    syntax match idrNiceOperator ">-" conceal cchar=↣
    syntax match idrNiceOperator "-<<" conceal cchar=⤛
    syntax match idrNiceOperator ">>-" conceal cchar=⤜

    " Only replace the dot, avoid taking spaces around.
    syntax match idrNiceOperator /\s\.\s/ms=s+1,me=e-1 conceal cchar=∘
    syntax match idrNiceOperator "\.\." conceal cchar=‥

    syntax match idrNiceOperator "`elem`" conceal cchar=∈
    syntax match idrNiceOperator "`notElem`" conceal cchar=∉
endif

hi link idrNiceOperator Operator
hi! link Conceal Operator
setlocal conceallevel=2

