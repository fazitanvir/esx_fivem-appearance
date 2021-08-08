local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local hasAlreadyEnteredMarker = false
local allMyOutfits = {}
local oldPedAppearance 		  = nil
local newPedAppearance 		  = nil 

if not ESX then
	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
	end)
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerLoaded = true
end)

-- RegisterCommand('customization', function()
-- 	local config = {
-- 		ped = true,
-- 		headBlend = true,
-- 		faceFeatures = true,
-- 		headOverlays = true,
-- 		components = true,
-- 		props = true,
-- 	}
-- 	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
-- 		if (appearance) then
-- 			TriggerServerEvent('fivem-appearance:save', appearance)
-- 		end
-- 	end, config)
-- end, false)

Citizen.CreateThread(function()
	for k,v in ipairs(Config.ClothingShops) do
		local data = v
		if data.blip == true then
			local blip = AddBlipForCoord(data.coords)

			SetBlipSprite (blip, 73)
			SetBlipColour (blip, 47)
			SetBlipScale (blip, 0.7)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName('Clothing Shop')
			EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
	for k,v in ipairs(Config.BarberShops) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (blip, 71)
		SetBlipColour (blip, 47)
		SetBlipScale (blip, 0.7)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Barber Shop')
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	for k,v in ipairs(Config.AccessorieShop) do
		local blip = AddBlipForCoord(v)

		SetBlipSprite (362, 71)
		SetBlipColour (blip, 47)
		SetBlipScale (blip, 0.7)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName('Accessory Shop')
		EndTextCommandSetBlipName(blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		local playerCoords, isInClothingShop, isInBarberShop, isInAccessorieShop, currentZone, letSleep = GetEntityCoords(PlayerPedId()), false, false, nil, true
		local sleep = 2000
		for k,v in pairs(Config.ClothingShops) do
			local data = v
			local distance = #(playerCoords - data.coords)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < data.MarkerSize.x then
					isInClothingShop, currentZone = true, k
				end
			end
		end

		for k,v in pairs(Config.BarberShops) do
			local distance = #(playerCoords - v)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < Config.MarkerSize.x then
					isInBarberShop, currentZone = true, k
				end
			end
		end

		for k,v in pairs(Config.AccessorieShop) do
			local distance = #(playerCoords - v)

			if distance < Config.DrawDistance then
				sleep = 0
				if distance < Config.MarkerSize.x then
					isInAccessorieShop, currentZone = true, k
				end
			end
		end

		if (isInClothingShop and not hasAlreadyEnteredMarker) or (isInClothingShop and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker, LastZone = true, currentZone
			CurrentAction     = 'clothingMenu'
			TriggerEvent('cd_drawtextui:ShowUI', 'show', "Press [E] To Change Clothing")
		end

		if (isInBarberShop and not hasAlreadyEnteredMarker) or (isInBarberShop and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker, LastZone = true, currentZone
			CurrentAction     = 'barberMenu'
			TriggerEvent('cd_drawtextui:ShowUI', 'show', "Press [E] To Change Hair/Face")
		end

		if (isInAccessorieShop and not hasAlreadyEnteredMarker) or (isInAccessorieShop and LastZone ~= currentZone) then
			hasAlreadyEnteredMarker, LastZone = true, currentZone
			CurrentAction     = 'AccessorieMenu'
			TriggerEvent('cd_drawtextui:ShowUI', 'show', "Appuyer sur [E] pour regarder le catalogue des masques")
		end

		if not isInClothingShop and not isInBarberShop and not isInAccessorieShop and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			sleep = 1000
			TriggerEvent('fivem-appearance:hasExitedMarker', LastZone)
			TriggerEvent('cd_drawtextui:HideUI')
		end

		Citizen.Wait(sleep)
	end
end)

AddEventHandler('fivem-appearance:hasExitedMarker', function(zone)
	CurrentAction = nil
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction ~= nil then

			if IsControlPressed(1,  38) then
				Citizen.Wait(500)
				local playerPed = PlayerPedId()

				if CurrentAction == 'clothingMenu' then
					TriggerEvent("fivem-appearance:clothingShop")
				end

				if CurrentAction == 'barberMenu' then

					local config = {
						ped = false,
						headBlend = false,
						faceFeatures = false,
						headOverlays = true,
						components = false,
						props = false
					}

					local beforeBarber = exports["fivem-appearance"]:getPedAppearance(playerPed)
					Wait(150)
					
					exports['fivem-appearance']:startPlayerCustomization(function (appearance)
						if (appearance) then
							ESX.TriggerServerCallback('fivem-appearance:BuyOutfit', function(result)
								if result == false then
									print("PAS DE THUNES")
									TriggerEvent('ptable', beforeBarber)
									exports["fivem-appearance"]:setPedAppearance(playerPed, beforeBarber)
								end
							end, Config.BarberShopPrice, appearance, {})
						else
							exports["fivem-appearance"]:setPedAppearance(playerPed, beforeBarber)
						end
					end, config)
				end 

				if CurrentAction == 'AccessorieMenu' then
					OpenAccessorieMenu()
				end

			end
		end
	end
end)

OpenAccessorieMenu = function()
	Citizen.CreateThread(function()
		local cancelled = false
		
		local config = {
			ped = false,
			headBlend = false,
			faceFeatures = false,
			headOverlays = false,
			components = false,
			props = true
		}

		local oldPedAppearance = exports["fivem-appearance"]:getPedAppearance(ESX.PlayerData.ped)
		Wait(150)
		
		if not cancelled then
			exports['fivem-appearance']:startPlayerCustomization(function (appearance)
				if (appearance) then
					local newPedAppearance = exports["fivem-appearance"]:getPedAppearance(ESX.PlayerData.ped)
					local totalPrice = 0
					local boughtCloths = {}
					local pedModel = exports["fivem-appearance"]:getPedModel(ESX.PlayerData.ped)
				
					-- Check if ped is male or female cause some props are visible or not
					local genderIndex = nil 
					if pedModel == 'mp_m_freemode_01' then 
						genderIndex = 1
					elseif pedModel == 'mp_f_freemode_01' then 
						genderIndex = 2
					end
					
					if genderIndex then
						-- Loop into 'player props' table
						for i=1,#newPedAppearance.props,1 do
							local old = oldPedAppearance.props[i]
							local new = newPedAppearance.props[i]
							
							-- If player changed any prop
							if (new.drawable ~= old.drawable) or (new.texture ~= old.texture) then
								
								local itemData = Config.AccessoriesData[new.prop_id]
								
								-- Check if this prop is registered as 'invisible' for the current gender					
								if Config.EmptySlots[itemData.item][new.drawable] ~= nil and Config.EmptySlots[itemData.item][new.drawable][genderIndex] == true then
									print("'"..itemData.item.."' was free! (invisible)")
								else
									boughtCloths[itemData.item] = {
										model = new.drawable,
										color = new.texture
									}
									totalPrice = totalPrice + itemData.price
									print("Bought '"..itemData.item.."' - $"..itemData.price)
								end

							end
						end
						
						for i=1,#newPedAppearance.components,1 do
							local old = oldPedAppearance.components[i]
							local new = newPedAppearance.components[i]
							
							-- If player changed any prop
							if (new.drawable ~= old.drawable) or (new.texture ~= old.texture) then
								
								local itemData = Config.ComponentsData[new.component_id]
								
								-- Check if this prop is registered as 'invisible' for the current gender (THIS IS ONLY USED FOR MASKS)	
								if Config.EmptySlots[itemData.item][new.drawable] ~= nil and Config.EmptySlots[itemData.item][new.drawable][genderIndex] == true then
									print("'"..itemData.item.."' was free! (invisible)")
								else
									if itemData.item ~= nil then
										boughtCloths[itemData.item] = {
											model = new.drawable,
											color = new.texture
										}
									end
									totalPrice = totalPrice + itemData.price
									print("Bought '"..itemData.item.."' - $"..itemData.price)
								end
								
							end
						end
						
						ESX.TriggerServerCallback('fivem-appearance:BuyOutfit', function(result) 
							if not result then 
								exports["fivem-appearance"]:setPedAppearance(ESX.PlayerData.ped, oldPedAppearance)
							end
						end, totalPrice, appearance, boughtCloths)
					end

				else
					exports["fivem-appearance"]:setPedAppearance(ESX.PlayerData.ped, oldPedAppearance)
				end
			end, config)
		end
	end)
end

RegisterNetEvent('fivem-appearance:clothingShop', function()
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "Change clothing",
            txt = "",
			params = {
				event = "fivem-appearance:clothingMenu"
			}
        },
        {
            id = 2,
            header = "Change Outfit",
            txt = "",
            params = {
                event = "fivem-appearance:pickNewOutfit",
                arg1 = {
                    number = 1,
                    id = 2
                }
            }
        },
		{
            id = 3,
            header = "Save New Outfit",
            txt = "",
			params = {
				event = "fivem-appearance:saveOutfit"
			}
        },
		{
			id = 4,
            header = "Delete Outfit",
            txt = "",
            params = {
                event = "fivem-appearance:deleteOutfitMenu",
                arg1 = {
                    number = 1,
                    id = 2
                }
            }
        }
    })
end)

