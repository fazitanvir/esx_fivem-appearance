Config = {}

Config.Locale = 'fr'

-- BAG SUPPORT
-- You need to limit players to have only 1 bag in their inventory. Otherwise the bag system wont work properly.
-- Make sure to remove/comment the bag use event in linden_inventory/client/items.lua for each of your bag items.
-- You can define here wich items will be check in player inventory during spawn, to apply the bag component on the player.
-- Those items require at least those metadatas, for example: metadata = {bag = true, model = 82, color = 1}

Config.Bags = false -- enable/disable the bag check system.
Config.WaitForCheck = 10000
Config.bagItems = {
    'bag',
    -- 'small_bag',
}
