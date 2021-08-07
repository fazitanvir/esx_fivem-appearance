Config = {}

Config.DrawDistance = 5.0
Config.MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}
Config.MarkerType   = 25

-- Price for barber shop (unique price)
Config.BarberShopPrice = 150

-- Prices configuration - ONLY EDIT PRICES!
Config.AccessoriesData = {
	[0]  = 	{ name = "Hat", 			item = 'hat', 		price = 80	 },
	[1]  = 	{ name = "Glasses", 		item = 'glasses', 	price = 60	 },
	[2]  = 	{ name = "Ear", 			item = 'ear', 		price = 40	 },
	[6]  = 	{ name = "Watch", 			item = 'watch', 	price = 110	 },
	[7]  = 	{ name = "Bracelet", 		item = 'bracelet', 	price = 50	 },
}

Config.ComponentsData = {
	[1]  = 	{ name = "Mask", 			item = 'mask', 			price = 60	},	-- DO NOT MOVE IT in AccessoriesData, mask is still a component!!

	[3]  = 	{ emptyId = 'hands', 		name = "Hands", 	 	price = 0	},
	[4]  = 	{ emptyId = 'legs', 		name = "Legs", 			price = 40 	},
	[6]  = 	{ emptyId = 'shoes', 		name = "Shoes", 		price = 110 },
	[7]  = 	{ emptyId = 'scarfchain', 	name = "Scarf/Chain", 	price = 50 	},
	[8]  = 	{ emptyId = 'shirt', 		name = "Shirt", 		price = 50 	},
	[10] = 	{ emptyId = 'decals', 		name = "Decals", 		price = 50 	},
	[11] = 	{ emptyId = 'jackets', 		name = "Jackets", 		price = 50 	},
}

-- Register invisible cloths for male and female who will be free and wont give any item.
-- I added them in config cause you would probably change some of them if you're using custom cloth replacements.
-- You can add lines with drawable ID and say if its invisible or not for male/female, check example below
Config.EmptySlots = {
	--[example] = {
		--	[1]  	= {false, true} -- model invisible for female only
		--	[2]		= {true, true}, -- model invisible for both
		--	[3]		= {true}, 		-- model invisible for male only
	--}
	['hat'] = {
			[-1]	= {true, true},
			[8]		= {true},
			[11]	= {true},
			[57]	= {false, true},
			[120]  	= {false, true},
			[121]	= {true} 
			-- max male 152 / max female 151
	},
	['glasses'] = {
			[-1]	= {true, true},
			[0]		= {true},
			[5]  	= {false, true},
			[6]		= {true},
			[11]	= {true},
			[12]  	= {false, true},
			[13]  	= {false, true},
			[14]	= {true},
			[15]  	= {false, true}, 
			-- max male 33 / max female 35
	},
	['ear'] = {
			[-1]	= {true, true},
			[0]  	= {false, true},
			[33]	= {true} 
			-- max male 40 / max female 21
	},
	['watch'] = {
			[-1]	= {true, true},
			[1]  	= {false, true},
			[2]		= {true} 
			-- max male 40 / max female 29
	},
	['bracelet'] = {
			[-1]	= {true, true} 
			-- max male 8 / max female 15
	},
	['mask'] = {
			[0]		= {true, true},
			[73]	= {true, true},
			[120]	= {true, true},
			[167]  	= {false, true}, 
			-- max male 189 / max female 189
	},
	--
	['hands'] = {
		-- this one should stay free
		-- max male 195 / max female 240
	},
	['legs'] = {
		[11] 	= {true},
		[13] 	= {false, true},
		[44] 	= {true},
		[46] 	= {false, true},
		-- max male 137 / max female 144
	},
	['shoes'] = {
		[12] 	= {false, true},
		[13] 	= {true},
		[33] 	= {true},
		[34] 	= {true, true},
		[35] 	= {false, true},
		-- max male 101 / max female 105
	},
	['scarfchain'] = {
		[0] 	= {true, true},
		[1] 	= {true},
		[2] 	= {true},
		[3] 	= {true},
		[4] 	= {true},
		[5] 	= {true},
		[6] 	= {true},
		[7] 	= {true},
		[8] 	= {true, true},
		[9] 	= {true},
		[13] 	= {true},
		[14] 	= {true},
		[15] 	= {true},
		[43] 	= {false, true},
		[44] 	= {false, true},
		[45] 	= {false, true},
		[46] 	= {false, true},
		[47] 	= {false, true},
		[48] 	= {false, true},
		[49] 	= {false, true},
		[50] 	= {false, true},
		[51] 	= {false, true},
		[52] 	= {false, true},
		[56] 	= {true},
		[57] 	= {true},
		[58] 	= {true},
		[59] 	= {true},
		[60] 	= {true},
		[61] 	= {true},
		[62] 	= {true},
		[63] 	= {true, true},
		[64] 	= {true},
		[65] 	= {true},
		[66] 	= {true},
		[67] 	= {true},
		[68] 	= {true},
		[69] 	= {true},
		[70] 	= {true},
		[71] 	= {true},
		[72] 	= {true},
		[73] 	= {true},
		[74] 	= {false, true},
		[75] 	= {false, true},
		[76] 	= {false, true},
		[77] 	= {false, true},
		[78] 	= {false, true},
		[79] 	= {false, true},
		[80] 	= {false, true},
		[84] 	= {true},
		[95] 	= {true},
		[96] 	= {true},
		[97] 	= {true},
		[98] 	= {true},
		[99] 	= {true},
		[100] 	= {true},
		[101] 	= {true},
		[102] 	= {true},
		[103] 	= {true},
		[104] 	= {true},
		[105] 	= {true},
		[106] 	= {true},
		[107] 	= {true},
		[108] 	= {true},
		[109] 	= {true},
		-- max male 151 / max female 120
	},
	['shirt'] = {
		[3] 	= {false, true},
		[6] 	= {false, true},
		[7] 	= {false, true},
		[8] 	= {false, true},
		[9] 	= {false, true},
		[10] 	= {false, true},
		[14] 	= {false, true},
		[15] 	= {true, true},
		[34] 	= {false, true},
		-- max male 183 / max female 221
	},
	['decals'] = {
		-- this one should stay free too
		-- max male 119 / max female 127
	},
	['jackets'] = {
		[15] 	= {true, true},
		[82] 	= {false, true},
		[260] 	= {false, true},
		-- max male 195 / max female 399
	},
}

