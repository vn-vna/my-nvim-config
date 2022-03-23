" ( , , ,  )
set number
set autoindent
set relativenumber
set mouse=a
" set foldmethod=syntax
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab
set termguicolors

highlight Pmenu 		    ctermbg=gray 		guibg=gray		guifg=white
highlight PmenuSel 	    ctermbg=white 	guibg=cyan		guifg=black
highlight CursorLineNr  cterm=NONE      ctermbg=NONE  ctermfg=NONE    guibg=NONE    guifg=#55ffff
highlight CursorLine    cterm=NONE      ctermbg=NONE  ctermfg=NONE    guibg=#282a36 guifg=NONE

set cursorline

call plug#begin()

Plug 'akinsho/bufferline.nvim'                      " beautiful bufferline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'} " galaxyline ui
Plug 'ryanoasis/vim-devicons'                       " vimscript
Plug 'norcalli/nvim-colorizer.lua'                  " nvim-colorizer
Plug 'kyazdani42/nvim-web-devicons'                 " nvim-tree file icons
Plug 'kyazdani42/nvim-tree.lua'                     " nvim-tree for file tree
Plug 'liuchengxu/vim-clap'                          " file finder
Plug 'sbdchd/neoformat'                             " code formatting
Plug 'karb94/neoscroll.nvim'                        " smooth scroll
Plug 'Pocco81/AutoSave.nvim'                        " auto save
Plug 'Townk/vim-autoclose'                          " auto close bracket
Plug 'voldikss/vim-floaterm'                        " floating terminal
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " coc language server
Plug 'cdelledonne/vim-cmake'
Plug 'terrortylor/nvim-comment'                     " commenter
Plug 'octol/vim-cpp-enhanced-highlight'             " C++ Better highlight
Plug 'roblillack/vim-bufferlist'                    " Vim bufferlist
Plug 'terryma/vim-multiple-cursors'                 " Multiple cursors
Plug 'rbong/vim-flog'                               " Git branch history
Plug 'tpope/vim-fugitive'

call plug#end()

map <silent> <F3> :call BufferList()<CR>

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

lua << EOF

require('nvim_comment').setup()

require('neoscroll').setup()

local autosave = require("autosave")

autosave.setup(
    {
        enabled = true,
        execution_message = "AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"),
        events = {"InsertLeave", "TextChanged"},
        conditions = {
            exists = true,
            filename_is_not = {},
            filetype_is_not = {},
            modifiable = true
        },
        write_all_buffers = false,
        on_off_commands = true,
        clean_command_line_interval = 0,
        debounce_delay = 135
    }
)

require'nvim-tree'.setup { 
  auto_close = false,
  auto_reload_on_write = true,
  disable_netrw = false,
  hide_root_folder = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  ignore_buffer_on_setup = false,
  open_on_setup = false,
  open_on_tab = false,
  sort_by = "name",
  update_cwd = true,
  view = {
    width = 30,
    height = 30,
    side = "left",
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = "yes",
    mappings = {
      custom_only = false,
      list = {
        -- user mappings go here
      },
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  ignore_ft_on_setup = {},
  system_open = {
    cmd = nil,
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    change_dir = {
      enable = true,
      global = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  trash = {
    cmd = "trash",
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      git = false,
    },
  },
}

local vim = vim
local gl = require('galaxyline')
local condition = require("galaxyline.condition")

local gls = gl.section
gl.short_line_list = {'NvimTree', 'packager', 'vista'}

local diagnostic = require('galaxyline.provider_diagnostic')
local vcs = require('galaxyline.provider_vcs')
local fileinfo = require('galaxyline.provider_fileinfo')
local extension = require('galaxyline.provider_extensions')
local colors = require('galaxyline.colors')
local buffer = require('galaxyline.provider_buffer')
local whitespace = require('galaxyline.provider_whitespace')
local lspclient = require('galaxyline.provider_lsp')

-- Colors
local colors = {
  bg = '#282a36',
  fg = '#f8f8f2',
  section_bg = '#38393f',
  yellow = '#f1fa8c',
  cyan = '#8be9fd',
  green = '#50fa7b',
  orange = '#ffb86c',
  magenta = '#ff79c6',
  blue = '#8be9fd',
  red = '#ff5555',
	black = '#000000'
}

-- Local helper functions
local mode_color = function()
  local mode_colors = {
    n = colors.cyan,
    i = colors.green,
    c = colors.orange,
    V = colors.magenta,
    [''] = colors.magenta,
    v = colors.magenta,
    R = colors.red
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then color = colors.red end

  return color
end

-- Left side
gls.left[1] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 		' 煉NORMAL',
        i = 		'  INSERT',
        c = 		'  COMMAND',
        V = 		' 揄VISUAL LINE',
        [''] = 	' 揄VISUAL BLOCK',
        v = 		' 揄VISUAL',
        R = 		'  REPLACE'
      }
      vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color())
      local alias_mode = alias[vim.fn.mode()]
      if alias_mode == nil then alias_mode = vim.fn.mode() end
      return "  " .. alias_mode .. " "
    end,
    highlight = {colors.bg, colors.section_bg},
		separator = " ", 
    separator_highlight = {
      colors.section_bg, 
      colors.black
    }
  }
}

