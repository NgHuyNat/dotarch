-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Markdown keymaps
vim.keymap.set("n", "<leader>um", function()
  require("render-markdown").toggle()
end, { desc = "Toggle Render Markdown" })

-- Markdown formatting shortcuts (chỉ hoạt động trong markdown files)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    local opts = { buffer = true, silent = true }

    -- Bold text: Chọn text và nhấn <leader>mb
    vim.keymap.set("v", "<leader>mb", "c****<Esc>hhp", vim.tbl_extend("force", opts, { desc = "Bold" }))

    -- Italic text: Chọn text và nhấn <leader>mi
    vim.keymap.set("v", "<leader>mi", "c**<Esc>hp", vim.tbl_extend("force", opts, { desc = "Italic" }))

    -- Code inline: Chọn text và nhấn <leader>mc
    vim.keymap.set("v", "<leader>mc", "c``<Esc>hp", vim.tbl_extend("force", opts, { desc = "Code Inline" }))

    -- Strikethrough: Chọn text và nhấn <leader>ms
    vim.keymap.set("v", "<leader>ms", "c~~~~<Esc>hhp", vim.tbl_extend("force", opts, { desc = "Strikethrough" }))

    -- Link: Chọn text và nhấn <leader>ml
    vim.keymap.set("v", "<leader>ml", "c[]()<Esc>hhhp", vim.tbl_extend("force", opts, { desc = "Link" }))

    -- Insert checkbox: <leader>m-
    vim.keymap.set("n", "<leader>m-", "i- [ ] ", vim.tbl_extend("force", opts, { desc = "Insert Checkbox" }))

    -- Toggle checkbox: <leader>mx
    vim.keymap.set("n", "<leader>mx", function()
      local line = vim.api.nvim_get_current_line()
      local new_line
      if line:match("%- %[ %]") then
        new_line = line:gsub("%- %[ %]", "- [x]")
      elseif line:match("%- %[x%]") then
        new_line = line:gsub("%- %[x%]", "- [ ]")
      end
      if new_line then
        vim.api.nvim_set_current_line(new_line)
      end
    end, vim.tbl_extend("force", opts, { desc = "Toggle Checkbox" }))

    -- Insert heading: <leader>m1 đến <leader>m6
    for i = 1, 6 do
      vim.keymap.set(
        "n",
        "<leader>m" .. i,
        "I" .. string.rep("#", i) .. " <Esc>",
        vim.tbl_extend("force", opts, { desc = "Heading " .. i })
      )
    end

    -- Insert horizontal rule: <leader>mh
    vim.keymap.set("n", "<leader>mh", "o---<Esc>", vim.tbl_extend("force", opts, { desc = "Horizontal Rule" }))

    -- Insert code block: <leader>mC
    vim.keymap.set("n", "<leader>mC", "o```<CR>```<Esc>kA", vim.tbl_extend("force", opts, { desc = "Code Block" }))
  end,
})
