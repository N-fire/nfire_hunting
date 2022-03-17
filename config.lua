Config = {}
Config.Locale = 'en'

Config.carcass  = {
    [`a_c_boar`]= 'carcass_boar',
    [`a_c_chickenhawk`] = 'carcass_hawk',
    [`a_c_cormorant`] = 'carcass_cormorant',
    [`a_c_coyote`] = 'carcass_coyote',
    [`a_c_deer`] = 'carcass_deer',
    [`a_c_mtlion`] = 'carcass_mtlion',
    [`a_c_rabbit_01`] = 'carcass_rabbit'
}


Config.carcassPos  = {
    [`a_c_boar`]= {0.27, 0.15, 0.63, 0.0, 0.5, 0.0},
    [`a_c_chickenhawk`] = {0.27, 0.15, 0.63, 0.5, 0.5, 0.0},
    [`a_c_cormorant`] = {0.27, 0.15, 0.63, 0.5, 0.5, 0.0},
    [`a_c_coyote`] = {0.27, 0.15, 0.63, 0.5, 0.5, 0.0},
    [`a_c_deer`] = {0.27, 0.15, 0.63, 0.5, 0.5, 0.0},
    [`a_c_mtlion`] = {0.27, 0.15, 0.63, 0.5, 0.5, 0.0},
    [`a_c_rabbit_01`] = {0.27, 0.15, 0.63, 0.5, 0.5, 0.0}
}

----------------------------------------------------------------------------------------------------------------------
Locales = {}

function _(str, ...) -- Translate string

	if Locales[Config.Locale] ~= nil then

		if Locales[Config.Locale][str] ~= nil then
			return string.format(Locales[Config.Locale][str], ...)
		else
			return 'Translation [' .. Config.Locale .. '][' .. str .. '] does not exist'
		end

	else
		return 'Locale [' .. Config.Locale .. '] does not exist'
	end

end

function _U(str, ...) -- Translate string first char uppercase
	return tostring(_(str, ...):gsub("^%l", string.upper))
end