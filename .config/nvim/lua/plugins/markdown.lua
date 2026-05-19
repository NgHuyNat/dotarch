return {
  -- Render markdown đẹp trong Neovim
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      -- Hiển thị line breaks
      line_breaks = true,
      -- Tùy chỉnh heading
      headings = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- Hiển thị checkboxes đẹp hơn
      checkbox = {
        unchecked = { icon = "󰄱 " },
        checked = { icon = " " },
      },
      -- Hiển thị code blocks rõ ràng
      code = {
        enabled = true,
        sign = true,
        style = "full",
        width = "block",
        left_pad = 2,
        right_pad = 2,
      },
      -- Hiển thị bullet lists đẹp
      bullet = {
        icons = { "●", "○", "◆", "◇" },
      },
    },
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
  },

  -- Auto-format markdown và tính năng bổ sung
  {
    "preservim/vim-markdown",
    ft = { "markdown" },
    config = function()
      -- Không tự động gập (fold)
      vim.g.vim_markdown_folding_disabled = 1
      -- Hỗ trợ front matter (YAML, TOML, JSON)
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
      -- Hỗ trợ LaTeX math
      vim.g.vim_markdown_math = 1
      -- Auto-insert bullet points
      vim.g.vim_markdown_auto_insert_bullets = 1
      vim.g.vim_markdown_new_list_item_indent = 2
    end,
  },
}