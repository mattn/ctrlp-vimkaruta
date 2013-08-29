if exists('g:loaded_ctrlp_vimkaruta') && g:loaded_ctrlp_vimkaruta
  finish
endif
let g:loaded_ctrlp_vimkaruta = 1

let s:vimkaruta_var = {
\  'init':   'ctrlp#vimkaruta#init()',
\  'exit':   'ctrlp#vimkaruta#exit()',
\  'accept': 'ctrlp#vimkaruta#accept',
\  'lname':  'vimkaruta',
\  'sname':  'vimkaruta',
\  'type':   'path',
\  'sort':   0,
\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:vimkaruta_var)
else
  let g:ctrlp_ext_vars = [s:vimkaruta_var]
endif

function! ctrlp#vimkaruta#init()
  let res = webapi#http#get('http://mattn.tonic-water.com/vim-karuta/json')
  let s:karuta = webapi#json#decode(res.content)
  return keys(s:karuta)
endfunc

function! ctrlp#vimkaruta#accept(mode, str)
  call ctrlp#exit()
  redraw
  echo a:str . " " . s:karuta[a:str]
endfunction

function! ctrlp#vimkaruta#exit()
  if exists('s:results')
    unlet! s:results
  endif
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#vimkaruta#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
