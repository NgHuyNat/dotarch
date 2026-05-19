return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        hide_gitignored = false, -- Tắt tính năng giấu file bị git ignore
        hide_hidden = false,     -- Luôn hiện file ẩn (dotfiles)
      },
    },
  },
}