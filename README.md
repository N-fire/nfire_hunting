# nfire_hunting
Fivem Hunting script made for ox_inventory WIP

Item to add :
```lua
	['carcass_boar'] = {
		label = 'Boar Carcass',
		weight = 20000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
	['carcass_hawk'] = {
		label = 'Hawk Carcass',
		weight = 3000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
	['carcass_cormorant'] = {
		label = 'Cormorant Carcass',
		weight = 3000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
	['carcass_coyote'] = {
		label = 'Coyote Carcass',
		weight = 3000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
	['carcass_deer'] = {
		label = 'Deer Carcass',
		weight = 18000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
	['carcass_mtlion'] = {
		label = 'Montain Lion Carcass',
		weight = 16000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
	['carcass_rabbit'] = {
		label = 'Rabbit Carcass',
		weight = 3000,
		stack = false,
		client = {
            add = function()
                TriggerEvent('nfire_hunting:CarryCarcass')
            end,
            remove = function()
				TriggerEvent('nfire_hunting:CarryCarcass')
            end
        }
	},
```
