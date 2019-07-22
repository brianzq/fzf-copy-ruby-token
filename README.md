fzf-copy-ruby-token
===================

This plugin uses ripper-tags and jq to extract and copy the full name of the
token under the cursor.

Installation
------------

```vim
Plug 'zackhsi/fzf-copy-ruby-token'
```

Configuration
-------------

`fzf-copy-ruby-token` exposes the `<Plug>(fzf_copy_ruby_token)` mapping.

In normal mode, yank the full name of the token under cursor with leader + r + y:

```vim
nmap <leader>ry <Plug>(fzf_copy_ruby_token)
```
