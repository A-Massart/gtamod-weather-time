print("^2[WEATHER AND TIME]^0 Script time chargé !")

local weatherTypes = {
    clear = "CLEAR",
    rain = "RAIN",
    snow = "XMAS",
    thunder = "THUNDER",
    fog = "FOGGY",
    smog = "SMOG",
    overcast = "OVERCAST",
    clouds = "CLOUDS",
    extrasunny = "EXTRASUNNY",
    neutral = "NEUTRAL"
}

RegisterCommand("weather", function(source, args)
    print("^2[WEATHER]^0 Commande /weather détectée")

    local weather = args[1]

    if not weather then
        print("^3[WEATHER]^0 Utilisation : /weather clear")
        print("^3[WEATHER]^0 Types : clear, rain, snow, thunder, fog, smog, overcast, clouds, extrasunny, neutral")
        return
    end

    weather = string.lower(weather)

    local weatherType = weatherTypes[weather]

    if not weatherType then
        print("^1[WEATHER]^0 Météo inconnue : " .. weather)
        return
    end

    print("^2[WEATHER]^0 Changement vers : " .. weatherType)

    SetWeatherTypeNow(weatherType)
    SetWeatherTypeNowPersist(weatherType)
    SetWeatherTypePersist(weatherType)

    print("^2[WEATHER]^0 Météo appliquée !")
end, false)


RegisterCommand("time", function(source, args)
    -- Aucun argument : afficher l'heure actuelle
    if not args[1] then
        local hour = GetClockHours()
        local minute = GetClockMinutes()

        print(string.format(
            "^2[TIME]^0 Heure actuelle : %02d:%02d",
            hour,
            minute
        ))

        return
    end

    -- Récupération de l'heure
    local hour = tonumber(args[1])
    local minute = tonumber(args[2]) or 0

    -- Vérification
    if not hour or not minute then
        print("^1[TIME]^0 Utilisation : time <heure> <minute>")
        print("^3Exemple :^0 time 12 30")
        return
    end

    if hour < 0 or hour > 23 then
        print("^1[TIME]^0 L'heure doit être comprise entre 0 et 23.")
        return
    end

    if minute < 0 or minute > 59 then
        print("^1[TIME]^0 Les minutes doivent être comprises entre 0 et 59.")
        return
    end

    -- Changer l'heure
    NetworkOverrideClockTime(hour, minute, 0)

    print(string.format(
        "^2[TIME]^0 Heure définie sur %02d:%02d",
        hour,
        minute
    ))
end, false)