require 'settings'

-- lazy.vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
         lazypath})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end
}, {
    "vim-airline/vim-airline",
    cond = not vim.g.vscode
}, {
    "preservim/nerdtree",
    cond = not vim.g.vscode
}, {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    version = "*",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {"javascript", "json", "json5", "jsonc", "lua", "markdown", "markdown_inline", "typescript"}
        })
    end
}, {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "VeryLazy",
    version = "*",
    after = "nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ab"] = "@block.outer",
                        ["ib"] = "@block.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",
                        ["a,"] = "@parameter.outer",
                        ["i,"] = "@parameter.inner",
                        ["at"] = "@statement.outer",
                        ["a/"] = "@comment.outer",
                        ["i/"] = "@comment.inner",
                        ["a#"] = "@call.outer",
                        ["i#"] = "@call.inner"
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                        ["]b"] = "@block.outer",
                        ["]l"] = "@loop.outer",
                        ["]i"] = "@conditional.outer",
                        ["],"] = "@parameter.outer",
                        ["]t"] = "@statement.outer",
                        ["]/"] = "@comment.outer",
                        ["]#"] = "@call.outer"
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                        ["]B"] = "@block.outer",
                        ["]L"] = "@loop.outer",
                        ["]I"] = "@conditional.outer",
                        ["]C"] = "@conditional.outer",
                        ["]P"] = "@parameter.outer",
                        ["]T"] = "@statement.outer",
                        ["]?"] = "@comment.outer",
                        ["]#"] = "@call.outer"
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                        ["[b"] = "@block.outer",
                        ["[l"] = "@loop.outer",
                        ["[i"] = "@conditional.outer",
                        ["[,"] = "@parameter.outer",
                        ["[t"] = "@statement.outer",
                        ["[/"] = "@comment.outer",
                        ["[#"] = "@call.outer"
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                        ["[B"] = "@block.outer",
                        ["[L"] = "@loop.outer",
                        ["[I"] = "@conditional.outer",
                        ["[C"] = "@conditional.outer",
                        ["[P"] = "@parameter.outer",
                        ["[T"] = "@statement.outer",
                        ["[?"] = "@comment.outer",
                        ["[#"] = "@call.outer"
                    }
                }
            }
        })
    end
}})