RegisterNetEvent('fivem-appearance:clothingMenu', function()
	local playerPed = PlayerPedId()
	local config = {
		ped = false,
		headBlend = false,
		faceFeatures = false,
		headOverlays = false,
		components = true,
		props = false
	}
	
	local oldPedComponents = exports["fivem-appearance"]:getPedComponents(playerPed)
	Wait(150)

	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			local newPedComponents = exports["fivem-appearance"]:getPedComponents(playerPed)
			local totalPrice = 0
			local boughtCloths = {}
			local pedModel = exports["fivem-appearance"]:getPedModel(playerPed)
				
			-- Check if ped is male or female cause some props are visible or not
			local genderIndex = nil 
			if pedModel == 'mp_m_freemode_01' then 
				genderIndex = 1
			elseif pedModel == 'mp_f_freemode_01' then 
				genderIndex = 2
			end

			if genderIndex then
				for i=1,#newPedComponents,1 do
					local old = oldPedComponents[i]
					local new = newPedComponents[i]
					
					-- If player changed any prop
					local itemData = Config.ComponentsData[new.component_id]
					if (new.drawable ~= old.drawable) or (new.texture ~= old.texture) then
						if Config.EmptySlots[itemData.emptyId][new.drawable] ~= nil and Config.EmptySlots[itemData.emptyId][new.drawable][genderIndex] == true then
							totalPrice = totalPrice
							print("'"..itemData.name.."' was free! (invisible)")
						else 
							totalPrice = totalPrice + itemData.price
							print("Bought '"..itemData.name.."' - $"..itemData.price)
						end
					end
				end
				
				ESX.TriggerServerCallback('fivem-appearance:BuyOutfit', function(result) 
					if not result then 
						exports["fivem-appearance"]:setPedComponents(playerPed, oldPedComponents)
					end
				end, totalPrice, appearance, boughtCloths)
			end

		else
			exports["fivem-appearance"]:setPedComponents(playerPed, oldPedComponents)
		end
	end, config)
