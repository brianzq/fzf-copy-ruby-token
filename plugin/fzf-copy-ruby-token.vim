" Ruby method might end with ?, !, or =. We want to copy the whole method name
" including those special characters at the end.

function CurrentMethod()
  " select outer WORD
  let outer_word = expand('<cWORD>')
  " strip self. for class methods
  let strip_self = substitute(outer_word, 'self.', '', '')
  " method name pattern that might end with ?, !, or =
  let pattern = '\<\w\+\>[?!=]*'
  let selected_word = matchstr(strip_self, pattern)
  return selected_word
endfunction

command! -bar FZFCopyRubyToken :call fzf_copy_ruby_token#Run(CurrentMethod())
nnoremap <silent> <Plug>(fzf_copy_ruby_token) :FZFCopyRubyToken<Return>
