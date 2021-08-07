# Customized version of fivem-appearance to match roleplay servers using ESX Legacy.
  - This repo is an edited version of this: 
  https://github.com/ZiggyJoJo/brp-fivem-appearance

 ## Description 
  I made this to use fivem-appearance on a roleplay server using ESX Legacy.
  With this version you'll probably don't want to use other peds than MP Male & MP Female.
  If you want to use bags as usable items you'll have to make some edits in linden_inventory (I WONT PROVIDE ANY SUPPORT FOR THAT)
  I am very new to development so if you can improve this resource, do not hesitate to contribute to the project !


 ## Requirement
  - <a href='https://github.com/esx-framework/es_extended/tree/legacy'>ESX Legacy</a> or <a href='https://github.com/thelindat/es_extended'>ESX Legacy by TheLindat (recommended)</a>
  - <a href='https://github.com/thelindat/linden_inventory'>linden_inventory</a>


 ## Features
  - Removed Bags and bodyArmor from the menu, it makes more sense to buy them from shops, and I did not want any bodryArmor,
  - Moved Masks into Props tab,
  - When buying from barber shop, you'll pay an unique price,
  - When buying clothings, and save, you'll pay depending of the price of each components,
  - Same for accessories but it gives items,
  - You won't pay for invisible cloths/accessories (example drawable -1 or 0, configurable for EUPs),
  - Add/remove component when use an accessory item,
  - Remove components when drop corresponding an accessory item,
  - Full support for bags but needs that you edit `linden_inventory` to limit 1 bag per player inventory,
  - Tell you if you can't use an accessory who's not working with your gender

 ## How to install 
  - Make sure to disable your old `fivem-appearance` resource
  - Start the 2 included resources `fivem-appearance` & `fivem-accessories` in your server.cfg
  - Add those items intoto  `linden_inventory/shared/items.lua ` :
  ```lua
    - 'hat'
    - 'glasses'
    - 'ear'
    - 'watch'
    - 'bracelet'
    - 'mask'
    - 'bag' -- optionnal
  ```

 ## Configuration
  - You can edit prices into `fivem-appearance/config.lua` (do not touch anything else in thos tables)
  - You should add prices in labels at the bottom of `fivem-appearance/locales/fr.json` so players knows how much they'll pay, example:
  - Go to the bottom of `fivem-accessories/config.lua` to add accessories shop locations,
  - If you have custom EUP you can edit ``fivem-appearance/config.lua` -> `Config.EmptySlots` to register/unregister invisible accessories (follow examples)
  - If you want to use bags, you need to put a limit of 1 bag per player inventory, otherwise this resource won't work properly. You'll need to edit linden_inventory resource and I cant really exaplain how to do it. If anyone want to improve this, you're welcome to send a pull request.

 ## Bags Items 
  As I said, you'll need to add a limit in your inventory to make that feature working properly.
  Personnally, I added a 'limit' key in the metadata table. For example a bag item looks like this into `linden_inventory/shared/shops.lua`:
  ```lua
    { 
      name = 'bag',
      price = 450, 
      metadata = { 
          image = "bag_yellow", -- the image for the item
          bag = true, -- enable bag type from linden inventory system
          slots = 25, -- maximum bag slots
          limit = 1, -- here is the custom value
          model = 82, -- the drawable of the bag who'll be applied on player
          color = 2, -- the color of the bag
          description = "Coulor: Yelllow | Capacity: 25 slots" 
      }
    },
  ```


 ## Known issues
  - Sometimes, the bag does not appear on player spawn (if player is wearing a bag for sure)

 ## Todo
  - Find a better way to put bag on player spawn than just waiting 10seconds,
  - Need to notify when people trying to use invisible accessorie (cause of the gender) ( they already registered in fivem-appearance config)
  - Separate prices for barbeshop items (like cloths)

 ## Bonus
  - I also included some images for linden_inventory to make things better looking

 ## Credits
  - @ZiggyJoJo for this great skin system
  - @dolutattoo# esx_fivem-appearance

