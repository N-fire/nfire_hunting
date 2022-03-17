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
    [`a_c_boar`]=           {xPos = 0.0, yPos = 0.0, zPos = 0.0, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_chickenhawk`] =   {xPos = 0.15, yPos = 0.2, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_cormorant`] =     {xPos = 0.15, yPos = 0.2, zPos = 0.4, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_coyote`] =        {xPos = -0.2, yPos = 0.15, zPos = 0.45, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_deer`] =          {xPos = -0.4, yPos = 0.15, zPos = 0.7, xRot = 0.0, yRot = -90.0, zRot = 0.0},
    [`a_c_mtlion`] =        {xPos = -0.25, yPos = 0.0, zPos = 0.6, xRot = 30.0, yRot = -90.0, zRot = 0.0},
    [`a_c_rabbit_01`] =     {xPos = 0.12, yPos = 0.25, zPos = 0.45, xRot = 0.0, yRot = 90.0, zRot = 0.0},
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