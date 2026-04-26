# ⌨️ Keymapping Shortcuts

> **Leader key** = `Space`  
> Notation: `SPC` = Space, `S-` = Shift, `C-` = Ctrl

---

## Cheatsheet

| Shortcut | Action |
|----------|--------|
| `SPC ?` | Show your keymaps (leader mappings) |
| `v` → `SPC ?` | Show all keymaps (full cheatsheet) |

---

## Tabs (Buffers)

| Shortcut | Action |
|----------|--------|
| `SPC 1` – `SPC 9` | Jump to Tab 1–9 |
| `SPC 0` | Jump to last tab |
| `S-h` | Previous tab |
| `S-l` | Next tab |
| `SPC X` | Close current tab |

---

## Text Editing

| Shortcut | Action |
|----------|--------|
| `SPC a` | Select all |
| `SPC y` | Copy (to system clipboard) |
| `SPC x` | Cut line/selection (to system clipboard) |
| `SPC p` | Paste (from system clipboard) |
| `SPC rw` | Replace all occurrences of word under cursor |
| `dd` | Delete line |
| `o` | New line below |
| `u` | Undo |
| `U` | Redo |
| `jk` | Exit insert mode |

---

## Numbers

| Shortcut | Action |
|----------|--------|
| `SPC +` | Increment number |
| `SPC -` | Decrement number |

---

## Navigation & Movement

| Shortcut | Action |
|----------|--------|
| `}` | Move to end of line |
| `{` | Move to start of line (first non-blank) |
| `SPC H` | Move to column 0 (absolute line start) |
| `\` | Jump to previous paragraph |
| `\|` | Jump to next paragraph |
| `C-u` | Scroll up half page (centered) |

---

##  Visual Mode

| Shortcut | Action |
|----------|--------|
| `v` → `}` | Select to end of line |
| `v` → `{` | Select to start of line |
| `v` → `J` | Move selected lines down |
| `v` → `K` | Move selected lines up |

---

## Windows

| Shortcut | Action |
|----------|--------|
| `SPC sv` | Split vertically |
| `SPC sh` | Split horizontally |
| `SPC s=` | Resize all windows equally |
| `SPC sx` | Close current window |
| `C-a` | Move to left window |
| `C-j` | Move to bottom window |
| `C-k` | Move to top window |
| `C-d` | Move to right window |
| `C-Up` | Increase window height |
| `C-Down` | Decrease window height |
| `C-[` | Increase window width |
| `C-]` | Decrease window width |

---

## Telescope (Fuzzy Finder)

| Shortcut | Action |
|----------|--------|
| `SPC ff` | Find files |
| `SPC fg` | Live grep (search text in project) |
| `SPC fb` | Find open buffers |
| `SPC fh` | Search help tags |
| `SPC fo` | Recent files |
| `SPC fc` | Browse commands |

---

## File Explorer (NvimTree)

| Shortcut | Action |
|----------|--------|
| `SPC e` | Toggle file explorer |
| `SPC fn` | Create new file |
| `SPC fr` | Rename file |
| `SPC fd` | Delete file |

---

## Folder Management

| Shortcut | Action |
|----------|--------|
| `SPC dn` | Create new folder |
| `SPC dr` | Rename folder/file under cursor |
| `SPC rf` | Move folder under cursor to trash |

---

## Save & Quit

| Shortcut | Action |
|----------|--------|
| `SPC w` / `C-s` | Save file |
| `SPC W` | Save all files |
| `SPC q` | Quit |
| `SPC Q` | Force quit all |
| `SPC wq` | Save and quit |

---

## Git

| Shortcut | Action |
|----------|--------|
| `SPC gs` | Git status |
| `SPC gb` | Git blame |
| `SPC gd` | Git diff |
| `SPC gp` | Preview hunk |
| `]h` | Next git hunk |
| `[h` | Previous git hunk |

---

## Quick Fix List

| Shortcut | Action |
|----------|--------|
| `SPC co` | Open quickfix list |
| `SPC cc` | Close quickfix list |
| `]q` | Next quickfix item |
| `[q` | Previous quickfix item |

---

## Comments

| Shortcut | Action |
|----------|--------|
| `SPC /` | Toggle comment (current line) |
| `v` → `SPC /` | Toggle comment (selection) |

---

## Terminal & Misc

| Shortcut | Action |
|----------|--------|
| `SPC \` | Toggle terminal |
| `SPC da` | Open dashboard |
| `SPC nh` | Clear search highlights |
| `SPC so` | Source current file |
| `SPC cx` | Make file executable |
| `SPC \` | Toggle diagnostics/warnings |
| `SPC P` | Open plugin config |
| `Q` | Run macro in `q` register |

---

> **Tip:** Press `SPC ?` anytime inside Neovim to pull up your interactive cheatsheet powered by which-key.