end)

RegisterNetEvent('fivem-appearance:cancelOutfit')
AddEventHandler('fivem-appearance:cancelOutfit', function()
	exports["fivem-appearance"]:setPedComponents(PlayerPedId(), oldComponents)
end)

RegisterNetEvent('fivem-appearance:pickNewOutfit', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Retour",
            txt = "",
            params = {
                event = "fivem-appearance:clothingShop"
            }
        },
    })
	Citizen.Wait(300)
	for i=1, #allMyOutfits, 1 do
		TriggerEvent('nh-context:sendMenu', {
			{
				id = (1 + i),
				header = allMyOutfits[i].name,
				txt = "",
				params = {
					event = 'fivem-appearance:setOutfit',
					arg1 = allMyOutfits[i].pedModel, 
					arg2 = allMyOutfits[i].pedComponents, 
					arg3 = allMyOutfits[i].pedProps
				}
			},
		})
	end
end)

RegisterNetEvent('fivem-appearance:getOutfits')
AddEventHandler('fivem-appearance:getOutfits', function()
	TriggerServerEvent('fivem-appearance:getOutfits')
end)

RegisterNetEvent('fivem-appearance:sendOutfits')
AddEventHandler('fivem-appearance:sendOutfits', function(myOutfits)
	local Outfits = {}
	for i=1, #myOutfits, 1 do
		table.insert(Outfits, {id = myOutfits[i].id, name = myOutfits[i].name, pedModel = myOutfits[i].ped, pedComponents = myOutfits[i].components, pedProps = myOutfits[i].props})
	end
	allMyOutfits = Outfits
end)

