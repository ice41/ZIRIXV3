fx_version 'adamant'
game 'gta5'

ui_page 'gui/index.html'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'lib/utils.lua',
	'base.lua',
	'queue.lua',
	'zirix/base.lua',
	'zirix/binds.lua',
	'zirix/blips.lua',
	'zirix/groups.lua',
	'zirix/items.lua',
	'zirix/others.lua',
	'zirix/vehicles.lua',
	'modules/aptitude.lua',
	'modules/basic_items.lua',
	'modules/db.lua',
	'modules/group.lua',
	'modules/gui.lua',
	'modules/identity.lua',
	'modules/inventory.lua',
	'modules/map.lua',
	'modules/money.lua',
	'modules/pass.lua',
	'modules/plano.lua',
	'modules/player_state.lua',
	'modules/survival.lua'
}

client_scripts {
	'lib/utils.lua',
	'zirix/base.lua',
	'zirix/binds.lua',
	'zirix/blips.lua',
	'zirix/groups.lua',
	'zirix/items.lua',
	'zirix/others.lua',
	'zirix/vehicles.lua',
	'client/base.lua',
	'client/basic_garage.lua',
	'client/gui.lua',
	'client/identity.lua',
	'client/iplloader.lua',
	'client/keymappings.lua',
	'client/map.lua',
	'client/player_state.lua',
	'client/police.lua',
	'client/survival.lua'
}

files {
	'lib/Tunnel.lua',
	'lib/Proxy.lua',
	'lib/Luaseq.lua',
	'lib/Tools.lua',
	'gui/bebas.ttf',
	'gui/design.css',
	'gui/Div.js',
	'gui/dynamic_classes.js',
	'gui/index.html',
	'gui/main.js',
	'gui/Menu.js',
	'gui/RequestManager.js',
	'gui/WPrompt.js'
}

server_export 'AddPriority'
server_export 'RemovePriority'
