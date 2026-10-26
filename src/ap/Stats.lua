return {
    [Spel2AP.permanent_upgrades.Health] = function(data)
        data.startingHealth = data.startingHealth + 1
    end,
    [Spel2AP.permanent_upgrades.Bomb] = function(data)
        data.startingBombs = data.startingBombs + 1
    end,
    [Spel2AP.permanent_upgrades.Rope] = function(data)
        data.startingRopes = data.startingRopes + 1
    end,
    [Spel2AP.permanent_upgrades.CO_Checkpoint] = function(data)
        data.coShortcutCount = data.coShortcutCount + 1
    end
}