RegisterNetEvent('fivem-appearance:setOutfit')
AddEventHandler('fivem-appearance:setOutfit', function(pedModel, pedComponents, pedProps)
	local playerPed = PlayerPedId()
	local currentPedModel = exports['fivem-appearance']:getPedModel(playerPed)
	if currentPedModel ~= pedModel then
    	exports['fivem-appearance']:setPlayerModel(pedModel)
		Citizen.Wait(500)
		playerPed = PlayerPedId()
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
	else
		exports['fivem-appearance']:setPedComponents(playerPed, pedComponents)
		exports['fivem-appearance']:setPedProps(playerPed, pedProps)
		local appearance = exports['fivem-appearance']:getPedAppearance(playerPed)
		TriggerServerEvent('fivem-appearance:save', appearance)
	end
end)

RegisterNetEvent('fivem-appearance:saveOutfit', function()
	local keyboard = exports["nh-keyboard"]:KeyboardInput({
		header = "Name Outfit", 
		rows = {
			{
				id = 0, 
				txt = ""
			}
		}
	})
	if keyboard ~= nil then
		local playerPed = PlayerPedId()
		local pedModel = exports['fivem-appearance']:getPedModel(playerPed)
		local pedComponents = exports['fivem-appearance']:getPedComponents(playerPed)
		local pedProps = exports['fivem-appearance']:getPedProps(playerPed)
		Citizen.Wait(500)
		TriggerServerEvent('fivem-appearance:saveOutfit', keyboard[1].input, pedModel, pedComponents, pedProps)
	end
end)

RegisterNetEvent('fivem-appearance:deleteOutfitMenu', function(data)
    local id = data.id
    local number = data.number
	TriggerEvent('fivem-appearance:getOutfits')
	Citizen.Wait(150)
    TriggerEvent('nh-context:sendMenu', {
        {
            id = 1,
            header = "< Go Back",
            txt = "",
            params = {
                event = "fivem-appearance:clothingShop"
            }
        },
    })
	for i=1, #allMyOutfits, 1 do
		TriggerEvent('nh-context:sendMenu', {
			{
				id = (1 + i),
				header = allMyOutfits[i].name,
				txt = "",
				params = {
					event = 'fivem-appearance:deleteOutfit',
					arg1 = allMyOutfits[i].id
				}
			},
		})
	end
end)

RegisterNetEvent('fivem-appearance:deleteOutfit')
AddEventHandler('fivem-appearance:deleteOutfit', function(id)
	TriggerServerEvent('fivem-appearance:deleteOutfit', id)
end)


-- Add compatibility with skinchanger and esx_skin TriggerEvents
RegisterNetEvent('skinchanger:loadSkin')
AddEventHandler('skinchanger:loadSkin', function(skin, cb)
	if not skin.model then skin.model = 'mp_m_freemode_01' end
	exports['fivem-appearance']:setPlayerAppearance(skin)
	if cb ~= nil then
		cb()
	end 
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	local config = {
		ped = false,
		headBlend = true,
		faceFeatures = true,
		headOverlays = true,
		components = true,
		props = false
	}
	
	exports['fivem-appearance']:startPlayerCustomization(function (appearance)
		if (appearance) then
			TriggerServerEvent('fivem-appearance:save', appearance)
			if submitCb() ~= nil then submitCb() end
		elseif cancelCb ~= nil then
			cancelCb()
		end
	end, config)
end)