gls.left[2] = {
  FileIcon = {
    provider = 'FileIcon',
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.black
    },
    separator = '',
    separator_highlight = {colors.section_bg, colors.black}
  }
}

gls.left[3] = {
	FileName = {
		provider = 'FileName',
		highlight = {colors.white, colors.section_bg},
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
    end,
		separator = " ",
		separator_highlight = {colors.section_bg, colors.blue}
	}
}

gls.left[4] = {
	FileSize = {
		provider = 'FileSize',
		highlight = {colors.section_bg, colors.blue},
    condition = function()
      if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
        return true
      end
      return false
    end,
    separator = ' ',
    separator_highlight = {colors.blue, colors.section_bg}
	}
}

gls.left[5] = {
  FFinal = {
    provider = function() 
      return '  '
    end,
    highlight = { colors.section_bg, colors.section_bg }
  }
}

gls.right[1] = {
	LinePercent = {
    provider = function()
      return ' LINE ' .. vim.fn.line('.') .. ' COL ' .. vim.fn.col('.') .. '  '
    end,
		highlight = {colors.section_bg, colors.blue},
    separator = " ",
    separator_highlight = {colors.blue, colors.section_bg},
	}
}

gls.right[2] = {
  FileType = {
    provider = function() 
    end,
    highlight = { colors.white, colors.black },
  }    
}

require'colorizer'.setup()

require('bufferline').setup {
	options = {
		mode = "buffers",
		number = "none",
		close_command = "bdelete! %d",       
    right_mouse_command = "bdelete! %d", 
    left_mouse_command = "buffer %d",    
    middle_mouse_command = nil,          
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
		max_name_length = 18,
    max_prefix_length = 15, 
    tab_size = 18,
    diagnostics = "coc",
    diagnostics_update_in_insert = false
	}
}

EOF

let g:cmake_link_compile_commands=1
let g:cmake_build_dir_location='./build'

let g:nvim_tree_indent_markers = 1 
let g:nvim_tree_git_hl = 1 
let g:nvim_tree_highlight_opened_files = 1 
let g:nvim_tree_root_folder_modifier = ':~' 
let g:nvim_tree_add_trailing = 1 
let g:nvim_tree_group_empty = 1 
let g:nvim_tree_icon_padding = ' ' 
let g:nvim_tree_symlink_arrow = ' >> ' 
let g:nvim_tree_respect_buf_cwd = 1 
let g:nvim_tree_create_in_closed_folder = 1
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } 
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

nnoremap <leader>f      :NvimTreeFocus<CR>
nnoremap <leader>r      :NvimTreeRefresh<CR>
nnoremap <leader>n      :NvimTreeFindFile<CR>
nnoremap <leader>t      :FloatermToggle<CR>
nnoremap <leader>.      :BufferLineCycleNext<CR>
nnoremap <leader>,      :BufferLineCyclePrev<CR>
nnoremap <leader>cg     :CMakeGenerate<CR>
nnoremap <leader>cb     :CMakeBuild<CR>
nnoremap <leader>cc     :CMakeClean<CR>
nnoremap <leader>gbh    :Flogsplit<CR>
nnoremap <C-Up>         <C-w>10+
nnoremap <C-Down>       <C-w>10-
nnoremap <C-Left>       <C-w>10<
nnoremap <C-Right>      <C-w>10>
nnoremap <A-Up>         <C-w>k
nnoremap <A-Down>       <C-w>j 
nnoremap <A-Left>       <C-w>h 
nnoremap <A-Right>      <C-w>l 

tnoremap <C-z>          <C-\><C-n>

inoremap <A-j>          <ESC>j
inoremap <A-k>          <ESC>k
inoremap <A-l>          <ESC>l 
inoremap <A-h>          <ESC>h 
