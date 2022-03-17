Config = {}
Config.Locale = 'en'

Config.animals = {`a_c_boar`,`a_c_chickenhawk`,`a_c_cormorant`,`a_c_coyote`,`a_c_deer`,`a_c_mtlion`,`a_c_rabbit_01`}

Config.carcass  = {
    [`a_c_boar`]= 'carcass_boar',
    [`a_c_chickenhawk`] = 'carcass_hawk',
    [`a_c_cormorant`] = 'carcass_cormorant',
    [`a_c_coyote`] = 'carcass_coyote',
    [`a_c_deer`] = 'carcass_deer',
    [`a_c_mtlion`] = 'carcass_mtlion',
    [`a_c_rabbit_01`] = 'carcass_rabbit'
}
Config.carcasss  = {
    'carcass_boar',
    'carcass_hawk',
    'carcass_cormorant',
    'carcass_coyote',
    'carcass_deer',
    'carcass_mtlion',
    'carcass_rabbit'
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