Config.ClothingShops = {
	[1] = {
		blip = true,
		coords = vector3(72.3, -1399.1, 28.4),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[2] = {
		blip = true,
		coords = vector3(-708.71, -152.13, 36.4),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[3] = {
		blip = true,
		coords = vector3(-165.15, -302.49, 38.6),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[4] = {
		blip = true,
		coords = vector3(428.7, -800.1, 28.5),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[5] = {
		blip = true,
		coords = vector3(-829.4, -1073.7, 10.3),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[6] = {
		blip = true,
		coords = vector3(-1449.16, -238.35, 48.8),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[7] = {
		blip = true,
		coords = vector3(11.6, 6514.2, 30.9),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[8] = {
		blip = true,
		coords = vector3(122.98, -222.27, 53.5),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[9] = {
		blip = true,
		coords = vector3(1696.3, 4829.3, 41.1),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[10] = {
		blip = true,
		coords = vector3(618.1, 2759.6, 41.1),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[11] = {
		blip = true,
		coords = vector3(1190.6, 2713.4, 37.2),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[12] = {
		blip = true,
		coords = vector3(-1193.4, -772.3, 16.3),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[13] = {
		blip = true,
		coords = vector3(-3172.5, 1048.1, 19.9),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[14] = {
		blip = true,
		coords = vector3(-1108.4, 2708.9, 18.1),
		MarkerSize   = {x = 7.0, y = 7.0, z = 1.0}
	},
	[15] = {
		blip = false,
		coords = vector3(300.60162353516, -597.76068115234, 42.18409576416),
		MarkerSize   = {x = 3.0, y = 5.0, z = 0.0}
	},
	[17] = {
		blip = false,
		coords = vector3(-1622.6466064453, -1034.0192871094, 13.145475387573),
		MarkerSize   = {x = 2.5, y = 2.0, z = 0.0}
	},
	[18] = {
		blip = false,
		coords = vector3(1861.1047363281, 3689.2331542969, 34.276859283447),
		MarkerSize   = {x = 2.0, y = 2.0, z = 0.0}
	},
	[19] = {
		blip = false,
		coords = vector3(1834.5977783203, 3690.5405273438, 34.270645141602),
		MarkerSize   = {x = 2.0, y = 2.0, z = 0.0}
	},
	[20] = {
		blip = false,
		coords = vector3(1742.1407470703, 2481.5856933594, 45.740657806396),
		MarkerSize   = {x = 4.0, y = 2.0, z = 0.0}
	},
	[21] = {
		blip = false,
		coords = vector3(516.8916015625, 4823.5693359375, -66.18879699707),
		MarkerSize   = {x = 2.0, y = 2.0, z = 0.0}
	},

}

Config.BarberShops = {
	vector3(-814.3, -183.8, 36.6),
	vector3(136.8, -1708.4, 28.3),
	vector3(-1282.6, -1116.8, 6.0),
	vector3(1931.5, 3729.7, 31.8),
	vector3(1212.8, -472.9, 65.2),
	vector3(-34.31, -154.99, 55.8),
	vector3(-278.1, 6228.5, 30.7),
	--vector3(511.12329101562, 4822.935546875, -66.18660736084)
}

Config.AccessorieShop = {
	vector3(-1337.510,-1278.138,4.871),
}