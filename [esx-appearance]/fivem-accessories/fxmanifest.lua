fx_version 'adamant'
game 'gta5'

shared_scripts {
	'@es_extended/imports.lua',
	'config.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'client/main.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'	
}