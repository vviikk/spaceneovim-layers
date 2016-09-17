" Add layers {{{
let config_dir = $HOME . '/.config/nvim'
let spacevim_layers_dir = expand(resolve(config_dir . '/spaceneovim-layers'))

for group in split(glob(spacevim_layers_dir . '/layers/*'), '\n')
  for layer in split(glob(group . '/*'), '\n')
    if filereadable(layer . '/config.vim') && filereadable(layer . '/packages.vim')
      call add(g:spacevim_layers, substitute(layer, spacevim_layers_dir . '/layers/', '', ''))
    endif
  endfor
endfor
" }}}

" Setup default plugin configuration {{{
if exists('g:loaded_spacevim')
  finish
endif
let g:loaded_spacevim = 1

" vim-leader-guide {{{
let g:lmap = get(g:, 'lmap', {})
let g:lmap.m = { 'name': '+major-mode-cmd' }
" }}}

function! s:spacevim_preinstall()
  " nerdcommenter {{{
  let g:NERDCreateDefaultMappings = get(g:, 'NERDCreateDefaultMappings', 0)
  " }}}

  " vim-easymotion {{{
  let g:EasyMotion_do_mapping = get(g:, 'EasyMotion_do_mapping', 0)
  " }}}

  " vim-gitgutter {{{
  let g:gitgutter_map_keys = get(g:, 'gitgutter_map_keys', 0)
  " }}}

  " vim-startify {{{
  let g:startify_custom_header = get(g:, 'startify_custom_header', [
  \'',
  \'                         [S P A C E N E O V I M]',
  \'',
  \ ])
  " }}}

  " vim-swoop {{{
  let g:swoopUseDefaultKeyMap = get(g:, 'swoopUseDefaultKeyMap', 0)
  " }}}
endfunction

function! s:spacevim_postinstall()
  " vim-arpeggio {{{
  if exists('g:loaded_arpeggio')
    if exists('g:dotspacevim_escape_key_sequence')
      call arpeggio#map('i', '', 0, g:dotspacevim_escape_key_sequence, '<Esc>')
    endif
    let g:arpeggio_timeoutlen = get(g:, 'arpeggio_timeoutlen', 100)
  endif
  " }}}

  " vim-leader-guide {{{
  if exists('g:loaded_leaderGuide_vim')
    function! s:spacevim_displayfunc()
      let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '\c<cr>$', '', '')
      let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '^<SID>', '', '')
      let g:leaderGuide#displayname = substitute(g:leaderGuide#displayname, '#', '', '')
    endfunction
    if exists('g:leaderGuide_displayfunc')
      call add(g:leaderGuide_displayfunc, function('s:spacevim_displayfunc'))
    else
      let g:leaderGuide_displayfunc = [function('s:spacevim_displayfunc')]
    endif

    call leaderGuide#register_prefix_descriptions('<Space>', 'g:lmap')
    nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
    vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>
  endif
  " }}}
endfunction

call s:spacevim_preinstall()
augroup spacevim_postinstall
  autocmd!
  autocmd VimEnter * call s:spacevim_postinstall()
augroup END
" }}}
