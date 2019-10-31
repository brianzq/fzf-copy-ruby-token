scriptencoding utf-8

function! fzf_copy_ruby_token#Run(token)
  let source_lines = s:source_lines(a:token)

  if len(source_lines) == 0
    echohl WarningMsg
    echo 'Token not found in current buffer: ' . a:token
    echohl None
  elseif len(source_lines) == 1
    call s:copy_to_clipboard(source_lines[0])
  else
    " A list of length one is passed to the sink function. This happily
    " matches the arglist for funcrefs.
    call fzf#run({
    \   'source': source_lines,
    \   'sink':   function('s:copy_to_clipboard'),
    \   'options': '--prompt " Copy to clipboard > "',
    \   'down': '40%',
    \ })
  endif
endfunction

function! s:source_lines(token)
  " In literal strings (':h literal-string'), two quotes stand for one quote.
  let raw_output = system('ripper-tags --tag-file=- --format=json ' . expand('%') . ' | jq --raw-output ''.[] | select(.name == "' . a:token . '") | .full_name''')
  let matches = split(raw_output)
  return matches
endfunction

" Make tokens REPL friendly. In the highly unlikely case there are multiple
" pound signs, only replace the last one.
"
" https://stackoverflow.com/questions/736120/why-are-methods-in-ruby-documentation-preceded-by-a-hash-sign
" https://stackoverflow.com/questions/11865845/replace-last-occurrence-in-line
function! s:convert_last_pound_to_dot(text)
  return substitute(a:text, '.*\zs#', '.', '')
endfunction

function! s:copy_to_clipboard(text)
  let text_to_copy = s:convert_last_pound_to_dot(a:text)
  execute 'let @+="' . text_to_copy . '"'
  echom('Copied to clipboard: ' . string(text_to_copy))
endfunction
