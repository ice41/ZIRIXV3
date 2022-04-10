fx_version 'adamant'
game 'gta5'


client_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"coletar.lua",
	"fabricar.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"config.lua",
	"server.lua"
}

ui_page "nui/ui.html"
files {
	"nui/ui.html",
	"nui/ui.js",
	"nui/ui.css"
}