return {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        local null_ls = require("null-ls")
        local sources = {
            null_ls.builtins.formatting.clang_format.with({
                extra_args = {
                    "--style={BasedOnStyle: LLVM, AllowShortFunctionsOnASingleLine: None, IndentWidth: 4, TabWidth: 4, ColumnLimit: 160}",
                },
                filetypes = { "c", "cpp" },
            }),
        }
        null_ls.setup({ sources = sources, debug = true })
    end,
}
