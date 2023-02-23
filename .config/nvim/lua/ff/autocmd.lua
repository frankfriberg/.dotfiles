vim.api.nvim_create_augroup('bufcheck', { clear = true })

-- Reload config file on change
vim.api.nvim_create_autocmd('BufWritePost', {
  group   = 'bufcheck',
  pattern = vim.env.MYVIMRC,
  command = 'silent source %'
})

-- Highlight yanks
vim.api.nvim_create_autocmd('TextYankPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function() vim.highlight.on_yank { timeout = 500 } end
})

-- Sync clipboards because I'm easily confused
vim.api.nvim_create_autocmd('TextYankPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function() vim.fn.setreg('+', vim.fn.getreg('*'))
  end
})

-- Start terminal in insert mode
vim.api.nvim_create_autocmd('TermOpen', {
  group   = 'bufcheck',
  pattern = '*',
  command = 'startinsert | set winfixheight'
})

-- Start git messages in insert mode
vim.api.nvim_create_autocmd('FileType', {
  group   = 'bufcheck',
  pattern = { 'gitcommit', 'gitrebase', },
  command = 'startinsert | 1'
})

-- Pager mappings for Manual
vim.api.nvim_create_autocmd('FileType', {
  group    = 'bufcheck',
  pattern  = 'man',
  callback = function()
    vim.keymap.set('n', '<enter>', 'K', { buffer = true })
    vim.keymap.set('n', '<backspace>', '<c-o>', { buffer = true })
  end
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd('BufReadPost', {
  group    = 'bufcheck',
  pattern  = '*',
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos('.', vim.fn.getpos("'\""))
      vim.api.nvim_feedkeys('zz', 'n', true)
    end
  end
})
