return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('dashboard').setup {
      theme = 'doom',
      config = {
        header = {
          '',
          '',
          [[ ______ _____ _   _ _ _____  ______  ___   _   _ _____ _____     ]],
          [[ |  _  \  _  | \ | ( )_   _| | ___ \/ _ \ | \ | |_   _/  __ \    ]],
          [[ | | | | | | |  \| |/  | |   | |_/ / /_\ \|  \| | | | | /  \/    ]],
          [[ | | | | | | | . ` |   | |   |  __/|  _  || . ` | | | | |        ]],
          [[ | |/ /\ \_/ / |\  |   | |   | |   | | | || |\  |_| |_| \__/\    ]],
          [[ |___/  \___/\_| \_/   \_/   \_|   \_| |_/\_| \_/\___/ \____/    ]],
          '',
          '',
        },
        center = {
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Find File',
            desc_hl = 'String',
            key = 'f',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope find_files',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Recent Files',
            desc_hl = 'String',
            key = 'r',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope oldfiles',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Find Word',
            desc_hl = 'String',
            key = 'g',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'Telescope live_grep',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'New File',
            desc_hl = 'String',
            key = 'n',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'enew',
          },
          {
            icon = '  ',
            icon_hl = 'Title',
            desc = 'Quit',
            desc_hl = 'String',
            key = 'q',
            key_hl = 'Number',
            key_format = ' [%s]',
            action = 'qa',
          },
        },
        footer = function()
          local stats = require('lazy').stats()
          return { '⚡ Loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins' }
        end,
        vertical_center = true,
      },
    }
  end,
}
