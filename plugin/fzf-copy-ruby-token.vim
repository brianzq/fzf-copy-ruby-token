command! -bar FZFCopyRubyToken :call fzf_copy_ruby_token#Run(expand('<cword>'))
nnoremap <silent> <Plug>(fzf_copy_ruby_token) :FZFCopyRubyToken<Return>
