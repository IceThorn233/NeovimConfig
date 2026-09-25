vim.api.nvim_create_augroup("GitCommit", {
    clear = true,
})
vim.api.nvim_create_autocmd("BufEnter", {
    group = "GitCommit",
    pattern = {
        "gitcommit",
    },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
})
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local Index = 0
        while Index < vim.fn.argc() do
            local Argument = vim.fn.argv(Index)
            if type(Argument) == "string" and vim.fn.exists(Argument) and vim.fn.isdirectory(Argument) == 1 then
                vim.fn.chdir(Argument)
            end
            Index = Index + 1
        end
    end,
})
