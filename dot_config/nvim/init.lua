-- Plugins
local execute = vim.api.nvim_command
local keymap = vim.api.nvim_set_keymap

local install_path = vim.fn.stdpath('data') ..
                         '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' ..
                install_path)
end

vim.api.nvim_exec([[
    augroup Packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
    augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- Package manager

    use 'airblade/vim-rooter' -- change cwd to git root
    use 'rhysd/vim-grammarous' -- languagetool spellcheck
    use 'mbbill/undotree' -- undo tree
    use 'tpope/vim-fugitive' -- Git commands in nvim
    use 'sbdchd/neoformat' -- format everything

    -- ui
    use 'morhetz/gruvbox' -- Theme
    use 'hoob3rt/lualine.nvim' -- status line
    use 'Yggdroot/indentLine' -- show spaces / tabs everywhere
    use 'airblade/vim-gitgutter' -- git diff in sign column

    -- navigation
    use 'junegunn/fzf.vim' -- fuzzy finder
    use 'junegunn/fzf' -- fuzzy finder
    use 'christoomey/vim-tmux-navigator' -- move between tmux & vim windows with same shortcuts
    use 'dyng/ctrlsf.vim' -- find string in whole project
    use {'lambdalisue/fern.vim', requires = {'antoinemadec/FixCursorHold.nvim'}} -- file drawer

    -- autocomplete / typing stuff
    use 'tpope/vim-commentary' -- Code Comment stuff, f.ex gc
    use 'hrsh7th/nvim-compe' -- Autocompletion
    use 'ntpeters/vim-better-whitespace' -- show trailing whitespaces in red
    use 'cohama/lexima.vim' -- auto close ()
    use 'luochen1990/rainbow' -- rainbow ()
    use 'tpope/vim-surround' -- surround operations
    use 'editorconfig/editorconfig-vim' -- use tabstop / tabwidth from .editorconfig

    -- lsp
    use 'neovim/nvim-lspconfig' -- lsp configs for builtin language server client
    use { -- show diagnostics, f.ex. eslint
        'iamcco/diagnostic-languageserver',
        requires = {'creativenull/diagnosticls-nvim'}
    }
    use 'simrat39/rust-tools.nvim' -- additional rust analyzer tools, f.ex show types in method chain
    use 'ray-x/lsp_signature.nvim' -- show signature while typing method
    use 'gfanto/fzf-lsp.nvim' -- fzf lsp definitions etc
    use 'arkav/lualine-lsp-progress' -- lsp progress in statusline

    -- tree sitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} -- syntax tree parser
    use 'windwp/nvim-ts-autotag' -- close html tags via treesitter
    -- cool but really slow
    -- use 'haringsrob/nvim_context_vt' -- show context on closing brackets
    -- use 'romgrk/nvim-treesitter-context' -- show method context
end)

-- https://github.com/hrsh7th/nvim-compe#how-to-remove-pattern-not-found
vim.o.shortmess = vim.o.shortmess .. 'c'

-- Incremental live completion
vim.o.inccommand = "nosplit"

-- tabs
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- Map blankline
vim.o.list = true;
vim.o.listchars = 'tab:| ,trail:•'

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- hide default mode
vim.o.showmode = false

-- Make line numbers default
vim.wo.number = true

-- Do not save when switching buffers
vim.o.hidden = true

-- Cooler backspace
vim.o.backspace = 'indent,eol,start'

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- coller tabs
vim.o.expandtab = true

-- Save undo history
vim.o.undofile = true
vim.o.undolevels = 1000
vim.o.undoreload = 1000
vim.o.undodir = vim.fn.expand('$HOME') .. '/.vimundo'

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- gruvbox masterrace
if vim.fn.has('termguicolors') then vim.o.termguicolors = true end

vim.cmd [[colorscheme gruvbox]]

-- Remap space as leader key
keymap('', '<Space>', '<Nop>', {noremap = true, silent = true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight on yank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- indentline

vim.g.indentLine_char = '┊'
vim.g.indentLine_enabled = 1
vim.g.indentLine_leadingSpaceEnabled = 1
vim.g.indentLine_leadingSpaceChar = '•'

-- ctrlsf
vim.g.ctrlsf_auto_preview = 1
vim.g.ctrlsf_auto_focus = {at = 'start'}
vim.g.ctrlsf_mapping = {next = 'n', prev = 'N'}

-- () auto close
vim.g.lexima_no_default_rules = true
vim.cmd 'call lexima#set_default_rules()'

-- key mapping

keymap("n", "Y", 'y$', {silent = true, noremap = true})
keymap("n", "ZW", ':w<CR>', {silent = true, noremap = true})
keymap("n", "<leader>f", ':Rg<CR>', {silent = true, noremap = true})
keymap("n", "<leader>au", ':UndotreeToggle<CR>', {silent = true, noremap = true})
keymap("n", "<leader>as", ':CtrlSF ', {noremap = true})
keymap("n", "<leader>af", ':Neoformat<CR> ', {noremap = true})
keymap("n", "<leader>p", '"+p', {noremap = true})
keymap("n", "<leader>P", '"+P', {noremap = true})
keymap("n", "<leader>y", '"+y', {noremap = true})
keymap("n", "<leader>d", '"+d', {noremap = true})
keymap("n", "<leader>n", ':GFiles --cached --others --exclude-standar<CR>',
       {silent = true, noremap = true})
keymap("n", "<leader>N", ':Files<CR>', {silent = true, noremap = true})
keymap("n", "<leader>b", ':Buffers<CR>', {silent = true, noremap = true})
keymap("n", "<leader>e", ':Fern . -drawer -reveal=% -width=35 -toggle<CR>',
       {silent = true, noremap = true})
keymap("v", "<leader>y", '"+y', {silent = true, noremap = true})
keymap("v", "<leader>d", '"+d', {silent = true, noremap = true})
keymap("i", "<C-Space>", "compe#complete()",
       {expr = true, silent = true, noremap = true})
keymap("i", "<CR>", "compe#confirm('<CR>')",
       {expr = true, silent = true, noremap = true})
keymap("i", "<C-e>", "compe#close('<C-e>')",
       {expr = true, silent = true, noremap = true})

-- luochen1990/rainbow
vim.g.rainbow_active = 1

-- ntpeters/vim-better-whitespace
vim.g.better_whitespace_enabled = 1

-- undo tree
vim.g.undotree_WindowLayout = 2
vim.g.undetree_SetFocusWhenToggle = 1

-- completion

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'always',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {nvim_lsp = {priority = 1000}, path = true}
}

-- file drawer

vim.g['fern#disable_default_mappings'] = 1
vim.g['fern#disable_drawer_auto_quit'] = 1

function fern_init()
    local function buf_keymap(...) vim.api.nvim_buf_set_keymap(0, ...) end
    buf_keymap("n", "<CR>", '<Plug>(fern-open-or-expand)',
               {silent = true, noremap = true})
    buf_keymap("n", "m", '<Plug>(fern-action-mark:toggle)',
               {silent = true, noremap = true})
    buf_keymap('r', '<Plug>(fern-action-rename)',
               {silent = true, noremap = true})
    buf_keymap('n', '<Plug>(fern-action-new-path)',
               {silent = true, noremap = true})
    buf_keymap('t', '<Plug>(fern-action-hidden-toggle)',
               {silent = true, noremap = true})
    buf_keymap('d', '<Plug>(fern-action-remove)',
               {silent = true, noremap = true})
    buf_keymap('v', '<Plug>(fern-action-open:vsplit)',
               {silent = true, noremap = true})
    buf_keymap('h', '<Plug>(fern-action-open:split)',
               {silent = true, noremap = true})
    buf_keymap('R', '<Plug>(fern-action-reload)',
               {silent = true, noremap = true})
end

vim.api.nvim_exec([[
    augroup FernEvents
        autocmd!
        autocmd FileType fern lua fern_init()
    augroup END
]], false)

-- statusbar

require'lualine'.setup {
    options = {
        icons_enabled = false,
        theme = 'gruvbox',
        component_separators = {'|', '|'},
        section_separators = {'', ''},
        disabled_filetypes = {}
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {{'filename', file_status = true, path = 1}},
        lualine_c = {
            {
                'diagnostics',
                sources = {'nvim_lsp'},
                symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
            }, {
                'lsp_progress',
                color = {use = false},
                display_components = {{'title', 'percentage', 'message'}}
            }
        },
        lualine_x = {
            function()
                local clients = {}
                for _, client in pairs(vim.lsp.buf_get_clients()) do
                    table.insert(clients, client.name)
                end
                return table.concat(clients, ' ')
            end
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

local nvim_lsp = require 'lspconfig'
local on_attach = function(client, bufnr)
    local function buf_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    require'lsp_signature'.on_attach({
        fix_pos = true,
        hint_enable = false,
        handler_opts = {border = 'none', doc_lines = 0, floating_window = true}
    })

    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                highlight LspReferenceText cterm=bold ctermbg=DarkGray gui=bold guibg=#a89984 guifg=#282828
                highlight LspReferenceRead cterm=bold ctermbg=DarkGray gui=bold guibg=#a89984 guifg=#282828
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]], false)
    end

    buf_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', 'gD', ':Declarations<CR>', {silent = true, noremap = true})
    buf_keymap('n', 'gd', ':Definitions<CR>', {silent = true, noremap = true})
    buf_keymap('n', 'gi', ':Implementations<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', 'gr', ':References<CR>', {silent = true, noremap = true})
    buf_keymap('n', 'gm', ':DocumentSymbols<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', 'gM', ':WorkspaceSymbols<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>ar', '<cmd>lua vim.lsp.buf.rename()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>aa', ':CodeActions<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>aF', '<cmd>lua vim.lsp.buf.formatting()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>dl',
               '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>dN', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>',
               {silent = true, noremap = true})
    buf_keymap('n', '<leader>da', ':Diagnostics<CR>',
               {silent = true, noremap = true})
end

require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = {enable = true},
    autotag = {enable = true},
    indent = {enable = true}
}
local eslint = require 'diagnosticls-nvim.linters.eslint'
require'diagnosticls-nvim'.setup {
    ['typescript'] = {linter = eslint},
    ['typescriptreact'] = {linter = eslint}
}
require'diagnosticls-nvim'.init {on_attach = on_attach}

-- Enable the following language servers
local servers = {'gopls', 'rust_analyzer', 'tsserver', 'jsonls'}
for _, lsp in ipairs(servers) do
    local caps = vim.lsp.protocol.make_client_capabilities()
    caps.textDocument.completion.completionItem.snippetSupport = true
    caps.textDocument.completion.completionItem.resolveSupport = {
        properties = {'documentation', 'detail', 'additionalTextEdits'}
    }

    nvim_lsp[lsp].setup {on_attach = on_attach, capabilities = caps}
end
require'rust-tools'.setup({
    server = {on_attach = on_attach, capabilities = caps}
})

vim.g.fzf_layout = {down = '50%'}
