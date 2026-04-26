# Features
This config is managed by Packer.nvim and lives in `lua/avex/plugins-setup.lua`.
Any save to that file auto-reloads Neovim and runs :PackerSync automatically. Shortcut to open and add plugins quickly- `Space + shift + p`

### File Structure
```
lua/avex/
├── core/
│   ├── autocommand.lua     # Auto-update
│   ├── colorscheme.lua     # Theme setup
│   ├── keymaps.lua         # All keybindings
│   └── options.lua         # Neovim options & settings
├── plugins/
│   ├── alpha-dashboard.lua # Startup dashboard
│   ├── bufferline.lua      # Tab/buffer bar
│   ├── cmp.lua             # Autocompletion engine
│   ├── command.lua         # Noice (custom command UI)
│   ├── comment.lua         # Comment toggling
│   ├── lsp/
│   │   └── mason.lua       # LSP server management
│   ├── lualine.lua         # Status line
│   ├── nvimtree.lua        # File explorer
│   ├── syntaxh.lua         # Treesitter syntax highlighting
│   ├── telescope.lua       # Fuzzy finder
│   └── terminal.lua        # Integrated terminal
└── plugins-setup.lua       # Plugin installation (Packer)
```

#### Autocommand
1. Tree-sitter
2. ripgrep
3. fd

This feature installs neo-treesitter parsers (smart error checking) which automatically detect errors in time and give hints as well.

Ripgrep which is also known as rg, is a powerful line-oriented search tool that is significantly faster than traditional grep and other alternatives. Ripgrep offers features such as file-type filtering, colored output, JSON mode, and shell completions for various shell environments. It is designed to enhance developer productivity with its fast search capabilities and comprehensive features. 

fd is designed to be a fast and user-friendly alternative to the find command, making it easier to search for files on the filesystem.


<br>

## 📦 Installed Plugins

### Appearance

| Plugin | What it does |
|--------|--------------|
| `bluz71/vim-nightfly-guicolors` | Color theme (Blue Nightfly) |
| `nvim-lualine/lualine.nvim` | Status line at the bottom of the screen |
| `akinsho/bufferline.nvim` | Tab/buffer bar at the top |
| `goolord/alpha-nvim` | Startup dashboard (open with `SPC da`) |
| `nvim-tree/nvim-web-devicons` | File icons throughout the UI |

---

### File Management

| Plugin | What it does |
|--------|--------------|
| `nvim-tree/nvim-tree.lua` | File explorer tree (toggle with `SPC  e`) |

---

### Search & Navigation

| Plugin | What it does |
|--------|--------------|
| `nvim-telescope/telescope.nvim` | Fuzzy file/text/buffer finder (`SPC ff`, `SPC fg`, etc.) |
| `nvim-lua/plenary.nvim` | Utility library required by Telescope |
| `nvim-telescope/telescope-fzf-native.nvim` | Native FZF sorter — makes Telescope faster |

---

### Editing & Completions

| Plugin | What it does |
|--------|--------------|
| `hrsh7th/nvim-cmp` | Autocompletion engine |
| `hrsh7th/cmp-buffer` | Completions from open buffers |
| `hrsh7th/cmp-path` | Completions for file paths |
| `L3MON4D3/LuaSnip` | Snippet engine |
| `rafamadriz/friendly-snippets` | Pre-built snippet collection for many languages |
| `saadparwaiz1/cmp_luasnip` | Bridges LuaSnip into nvim-cmp |
| `numToStr/Comment.nvim` | Toggle comments with `SPC /` |

---

### LSP (Language Intelligence)

| Plugin | What it does |
|--------|--------------|
| `williamboman/mason.nvim` | GUI installer for LSP servers, linters, formatters |
| `williamboman/mason-lspconfig.nvim` | Auto-connects Mason-installed servers to LSP |
| `neovim/nvim-lspconfig` | Core LSP client configuration |
| `hrsh7th/cmp-nvim-lsp` | LSP-powered completions into nvim-cmp |

---

### Terminal & UI

| Plugin | What it does |
|--------|--------------|
| `akinsho/toggleterm.nvim` | Floating/split terminal (`SPC \`) |
| `folke/noice.nvim` | Replaces the command line and notification UI with a styled popup |
| `MunifTanjim/nui.nvim` | UI component library (required by Noice) |
| `rcarriga/nvim-notify` | Notification handler (required by Noice) |

---

### Syntax

| Plugin | What it does |
|--------|--------------|
| `nvim-treesitter/nvim-treesitter` | AST-based syntax highlighting and code understanding |

---

### Keymaps

| Plugin | What it does |
|--------|--------------|
| `folke/which-key.nvim` | Shows available keybindings in a popup (`SPC ?`) |

**Which-key is configured with:**
- A rounded border popup titled **"Avex's Shortcuts"**
- Centered layout, only showing mappings that have a `desc`
- Groups are hidden — only individual keymaps are shown
- Trigger: `SPC ?` (your leader mappings) or `v → SPC ?` (all mappings)

---

### Auto-Reload Behavior

Saving `plugins-setup.lua` will automatically:
1. Re-source the file in Neovim
2. Save the file via `:w` or `space + w` and the plugins will autoamtically run the command and install.


---