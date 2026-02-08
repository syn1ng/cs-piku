-- name: [CS] Piku
-- description: does this work The monster from up the- huh? There's no hill? Where'd he come from then?\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

if not _G.charSelectExists then
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
    return 0
end

local TEXT_MOD_NAME = "[CS] Piku"
local CSGRAFFITIPIKU = get_texture_info("pikugraffiti")
local TEX_CHAR_LIFE_ICON = get_texture_info("piku-icon")
local E_MODEL_CHAR = smlua_model_util_get_id("piku_geo")


function PikuFunction(m)
  if m.playerIndex == 0 then
    if m.action == ACT_JUMP or m.action == ACT_DOUBLE_JUMP then
        m.action = ACT_JUMP
        m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x * m.forwardVel * 9000
    end
    if m.action == ACT_WALL_KICK_AIR then
        m.vel.y = 2
    end
  end

end


local ANIMTABLE_PIKU = {
    [_G.charSelect.CS_ANIM_MENU] = 'pikucs'
}

local PALETTE_CHAR = {
    [PANTS]  = "CD2027",
    [SHIRT]  = "CD2027",
    [GLOVES] = "CD2027",
    [SHOES]  = "CD2027",
    [HAIR]   = "CD2027",
    [SKIN]   = "CD2027",
    [CAP]    = "CD2027",
    [EMBLEM] = "CD2027"
}
local PALETTE_NIKU_CHAR = {
    [PANTS]  = "FA9308",
    [SHIRT]  = "FA9308",
    [GLOVES] = "FA9308",
    [SHOES]  = "FA9308",
    [HAIR]   = "FA9308",
    [SKIN]   = "FA9308",
    [CAP]    = "FA9308",
    [EMBLEM] = "FA9308"
}

local VOICETABLE_PIKU = {
    [CHAR_SOUND_OKEY_DOKEY] = nil, -- Starting game
    [CHAR_SOUND_LETS_A_GO] = nil, -- Starting level
    [CHAR_SOUND_PUNCH_YAH] = nil, -- Punch 1
    [CHAR_SOUND_PUNCH_WAH] = nil, -- Punch 2
    [CHAR_SOUND_PUNCH_HOO] = {nil, nil}, -- Punch 3
    [CHAR_SOUND_YAH_WAH_HOO] = {nil, nil, nil}, -- First/Second jump sounds
    [CHAR_SOUND_HOOHOO] = nil, -- Third jump sound
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {nil, nil}, -- Triple jump sounds
    [CHAR_SOUND_UH] = nil, -- Wall bonk
    [CHAR_SOUND_UH2] = nil, -- Landing after long jump
    [CHAR_SOUND_UH2_2] = nil, -- Same sound as UH2; jumping onto ledge
    [CHAR_SOUND_HAHA] = nil, -- Landing triple jump
    [CHAR_SOUND_YAHOO] = {nil, nil, nil}, -- Long jump
    [CHAR_SOUND_DOH] = nil, -- Long jump wall bonk
    [CHAR_SOUND_WHOA] = nil, -- Grabbing ledge
    [CHAR_SOUND_EEUH] = nil, -- Climbing over ledge
    [CHAR_SOUND_WAAAOOOW] = nil, -- Falling a long distance
    [CHAR_SOUND_TWIRL_BOUNCE] = nil, -- Bouncing off of a flower spring
    [CHAR_SOUND_GROUND_POUND_WAH] = nil, 
    [CHAR_SOUND_HRMM] = nil, -- Lifting something
    [CHAR_SOUND_HERE_WE_GO] = nil, -- Star get
    [CHAR_SOUND_SO_LONGA_BOWSER] = nil, -- Throwing Bowser
--DAMAGE
    [CHAR_SOUND_ATTACKED] = nil, -- Damaged
    [CHAR_SOUND_PANTING] = nil, -- Low health
    [CHAR_SOUND_ON_FIRE] = nil, -- Burned
--SLEEP SOUNDS
    [CHAR_SOUND_IMA_TIRED] = nil, -- Mario feeling tired
    [CHAR_SOUND_YAWNING] = nil, -- Mario yawning before he sits down to sleep
    [CHAR_SOUND_SNORING1] = nil, -- Snore Inhale
    [CHAR_SOUND_SNORING2] = nil, -- Exhale
    [CHAR_SOUND_SNORING3] = nil, -- Sleep talking / mumbling
--COUGHING (USED IN THE GAS MAZE)
    [CHAR_SOUND_COUGHING1] = nil, -- Cough take 1
    [CHAR_SOUND_COUGHING2] = nil, -- Cough take 2
    [CHAR_SOUND_COUGHING3] = nil, -- Cough take 3
--DEATH
    [CHAR_SOUND_DYING] = nil, -- Dying from damage
    [CHAR_SOUND_DROWNING] = nil, -- Running out of air underwater
    [CHAR_SOUND_MAMA_MIA] = nil -- Booted out of level
}
local CSloaded = false
local function on_character_select_load()
    
    
    CT_PIKU = _G.charSelect.character_add(
        "Piku", -- Character Name
        "A little red creature who has been mistaken for a monster myth... Poor thing!", -- Description
        "Syning, Sectordub", -- Credits
        "CD2027",           -- Menu Color
        E_MODEL_CHAR,       -- Character Model
        CT_MARIO,           -- Override Character
        TEX_CHAR_LIFE_ICON, -- Life Icon
        1,                  -- Camera Scale
        0                   -- Vertical Offset
    )

 
    _G.charSelect.character_add_palette_preset(E_MODEL_CHAR, PALETTE_CHAR, "Piku")
    _G.charSelect.character_add_palette_preset(E_MODEL_CHAR, PALETTE_NIKU_CHAR, "Niku")

    _G.charSelect.character_add_animations(E_MODEL_CHAR, ANIMTABLE_PIKU)

    _G.charSelect.character_add_voice(E_MODEL_CHAR, VOICETABLE_PIKU)

    _G.charSelect.character_add_graffiti(CT_PIKU, CSGRAFFITIPIKU)


    _G.charSelect.credit_add(TEXT_MOD_NAME, "Syning", "Piku's model")

    _G.charSelect.character_hook_moveset(CT_PIKU, HOOK_MARIO_UPDATE, PikuFunction)
    CSloaded = true
end



hook_event(HOOK_ON_MODS_LOADED, on_character_select_load)
