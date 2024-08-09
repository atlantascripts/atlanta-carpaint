--    #    ####### #          #    #     # #######    #        #####   #####  ######  ### ######  #######  #####
--   # #      #    #         # #   ##    #    #      # #      #     # #     # #     #  #  #     #    #    #     #
--  #   #     #    #        #   #  # #   #    #     #   #     #       #       #     #  #  #     #    #    #
-- #     #    #    #       #     # #  #  #    #    #     #     #####  #       ######   #  ######     #     #####
-- #######    #    #       ####### #   # #    #    #######          # #       #   #    #  #          #          #
-- #     #    #    #       #     # #    ##    #    #     #    #     # #     # #    #   #  #          #    #     #
-- #     #    #    ####### #     # #     #    #    #     #     #####   #####  #     # ### #          #     #####

-- DISCORD SERVER: https://discord.gg/sCMKeZHxS5

Shared = {}
 
Shared.Duration = 10000 -- Millisecond - 1000 = 1 sec
Shared.ItemName = 'spraycan' -- The item name

Shared.Translation = {
    -- Menu
    ['title'] = "Car Paint Customization",
    ['primary'] = "Primary Color",
    ['secondary'] = "Secondary Color",
    ['description'] = "Format: R,G,B",

    -- Notify
    ['success'] = "Your car has been painted successfully!",
    ['invalid_input'] = "Please enter valid RGB values in the format 255,255,255.",
    ['cancelled'] = "You cancelled the painting process.",
    ['novehnearby'] = "You need to be close to a vehicle to use the spray can.",

    -- Progressbar
    ['label'] = "Spraying the car...",
}

RegisterNetEvent('atlanta-carpaint:notify')
AddEventHandler('atlanta-carpaint:notify', function(message)
   -- Example:  ESX.ShowNotification(message)
    lib.notify({
        title = 'Spray Can',
        description = message,
        type = 'info'
    })
end)
