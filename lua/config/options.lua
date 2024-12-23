-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- local o = vim.opt
-- o.wildignore = [[
-- .git,.hg,.svn
-- *.aux,*.out,*.toc
-- *.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
-- *.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
-- *.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
-- *.mp3,*.oga,*.ogg,*.wav,*.flac
-- *.eot,*.otf,*.ttf,*.woff
-- *.doc,*.pdf,*.cbr,*.cbz
-- *.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
-- *.swp,.lock,.DS_Store,._*
-- */tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
-- ]]
vim.g.root_spec = { "cwd" }

-- Disable all animations
vim.g.snacks_animate = false

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false

-- Set to false to disable auto format
vim.g.lazyvim_eslint_auto_format = true
