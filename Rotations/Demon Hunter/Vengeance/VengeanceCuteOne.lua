local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    local RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "Swaps between Single and Multiple based on number of targets in range.", highlight = 1, icon = br.player.spell.soulCleave},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "Multiple target rotation used.", highlight = 0, icon = br.player.spell.soulCleave},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "Single target rotation used.", highlight = 0, icon = br.player.spell.shear},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "Disable DPS Rotation", highlight = 0, icon = br.player.spell.spectralSight}
    };
    br.ui:createToggle(RotationModes,"Rotation",1,0)
    -- Cooldown Button
    local CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "Automatic Cooldowns - Boss Detection.", highlight = 1, icon = br.player.spell.metamorphosis},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "Cooldowns used regardless of target.", highlight = 0, icon = br.player.spell.metamorphosis},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "No Cooldowns will be used.", highlight = 0, icon = br.player.spell.metamorphosis}
    };
   	br.ui:createToggle(CooldownModes,"Cooldown",2,0)
    -- Defensive Button
    local DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "Includes Defensive Cooldowns.", highlight = 1, icon = br.player.spell.demonSpikes},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "No Defensives will be used.", highlight = 0, icon = br.player.spell.demonSpikes}
    };
    br.ui:createToggle(DefensiveModes,"Defensive",3,0)
    -- Interrupt Button
    local InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "Includes Basic Interrupts.", highlight = 1, icon = br.player.spell.consumeMagic},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "No Interrupts will be used.", highlight = 0, icon = br.player.spell.consumeMagic}
    };
    br.ui:createToggle(InterruptModes,"Interrupt",4,0)
    -- Mover
    local MoverModes = {
        [1] = { mode = "On", value = 2 , overlay = "Auto Movement Enabled", tip = "Will Cast Movement Abilities.", highlight = 1, icon = br.player.spell.infernalStrike},
        [2] = { mode = "Off", value = 1 , overlay = "Auto Movement Disabled", tip = "Will NOT Cast Movement Abilities", highlight = 0, icon = br.player.spell.infernalStrike}
    };
    br.ui:createToggle(MoverModes,"Mover",5,0)
    local TankbusterModes = {
        [1] = {mode = "On", value = 1, overlay = "M+ Tankbuster Enabled", tip = "Will use Demon Spikes to Mitigate Tank Busters", highlight = 1, icon = br.player.spell.demonSpikes},
        [2] = {mode = "Off", value = 2, overlay = "M+ Tankbuster Disabled", tip = "Will NOT use Demon Spikes to Mitigate Tank Busters", highlight = 0, icon = br.player.spell.demonSpikes}
    }
    br.ui:createToggle(TankbusterModes,"Tankbuster", 0, 1)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable
    local function rotationOptions()
        local section
        -- General Options
        section = br.ui:createSection(br.ui.window.profile, "General")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS Testing",  5,  5,  60,  5,  "|cffFFFFFFSet to desired time for test in minuts. Min: 5 / Max: 60 / Interval: 5")
            -- Auto Engage
            br.ui:createCheckbox(section, "Auto Engage")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFFSet to desired time to start Pre-Pull (DBM Required). Min: 1 / Max: 10 / Interval: 1")
            -- Fel Devastation
            br.ui:createCheckbox(section, "Fel Devastation")
            -- Immolation Aura
            br.ui:createCheckbox(section,"Immolation Aura")
            -- Sigil of Flame
            br.ui:createCheckbox(section,"Sigil of Flame")
            -- Torment
            br.ui:createCheckbox(section,"Torment")
		    -- Consume Magic
            br.ui:createCheckbox(section,"Consume Magic")
            -- Throw Glaive 
            br.ui:createCheckbox(section,"Throw Glaive")
        br.ui:checkSectionState(section)
        -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "Cooldowns")
            -- Augment Rune
            br.ui:createCheckbox(section,"Augment Rune")
            -- Potion
            br.ui:createCheckbox(section,"Potion")
            -- Basic Flask Module
            br.player.module.FlaskUp("Strength",section)
            -- Basic Trinkets
            br.player.module.BasicTrinkets(nil,section)
            -- Covenant Ability
            br.ui:createDropdownWithout(section, "Covenant Ability", {"|cff0000FFAlways","|cffFFFFFFCD Only","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Covenant Ability")
        br.ui:checkSectionState(section)
        -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "Defensive")
            -- Basic Healing Module
            br.player.module.BasicHealing(section)
            br.ui:createSpinnerWithout(section, "PoS removes Necrotic", 20, 0, 50, 1, "","|cffFFFFFFNecrotic stacks Phial of Serenity to use at")
		    -- Fiery Brand
            br.ui:createSpinner(section, "Fiery Brand",  50,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            -- Demon Spikes
            br.ui:createSpinner(section, "Demon Spikes",  90,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            br.ui:createSpinnerWithout(section, "Hold Demon Spikes", 1, 0, 2, 1, "|cffFFBB00Number of Demon Spikes the bot will hold for manual use.");
            -- Metamorphosis
            br.ui:createSpinner(section, "Metamorphosis",  40,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            -- Sigil of Chains
            br.ui:createSpinner(section, "Sigil of Chains - HP",  50,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            br.ui:createSpinner(section, "Sigil of Chains - AoE", 3, 0, 10, 1, "|cffFFFFFFNumber of Units in 8 Yards to Cast At")
            -- Sigil of Misery
            br.ui:createSpinner(section, "Sigil of Misery - HP",  50,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
            br.ui:createSpinner(section, "Sigil of Misery - AoE", 3, 0, 10, 1, "|cffFFFFFFNumber of Units in 8 Yards to Cast At")
            -- Soul Barrier
            br.ui:createSpinner(section, "Soul Barrier",  70,  0,  100,  5,  "|cffFFBB00Health Percentage to use at.");
        br.ui:checkSectionState(section)
        -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "Interrupts")
            -- Consume Magic
            br.ui:createCheckbox(section, "Disrupt")
            -- Imprison
            br.ui:createCheckbox(section, "Imprison")
            -- Sigil of Silence
            br.ui:createCheckbox(section, "Sigil of Silence")
            -- Sigil of Misery
            br.ui:createCheckbox(section, "Sigil of Misery")
            -- Interrupt Percentage
            br.ui:createSpinnerWithout(section, "Interrupt At",  0,  0,  95,  5,  "|cffFFFFFFCast Percent to Cast At")
        br.ui:checkSectionState(section)
        -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "Toggle Keys")
        -- Single/Multi Toggle
            br.ui:createDropdownWithout(section, "Rotation Mode", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdownWithout(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdownWithout(section, "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdownWithout(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
        -- Mover Key Toggle
            br.ui:createDropdownWithout(section, "Mover Mode", br.dropOptions.Toggle,  6)
        -- Pause Toggle
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "Rotation Options",
        [2] = rotationOptions,
    }}
    return optionTable
end

--------------
--- Locals ---
--------------
-- BR API
local buff
local cast
local cd
local charges
local conduit
local covenant
local debuff
local enemies
local fury
local module
local runeforge
local talent
local ui
local unit
local units
local use
-- Local Lists
local actionList    = {}
local var           = {}
-- WoW Globals to Varaibles
var.getItemInfo     = br._G.GetItemInfo
var.getTime         = br._G.GetTime
var.tonumber        = br._G.tonumber
-- Profile Variables
var.brandBuilt      = false
var.inRaid          = false
var.lastRune        = var.getTime()
var.profileStop     = false

--------------------
--- Action Lists ---
--------------------
-- Action List - Extras
actionList.Extras = function()
    -- Dummy Test
    if ui.checked("DPS Testing") then
        if unit.exists("target") then
            if unit.combatTime() >= (var.tonumber(ui.value("DPS Testing"))*60) and unit.isDummy() then
                unit.stopAttack()
                unit.clearTarget()
                ui.print(var.tonumber(ui.value("DPS Testing")) .." Minute Dummy Test Concluded - Profile Stopped")
                var.profileStop = true
            end
        end
    end -- End Dummy Test
    -- Torment
    if ui.checked("Torment") and cast.able.torment() then
        for i = 1, #enemies.yards30 do
            local thisUnit = enemies.yards30[i]
            if not unit.isTanking(thisUnit) and unit.threat(thisUnit) and not unit.isExplosive(thisUnit) then
                if cast.torment(thisUnit) then ui.debug("Casting Torment [Not Tanking]") return true end
            end
        end
    end
    -- Throw Glaive Aggro
    if ui.checked("Throw Glaive") and cast.able.throwGlaive() then
        for i = 1, #enemies.yards30 do
            local thisUnit = enemies.yards30[i]
            if not unit.isTanking(thisUnit) and unit.threat(thisUnit) and not unit.isExplosive(thisUnit) then
                if cast.throwGlaive(thisUnit) then ui.debug("Casting Throw Glaive [Not Tanking]") return true end
            end
        end
    end
    --Tank buster
    if ui.mode.tankbuster == 1 and unit.inCombat() then
        for i = 1, #enemies.yards30 do
            local thisUnit = enemies.yards30[i]
            if br._G.UnitThreatSituation("player", thisUnit) == 3 and UnitCastingInfo("target") then
                if br.lists.tankBuster[select(9, UnitCastingInfo("target"))] ~= nil then
                    if cd.demonSpikes.ready() and not debuff.fieryBrand.exists(thisUnit) then
                        if cast.demonSpikes() then
                            br.addonDebug("[TANKBUST] Demon Spike")
                            return true
                        end
                    end
                    if cast.able.fieryBrand() and not buff.demonSpikes.exists() then
                        if cast.fieryBrand(thisUnit) then
                            br.addonDebug("[TANKBUST] Fiery Brand")
                            return true
                        end
                    end                
                end
            end
        end
    end  -- End Tankbuster
end -- End Action List - Extras

-- Action List - Defensive
actionList.Defensive = function()
    if ui.useDefensive() then
        -- Soul Barrier
        if ui.checked("Soul Barrier") and unit.inCombat() and cast.able.soulBarrier() and unit.hp() < ui.value("Soul Barrier") then
            if cast.soulBarrier() then ui.debug("Casting Soul Barrier") return true end
        end
        -- Demon Spikes
        -- demon_spikes
        if ui.checked("Demon Spikes") and unit.inCombat() and cast.able.demonSpikes() and charges.demonSpikes.count() > ui.value("Hold Demon Spikes") and unit.hp() <= ui.value("Demon Spikes") then
            -- if (charges.demonSpikes.count() == 2 or not buff.demonSpikes.exists()) and not debuff.fieryBrand.exists(units.dyn5) and not buff.metamorphosis.exists() then
                if cast.demonSpikes() then ui.debug("Casting Demon Spikes") return true end
            -- end
        end
        -- Metamorphosis
        -- metamorphosis,if=!(talent.demonic.enabled)&(!covenant.venthyr.enabled|!dot.sinful_brand.ticking)|target.time_to_die<15
        if ui.checked("Metamorphosis") and unit.inCombat() and cast.able.metamorphosis() and not buff.demonSpikes.exists()
            and not debuff.fieryBrand.exists(units.dyn5) and not buff.metamorphosis.exists() and unit.hp() <= ui.value("Metamorphosis")
            -- and not talent.demonic and (not covenant.venthyr.enabled or debuff.sinfulBrand.exists(units.dyn5))
        then
            if cast.metamorphosis() then ui.debug("Casting Metamorphosis") return true end
        end
        -- Fiery Brand
        -- fiery_brand
        if ui.checked("Fiery Brand") and unit.inCombat() and unit.hp() <= ui.value("Fiery Brand") then
            if not buff.demonSpikes.exists() and not buff.metamorphosis.exists() then
                if cast.fieryBrand() then ui.debug("Casting Fiery Brand") return true end
            end
        end
        -- Basic Healing Module
        module.BasicHealing()
        if ui.checked("PoS removes Necrotic") and unit.instance() and debuff.necroticWound.stacks() >= ui.value("PoS removes Necrotic") and use.able.phialOfSerenity() then
            if use.phialOfSerenity() then return true end
        end
        -- Sigil of Misery
        if ui.checked("Sigil of Misery - HP") and cast.able.sigilOfMisery()
            and unit.hp() <= ui.value("Sigil of Misery - HP") and unit.inCombat() and #enemies.yards8 > 0
        then
            if cast.sigilOfMisery("player","ground") then ui.debug("Casting Sigil of Misery [HP]") return true end
        end
        if ui.checked("Sigil of Misery - AoE") and cast.able.sigilOfMisery()
            and #enemies.yards8 >= ui.value("Sigil of Misery - AoE") and unit.inCombat()
        then
            if cast.sigilOfMisery("best",false,ui.value("Sigil of Misery - AoE"),8) then ui.debug("Casting Sigil of Misery [AOE]") return true end
        end
        -- Sigil of Chains
        if ui.checked("Sigil of Chains - HP") and cast.able.sigilOfChains()
            and unit.hp() <= ui.value("Sigil of Chains - HP") and unit.inCombat() and #enemies.yards8 > 0
        then
            if cast.sigilOfChains("player","ground") then ui.debug("Casting Sigil of Chains [HP]") return true end
        end
        if ui.checked("Sigil of Chains - AoE") and cast.able.sigilOfChains()
            and #enemies.yards8 >= ui.value("Sigil of Chains - AoE") and unit.inCombat()
        then
            if cast.sigilOfChains("best",false,ui.value("Sigil of Chains - AoE"),8) then ui.debug("Casting Sigil of Chains [AOE]") return true end
        end
    end -- End Defensive Toggle
end -- End Action List - Defensive

-- Action List - Interrupts
actionList.Interrupts = function()
    if ui.useInterrupt() then
        for i=1, #enemies.yards30 do
            local thisUnit = enemies.yards30[i]
            if unit.interruptable(thisUnit,ui.value("Interrupt At")) then
                -- Disrupt
                if ui.checked("Disrupt") and cast.able.disrupt(thisUnit) and unit.distance(thisUnit) < 20 then
                    if cast.disrupt(thisUnit) then ui.debug("Casting Disrupt") return true end
                end
                -- Imprison
                if ui.checked("Imprison") and cast.able.imprison(thisUnit) and unit.distance(thisUnit) < 20 then
                    if cast.imprison(thisUnit) then ui.debug("Casting Imprison") return true end
                end
                -- Sigil of Silence
                if ui.checked("Sigil of Silence") and cast.able.sigilOfSilence(thisUnit) and cd.disrupt.remain() > 0 then
                    if cast.sigilOfSilence(thisUnit,"ground",1,8) then ui.debug("Casting Sigil of Silence") return true end
                end
                -- Sigil of Misery
                if ui.checked("Sigil of Misery") and cast.able.sigilOfMisery(thisUnit)
                    and cd.disrupt.remain() > 0 and cd.sigilOfSilence.remain() > 0 and cd.sigilOfSilence.remain() < 45
                then
                    if cast.sigilOfMisery(thisUnit,"ground",1,8) then ui.debug("Casting Sigil of Misery [Interrupt]") return true end
                end
            end
        end
    end -- End useInterrupts check
end -- End Action List - Interrupts

-- Action List - Cooldowns
actionList.Cooldowns = function()
    if unit.exists(units.dyn5) and unit.distance(units.dyn5) < 5 then
        -- Trinkets
        module.BasicTrinkets()
        -- Covenant Abilities
        if ui.alwaysCdNever("Covenant Ability") then
            -- Sinful Brand
            -- sinful_brand,if=!dot.sinful_brand.ticking
            if cast.able.sinfulBrand() and not debuff.sinfulBrand.exists(units.dyn5) then
                if cast.sinfulBrand() then ui.debug("Casting Sinful Brand") return true end
            end
            -- The Hunt
            -- the_hunt
            if cast.able.theHunt() then
                if cast.theHunt() then ui.debug("Casting The Hunt") return true end
            end
            -- Fodder to the Flame
            -- fodder_to_the_flame
            if cast.able.fodderToTheFlame() then
                if cast.fodderToTheFlame() then ui.debug("Casting Fodder to the Flame") return true end
            end
            -- Elysian Decree
            -- elysian_decree
            if cast.able.elysianDecree() then
                if cast.elysianDecree() then ui.debug("Casting Elysian Decree") return true end
            end
        end
    end
end -- End Action List - Cooldowns

-- Action List - FieryBrand
actionList.FieryBrand = function()
    -- Fiery Brand
    -- fiery_brand (ignore if checked for defensive use)
    if cast.able.fieryBrand() then
        if cast.fieryBrand() then ui.debug("Casting Fiery Brand") return true end
    end
    -- Immolation Aura
    -- immolation_aura,if=dot.fiery_brand.ticking
    if ui.checked("Immolation Aura") and cast.able.immolationAura() and debuff.fieryBrand.exists(units.dyn5) and #enemies.yards5 > 0 then
        if cast.immolationAura() then ui.debug("Casting Immolation Aura [Fiery Brand]") return true end
    end
end -- End Action List - PreCombat

-- Action List - Normal
actionList.Normal = function()
    -- Infernal Strike
    -- infernal_strike
    if ui.mode.mover == 1 and cast.able.infernalStrike() and charges.infernalStrike.count() == 2 and #enemies.yards5 > 0 then
        if cast.infernalStrike("player","ground",1,6) then ui.debug("Casting Infernal Strike") return true end
    end
    -- Bulk Extraction
    -- bulk_extraction
    if cast.able.bulkExtraction() then
        if cast.bulkExtraction() then ui.debug("Casting Bulk Extraction") return true end
    end
    -- Spirit Bomb
    -- spirit_bomb,if=((buff.metamorphosis.up&talent.fracture.enabled&soul_fragments>=3)|soul_fragments>=4)
    if cast.able.spiritBomb() and ((buff.metamorphosis.exists() and talent.fracture and buff.soulFragments.stack() >= 3) or buff.soulFragments.stack() >= 4) then
        if cast.spiritBomb() then ui.debug("Casting Spirit Bomb") return true end
    end
    -- Fel Devastation
    -- fel_devastation
    if ui.checked("Fel Devastation") and cast.able.felDevastation() then
        if cast.felDevastation() then ui.debug("Casting Fel Devastation") return true end
    end
    -- Soul Cleave
    -- soul_cleave,if=((talent.spirit_bomb.enabled&soul_fragments=0)|!talent.spirit_bomb.enabled)&((talent.fracture.enabled&fury>=55)|(!talent.fracture.enabled&fury>=70)|cooldown.fel_devastation.remains>target.time_to_die|(buff.metamorphosis.up&((talent.fracture.enabled&fury>=35)|(!talent.fracture.enabled&fury>=50))))
    if cast.able.soulCleave() and ((talent.spiritBomb and buff.soulFragments.stack() == 0) or not talent.spiritBomb)
        and ((talent.fracture and fury >= 55) or (not talent.fracture and fury >= 70) or cd.felDevastation.remains() > unit.ttd(units.dyn5)
            or (buff.metamorphosis.exists() and ((talent.fracture and fury >= 35) or (not talent.fracture and fury >= 50))))
    then
        if cast.soulCleave() then ui.debug("Casting Soul Cleave") return true end
    end
    -- Immolation Aura
    -- immolation_aura,if=((variable.brand_build&cooldown.fiery_brand.remains>10)|!variable.brand_build)&fury<=90
    if ui.checked("Immolation Aura") and cast.able.immolationAura("player") and ((var.brandBuild and cd.fieryBrand.remains() > 10) or not var.brandBuild) and fury <= 90 and #enemies.yards5 > 0 then
        if cast.immolationAura("player") then ui.debug("Casting Immolation Aura") return true end
    end
    -- Felblade
    -- felblade,if=pain<=60
    if cast.able.felblade() and fury <= 60 then
        if cast.felblade() then ui.debug("Casting Felblade") return true end
    end
    -- Fracture
    -- fracture,if=((talent.spirit_bomb.enabled&soul_fragments<=3)|(!talent.spirit_bomb.enabled&((buff.metamorphosis.up&fury<=55)|(buff.metamorphosis.down&fury<=70))))
    if cast.able.fracture() and ((talent.spiritBomb and (fury < 30 or buff.soulFragments.stack() <= 3))
        or (not talent.spiritBomb and ((buff.metamorphosis.exists() and fury <= 55) or (not buff.metamorphosis.exists() and fury <= 70))))
    then
        if cast.fracture() then ui.debug("Casting Fracture") return true end
    end
    -- Sigil of Flame
    -- sigil_of_flame,if=!(covenant.kyrian.enabled&runeforge.razelikhs_defilement.equipped)
    if ui.checked("Sigil of Flame") and cast.able.sigilOfFlame() and not unit.moving(units.dyn5) and #enemies.yards5 > 0
        and not (covenant.kyrian.enabled and runeforge.razelikhsDefilement.equiped)
    then
        if cast.sigilOfFlame("best",false,1,8) then ui.debug("Casting Sigil of Flame") return true end
    end
    -- Shear
    -- shear
    if cast.able.shear() then
        if cast.shear() then ui.debug("Casting Shear") return true end
    end
    -- Throw Glaive
    -- throw_glaive
    if ui.checked("Throw Glaive") and cast.able.throwGlaive() then
        if cast.throwGlaive() then ui.debug("Casting Throw Glaive") return true end
    end
end -- End Action List - Normal

-- Action List - PreCombat
actionList.PreCombat = function()
    if not unit.inCombat() then
        -- Flask / Crystal
        module.FlaskUp("Strength")
        -- Battle Scarred Augment Rune
        -- augmentation
        if ui.checked("Augment Rune") and var.inRaid and not buff.battleScarredAugmentation.exists()
            and use.able.battleScarredAugmentRune() and var.lastRune + unit.gcd(true) < var.getTime()
        then
            if use.battleScarredAugmentRune() then ui.debug("Using Battle Scarred Augment Rune") var.lastRune = var.getTime() return true end
        end
        -- Pre-Pull
        if ui.checked("Pre-Pull Timer") and ui.pullTimer()<= ui.value("Pre-Pull Timer") then
            -- Potion
            -- potion
            if ui.value("Potion") ~= 5 and ui.pullTimer()<= 1 and (var.inRaid or var.inInstance) then
                if ui.value("Potion") == 1 and use.able.potionOfUnbridledFury() then
                    use.potionOfUnbridledFury()
                    ui.debug("Using Potion of Unbridled Fury")
                end
            end
        end -- End Pre-Pull
        -- Pull
        if unit.valid("target") then
            if unit.reaction("target","player") < 4 then
                -- Throw Glaive
                if ui.checked("Throw Glaive") and cast.able.throwGlaive("target") and #enemies.get(10,"target",true) == 1 and ui.checked("Auto Engage") then
                    if cast.throwGlaive("target","aoe") then ui.debug("Casting Throw Glaive [Pre-Pull]") return true end
                end
                -- Torment
                if cast.able.torment("target") and ui.checked("Auto Engage") then
                    if cast.torment("target") then ui.debug("Casting Torment [Pre-Pull]") return true end
                end
            end
            -- Start Attack
            -- auto_attack
            if not br._G.IsAutoRepeatSpell(br._G.GetSpellInfo(6603)) and unit.exists("target") and unit.distance("target") < 5 then
                unit.startAttack("target")
            end
        end -- End Pull
    end -- End No Combat
end -- End Action List - PreCombat

----------------
--- ROTATION ---
----------------
local function runRotation()

---------------
--- Defines ---
---------------
    -- BR API
    buff                                          = br.player.buff
    cast                                          = br.player.cast
    cd                                            = br.player.cd
    charges                                       = br.player.charges
    conduit                                       = br.player.conduit
    covenant                                      = br.player.covenant
    debuff                                        = br.player.debuff
    enemies                                       = br.player.enemies
    fury                                          = br.player.power.fury.amount()
    module                                        = br.player.module
    runeforge                                     = br.player.runeforge
    talent                                        = br.player.talent
    ui                                            = br.player.ui
    unit                                          = br.player.unit
    units                                         = br.player.units
    use                                           = br.player.use
    -- Variable List
    var.inRaid                                    = br.player.instance=="raid"
    -- Dynamic Units
    units.get(5)
    units.get(8,true)
    units.get(20)
    -- Enemies Listss
    enemies.get(5)
    enemies.get(8)
    enemies.get(30)

    -- variable,name=brand_build,value=talent.agonizing_flames.enabled&talent.burning_alive.enabled&talent.charred_flesh.enabled
    var.brandBuild = talent.agonizingFLames and talent.burningAlive and talent.charredFlesh 

    ---------------------
    --- Begin Profile ---
    ---------------------
    -- Profile Stop | Pause
    if not unit.inCombat() and not unit.exists("target") and var.profileStop==true then
        var.profileStop = false
    elseif (unit.inCombat() and var.profileStop==true) or unit.mounted() or unit.flying() or ui.pause() or ui.mode.rotation==4 then
        return true
    else
        if actionList.Defensive() then return true end
        -----------------------
        --- Extras Rotation ---
        -----------------------
        if actionList.Extras() then return true end
        --------------------------
        --- Defensive Rotation ---
        --------------------------
        if not unit.inCombat() then
            if actionList.Defensive() then return true end
        end
        ------------------------------
        --- Out of Combat Rotation ---
        ------------------------------
        if actionList.PreCombat() then return true end
        --------------------------
        --- In Combat Rotation ---
        --------------------------
        if unit.inCombat() and not var.profileStop and unit.valid("target") then
            ------------------------------
            --- In Combat - Interrupts ---
            ------------------------------
            if actionList.Interrupts() then return true end
            ---------------------------
            --- SimulationCraft APL ---
            ---------------------------
            -- Start Attack
            -- auto_attack
            if not br._G.IsAutoRepeatSpell(br._G.GetSpellInfo(6603)) and unit.exists(units.dyn5) and unit.distance(units.dyn5) < 5 then
                unit.startAttack(units.dyn5)
            end
            -- Consume Magic
            if ui.checked("Consume Magic") and cast.able.consumeMagic("target") and cast.dispel.consumeMagic("target") and not unit.isBoss("target") and unit.exists("target") then
                if cast.consumeMagic("target") then ui.debug("Casting Consume Magic") return true end
            end
            -- Throw Glaive
            -- throw_glaive,if=buff.fel_bombardment.stack=5&(buff.immolation_aura.up|!buff.metamorphosis.up)
            if cast.able.throwGlaive() and buff.felBombardment.stack() == 5 and (buff.immolationAura.exists() or not buff.metamorphosis.exists()) then
                if cast.throwGlaive() then ui.debug("Casting Throw Glaive [Fel Bombardment]") return true end
            end
            -- Call Action List - Fiery Brand
            -- call_action_list,name=brand,if=variable.brand_build
            if var.brandBuild then
                if actionList.FieryBrand() then return true end
            end
            -- Call Action List - Defensive
            -- call_action_list,name=defensives
            if actionList.Defensive() then return true end
            -- Call Action List - Cooldowns
            -- call_action_list,name=cooldowns
            if actionList.Cooldowns() then return true end
            -- Call Action List - Normal
            -- call_action_list,name=normal
            if actionList.Normal() then return true end
        end --End In Combat
    end --End Rotation Logic
end -- End runRotation
local id = 581
if br.rotations[id] == nil then br.rotations[id] = {} end
br._G.tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
