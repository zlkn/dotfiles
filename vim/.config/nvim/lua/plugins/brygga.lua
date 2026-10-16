vim.pack.add({
    { src = 'https://github.com/ThorstenRhau/brygga.nvim', version = vim.version.range('*') },
})
require('brygga').setup()
vim.keymap.set('x', '<leader>cs', ':Brygga send<CR>', { desc = 'Send selection to Claude' })
