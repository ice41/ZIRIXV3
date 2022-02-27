fx_version 'adamant'
game 'gta5'

author 'ZIRAFLIX'
contact 'E-mail: contato@ziraflix.com - Discord: discord.gg/kYFy8JwVfd'

ui_page('nui/darkside.html')

client_script{
    '@vrp/lib/utils.lua',
    'config.lua',
    'hansolo.lua'
}

server_script {
    '@vrp/lib/utils.lua',
    'config/config.lua',
	'skywalker.lua'
}

files {
    'nui/darkside.html',
    'nui/theforce.css',
    'nui/fonts/AvenirNextRoundedStd-Bold.ttf',
    'nui/fonts/AvenirNextRoundedStd-BoldIt.ttf',
    'nui/fonts/AvenirNextRoundedStd-Demi.ttf',
    'nui/fonts/AvenirNextRoundedStd-DemiIt.ttf',
    'nui/fonts/AvenirNextRoundedStd-Italic.ttf',
    'nui/fonts/AvenirNextRoundedStd-Med.ttf',
    'nui/fonts/AvenirNextRoundedStd-MedIt.ttf',
    'nui/fonts/AvenirNextRoundedStd-Reg.ttf'
}
