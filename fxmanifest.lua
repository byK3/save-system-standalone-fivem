--[[ 

    ==== Save System - byK3#7147 ====

    This is a simple save system for FiveM. 
    It saves the player's health and armour when they leave the server and loads it when they join back.
    
    Coder: byK3#7147

    Discord message me if you have any questions or need help.


    ==== Save System - byK3#7147 ====

]]


fx_version 'cerulean'

game 'gta5'



client_scripts {
    'client.lua',
}

server_scripts {
    'server.lua',
}

file 'save.json' -- Do not change this line