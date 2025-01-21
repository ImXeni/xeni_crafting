fx_version 'cerulean'
game 'gta5'

description 'xeni_craftingbenches'
repository ''
version '1.0.0'


shared_scripts {
    '@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'config/client.lua',
    'config/shared.lua',
}

lua54 'yes'
