resource_manifest_version '05cfa83c-a124-4cfa-a768-c24a5811d8f9'

description 'ESX Jail'

version '1.0.0'

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'server/main.lua',  
  'modules/cells/server.lua'
}

client_scripts {
  '@qte/qte.lua',
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'modules/cells/client.lua',
  'client/main.lua'
}

ui_page {
  'ui/index.html'
}

files {
  'ui/index.html',
  'ui/style.css',
  'ui/main.js',
}