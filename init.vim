set number
set autoindent
set relativenumber
set mouse=a
set foldmethod=syntax
set tabstop=2
set softtabstop=0
set expandtab
set shiftwidth=2
set smarttab

highlight Pmenu 		ctermbg=gray 		guibg=gray		guifg=white
highlight PmenuSel 	ctermbg=white 	guibg=cyan		guifg=black

call plug#begin()

Plug 'akinsho/bufferline.nvim'                      " beautiful bufferline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'} " galaxyline ui
Plug 'ryanoasis/vim-devicons'                       " vimscript
Plug 'norcalli/nvim-colorizer.lua'                  " nvim-colorizer
Plug 'kyazdani42/nvim-web-devicons'                 " nvim-tree file icons
Plug 'kyazdani42/nvim-tree.lua'                     " nvim-tree for file tree
Plug 'glepnir/dashboard-nvim'                       " beautiful welcome page
Plug 'liuchengxu/vim-clap'                          " file finder
Plug 'sbdchd/neoformat'                             " code formatting
Plug 'karb94/neoscroll.nvim'                        " smooth scroll
Plug 'Pocco81/AutoSave.nvim'                        " auto save
Plug 'Townk/vim-autoclose'                          " auto close bracket
Plug 'voldikss/vim-floaterm'                        " floating terminal
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " coc language server

call plug#end()

" ===== Vim Autosave

lua << EOF
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
EOF

" ===== END Vim Autosave

lua require('neoscroll').setup()

" ===== NVIM TREE 

lua << EOF

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

EOF

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

set termguicolors

" ===== END NVIM TREE

" ===== BUFFERLINE

lua << EOF

local vim = vim
local gl = require('galaxyline')
local condition = require("galaxyline.condition")

local gls = gl.section
gl.short_line_list = {'NvimTree', 'packager', 'vista'}

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
		separator = " ", 
		separator_highlight = {colors.white, colors.section_bg}
  }
}

gls.left[2] = {
  FileIcon = {
    provider = 'FileIcon',
    highlight = {
      require('galaxyline.provider_fileinfo').get_file_icon_color,
      colors.section_bg
    }
  }
}

gls.left[3] = {
	FileName = {
		provider = 'FileName',
		highlight = {colors.white, colors.section_bg},
		separator = " ",
		separator_highlight = {colors.white, colors.section_bg}
	}
}

gls.left[4] = {
	FileSize = {
		provider = 'FileSize',
		highlight = {colors.white, colors.section_bg}
	}
}

gls.right[1] = {
	LinePercent = {
		provider = 'LinePercent',
		highlight = {colors.white, colors.section_bg},
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

nnoremap <C-n> 					:NvimTreeToggle<CR>
nnoremap <leader>r 			:NvimTreeRefresh<CR>
nnoremap <leader>n 			:NvimTreeFindFile<CR>
nnoremap <leader>t 			:FloatermToggle<CR>
nnoremap <leader>.			:BufferLineCycleNext<CR>
nnoremap <leader>,			:BufferLineCyclePrev<CR>
tnoremap <ESC>					<C-\><C-n>

