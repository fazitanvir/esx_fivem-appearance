-- THIS IS NOT A CONFIG, DO NOT TOUCH!
local cloths = {
	['hat'] =		 { id = 1,  	gender = 'mp_m_freemode_01', 	default = -1,	limit = 152, 	type = 'props'		},
	['glasses'] =	 	 { id = 2,   	gender = 'mp_f_freemode_01', 	default = -1,	limit = 35, 	type = 'props'		},
	['ear'] =		 { id = 3,  	gender = 'mp_m_freemode_01', 	default = -1,	limit = 40, 	type = 'props'		},
	['watch'] =	 	 { id = 4,  	gender = 'mp_m_freemode_01', 	default = -1,	limit = 40, 	type = 'props'		},
	['bracelet'] = 	 	 { id = 5,  	gender = 'mp_f_freemode_01', 	default = -1,	limit = 8, 	type = 'props'		},
	['mask'] =	 	 { id = 2,   	gender = 'mp_f_freemode_01', 	default = 0,	limit = 189, 	type = 'components'	},
}


--? Checking bags in inventory on player spawn
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
	if Config.Bags then CheckBag() end
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

if Config.Bags then
	for _, bagItem in pairs(Config.bagItems) do
		cloths[bagItem] = { id = 6,  	gender = 'mp_m_freemode_01',  	default = 0, 	limit = 88, 	type = 'components' }
	end
	
	--? Opening bags
	RegisterNetEvent('linden_inventory:bag')
	AddEventHandler('linden_inventory:bag', function(item, wait, cb)
		cb(true)
		SetTimeout(wait, function()
			if not cancelled then
				exports['linden_inventory']:OpenStash({ id = "Bag-"..item.metadata.serial, slots = item.metadata.slotAmount, maxWeight = item.metadata.maxWeight })
			end
		end)
	end)
end

AddEventHandler("onResourceStart", function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
        CheckBag()
    end
end)

--? Toggle Accessories on use
for item, v in pairs(cloths) do
	RegisterNetEvent('linden_inventory:'..item)
	AddEventHandler('linden_inventory:'..item, function(item, wait, cb)
		cb(true)
		SetTimeout(wait, function()
			if not cancelled then
				local pedModel, ApplyAccessory, playerAppearance = exports["fivem-appearance"]:getPedModel(ESX.PlayerData.ped), nil, {}
				
				if v.type == 'props' then 
					playerAppearance = exports["fivem-appearance"]:getPedProps(ESX.PlayerData.ped)
				elseif v.type == 'components' then
					playerAppearance = exports["fivem-appearance"]:getPedComponents(ESX.PlayerData.ped)
				end
				
				local model, color = playerAppearance[v.id]['drawable'], playerAppearance[v.id]['texture']
				if item.metadata.model > v.limit and pedModel ~= v.gender then
					ESX.ShowNotification(_U('wrong_gender'))
				else
					if item.metadata.model == model and item.metadata.color == color then
						model = v.default
						color = v.default
					else
						model = item.metadata.model
						color = item.metadata.color
					end
					ApplyAppearance(v.type, playerAppearance, v.id, model, color)
				end
			end
		end)
	end)
end


--? Toggle component on inventory notify
RegisterNetEvent('linden_inventory:itemNotify')
AddEventHandler('linden_inventory:itemNotify', function(item, count, slot, notify)
	if Config.Bags and notify == 'added' then 
		if item.metadata and item.metadata.bag then
			ApplyAppearance(cloths[item.name].type, exports["fivem-appearance"]:getPedComponents(ESX.PlayerData.ped), cloths[item.name].id, item.metadata.model, item.metadata.color)
		end
	elseif notify == 'removed' then
		if item.metadata then
			if Config.Bags and item.metadata.bag then
				ApplyAppearance(cloths[item.name].type, exports["fivem-appearance"]:getPedComponents(ESX.PlayerData.ped), cloths[item.name].id, cloths[item.name].default, cloths[item.name].default)
			elseif item.metadata.model ~= nil then
				local currentAppearance = {}
				if item.name == 'mask' then
					currentAppearance = exports["fivem-appearance"]:getPedComponents(ESX.PlayerData.ped)
				else
					currentAppearance = exports["fivem-appearance"]:getPedProps(ESX.PlayerData.ped)
				end

				if currentAppearance[cloths[item.name].id]['drawable'] == item.metadata.model
				or currentAppearance[cloths[item.name].id]['texture'] == item.metadata.color then
					ApplyAppearance(cloths[item.name].type, currentAppearance, cloths[item.name].id, cloths[item.name].default, cloths[item.name].default)
				end
			end
		end
	end
end)

--? #### Functions ####
ApplyAppearance = function(type, appearance, id, model, color)
	appearance[id]['drawable'] = model
	appearance[id]['texture'] = color
	if type == 'props' then
		exports["fivem-appearance"]:setPedProps(ESX.PlayerData.ped, appearance) 
	elseif type == 'components' then
		print(model, color)
		exports["fivem-appearance"]:setPedComponents(ESX.PlayerData.ped, appearance)
	end
end
exports('ApplyAppearance', ApplyAppearance)

CheckBag = function()
	Citizen.Wait(Config.WaitForCheck)
	ESX.TriggerServerCallback('fivem-accessories:getItemMetadata',function(itemMeta)
		if itemMeta and itemMeta.bag then
			local playerComponents = exports["fivem-appearance"]:getPedComponents(ESX.PlayerData.ped)
			ApplyAppearance('components', playerComponents, cloths['bag'].id, itemMeta.model, itemMeta.color)
		else 
			ApplyAppearance('components', playerComponents, cloths['bag'].id, cloths[item.name].default, cloths[item.name].default)
		end
	end, Config.bagItems)
end
