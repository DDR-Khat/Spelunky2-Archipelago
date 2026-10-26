return {
    [Spel2AP.traps.Poison] = function(player)
        generate_world_particles(PARTICLEEMITTER.POISONEDEFFECT_SKULL, player.uid)
        poison_entity(player.uid)
    end,
    [Spel2AP.traps.Curse] = function(player)
        generate_world_particles(PARTICLEEMITTER.CURSEDEFFECT_SKULL, player.uid)
        player:set_cursed(true, true)
    end,
    [Spel2AP.traps.Ghost] = function(player)
        generate_world_particles(PARTICLEEMITTER.CURSEDEFFECT_SKULL, player.uid)
        play_sound(VANILLA_SOUND.PLAYER_PGHOST_SHAKE, -1)
        local playerX, playerY, playerLayer = get_position(player.uid)
        local _, _, _, ghostY = get_bounds()
        local ghost = get_local_state().theme == THEME.COSMIC_OCEAN and ENT_TYPE.MONS_MEGAJELLYFISH or ENT_TYPE.MONS_GHOST
        spawn(ghost, playerX, math.max(playerY-12, ghostY-4), playerLayer, 0, 0)
        toast(get_string(hash_to_stringid(0x12124976))) -- "Terrible Chill" message
    end,
    [Spel2AP.traps.Stun] = function(player)
        play_sound(VANILLA_SOUND.SHARED_TRIP, player.uid)
        player.stun_timer = 60
        player.velocityx = test_flag(player.flags, ENT_FLAG.FACING_LEFT) and -0.15 or 0.15
        player.velocityy = 0.1
    end,
    [Spel2AP.traps.Loose_Bombs] = function(player)
        local playerX, playerY, playerLayer = get_position(player.uid)
        for _ = 1, 5, 1 do
            spawn(ENT_TYPE.ITEM_BOMB, playerX, playerY, playerLayer, 0, 0)
        end
        toast(get_string(hash_to_stringid(0x4648b314)))
    end,
    [Spel2AP.traps.Blindness] = function(player)
        local playerX, playerY, playerLayer = get_position(player.uid)
        spawn(ENT_TYPE.ITEM_INKSPIT, playerX, playerY, playerLayer, 0, 0)
        toast(get_string(hash_to_stringid(0xf6a18116)))
    end,
    [Spel2AP.traps.Amnesia] = function(player)
        player:set_position(state.level_gen.spawn_x, state.level_gen.spawn_y)
        local playerX, playerY, playerLayer = get_position(player.uid)
        spawn(ENT_TYPE.ITEM_INKSPIT, playerX, playerY, playerLayer, 0, 0)
        play_sound(VANILLA_SOUND.SHARED_TRIP, player.uid)
        player.stun_timer = 60
        player.velocityx = test_flag(player.flags, ENT_FLAG.FACING_LEFT) and -0.15 or 0.15
        player.velocityy = 0.1
        toast(get_string(hash_to_stringid(0x0b62a8b5)))
    end,
    [Spel2AP.traps.Angry_Shopkeepers] = function(_)
        local function SpawnShoppie(x, y)
            spawn_entity_snapped_to_floor(ENT_TYPE.MONS_SHOPKEEPERCLONE, x, y, LAYER.FRONT)
        end
        SpawnShoppie(state.level_gen.spawn_x, state.level_gen.spawn_y)
        for _, door in ipairs(state.level_gen.exit_doors) do
            SpawnShoppie(door.x, door.y)
        end
        toast(get_string(hash_to_stringid(0xdd2b5c3c)))
    end,
    [Spel2AP.traps.Punish_Ball] = function(player)
        generate_world_particles(PARTICLEEMITTER.ALTAR_MONSTER_APPEAR_POOF, player.uid)
        generate_world_particles(PARTICLEEMITTER.CURSEDEFFECT_SKULL, player.uid)
        play_sound(VANILLA_SOUND.TRAPS_KALI_ANGERED, -1)
        attach_ball_and_chain(player.uid, 0, 0)
    end,
}