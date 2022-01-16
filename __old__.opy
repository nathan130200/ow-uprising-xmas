settings {
    "main": {
        "description": "Code: DEPQR by FRNathan13#1826\n\nSome enemy units has take control from santa's toys factory.\n\nYour object is escort santa's sleigh and eliminate all remaining enemy units, keep toys factory safe and delivery gift for all people in Kings's Row\n\nRecommended Setup (Team 1 / BOTS):\nDifficulty: Hard\n\n2x bastion\n1x Zenyatta\n1x Roadhog\n1x Reaper",
        "modeName": "ARCHIVES - UPRISING (XMAS)"
    },
    "lobby": {
        "mapRotation": "paused",
        "team1Slots": 5,
        "team2Slots": 5,
        "returnToLobby": "afterGame",
        "swapTeamsAfterMatch": false
    },
    "gamemodes": {
        "hybrid": {
            "enabledMaps": [
                "kingsRowWinter"
            ]
        },
        "general": {
            "captureSpeed%": 70,
            "enableEnemyHealthBars": true,
            "gamemodeStartTrigger": "immediately",
            "enableKillCam": false,
            "enableKillFeed": false,
            "payloadSpeed%": 50,
            "spawnHealthPacks": "disabled"
        }
    },
    "heroes": {
        "team2": {
            "general": {
                "health%": 135,
                "movementSpeed%": 125,
            }
        },
        "allTeams": {
            "general": {
                "ammoClipSize%": 200,
                "health%": 120,
                "movementSpeed%": 120,
                "projectileSpeed%": 125
            }
        }
    }
}

#!extension spawnMoreDummyBots

globalvar nodes

playervar temp 38
playervar temp2 39
playervar found 40
playervar itr1 41
playervar itr2 42
playervar result 43

#!define val1(entity) entity.temp[entity.itr1]
#!define val2(entity) entity.temp[entity.itr2]

#!define respawnTime0 random.randint(5, 10)
#!define respawnTime1 random.randint(7, 10)
#!define respawnTime2 random.randint(8, 10)
#!define respawnTime3 random.randint(6, 8)
#!define respawnTime4 random.randint(5, 6)
#!define respawnTime5 random.randint(3, 5)

#!define bossTarget eventPlayer.W
#!define bossTargetTick eventPlayer.X
#!define damageTriggerTick(entity) entity.Y

#!define bossSlot M
#!define bossTrigger N
#!define findPositionsNearPayload(min, max) [n for n in nodes if (maxDistPayload(min, 10) and minDistPayload(n, max))]
#!define findFirstPositionNearPayload(min, max) random.choice(findPositionsNearPayload(min, max))

subroutine FindSpawnPosition
subroutine FindSpawnPositionNearPayload

rule "Initialize nodes":
    nodes = [vect(9.499, -0.134, 10.339), vect(-16.523, 0.264, 5.153), vect(-31.165, 0.049, 17.265), vect(-26.323, 6, 8.413), vect(-18.63, 6.001, -0.493), vect(13.136, 1, 0.08), vect(24.247, 4, -4.032), vect(9.812, 6, -3.671), vect(-0.769, -0.055, -18.044), vect(3.688, -0.14, -24.507), vect(-2.877, 0.147, -42.744), vect(-9.812, -0.121, -29.14), vect(-14.986, 1.024, -15.706), vect(-22.741, 1, -12.746), vect(-21.301, 1, -20.95), vect(-17.564, -0.126, -32.271), vect(-25.442, 0.999, -45.729), vect(-12.514, 0.999, -53.155), vect(-16.754, 6, -45.456), vect(-32.229, 7.199, -43.841), vect(-43.842, 6.956, -13.362), vect(-32.561, 9, -12.015), vect(18.585, 0.068, -19.366), vect(19.298, 6, -36.782), vect(3.192, 6.024, -38.052), vect(5.962, 6.374, -28.538), vect(-12.82, 6.322, -15.582), vect(-41.524, -0.155, -25.626), vect(-54.505, -0.34, -34.117), vect(-55.143, -0.059, -24.074), vect(-56.46, 0.371, -46.955), vect(-48.243, 1.678, -47.935), vect(-38.238, 2, -50.953), vect(-61.552, 0.178, -48.209), vect(-70.071, 0.185, -43.023), vect(-70.103, 0.5, -35.763), vect(-81.527, 2.5, -32.109), vect(-73.143, 4.5, -28.355), vect(-83.311, 3.531, -36.099), vect(-69.943, 4.5, -36.452), vect(-81.282, 0.293, -47.08), vect(-87.844, 0.688, -30.228), vect(-95.21, 8.058, -30.809), vect(-73.24, -0.188, -13.729), vect(-64.5, 0.021, -13.017), vect(-60.659, 3, -4.456), vect(-60.153, 5.02, -12.117), vect(-47.73, 6.958, -15.185), vect(-72.532, 6.021, -13.877), vect(-81.759, 6, -15.735), vect(-89.646, 6.931, -5.056), vect(-102.511, 7.071, -2.383), vect(-104.999, 3.811, 9.179), vect(-110.024, 1.071, 2.743), vect(-101.452, 1.071, 1.56), vect(-95.094, 1.046, 8.638), vect(-107.479, 1.071, -15.065), vect(-115.957, 1.071, -18.415), vect(-125.361, 1.071, -13.833), vect(-136.317, 0.071, -10.78), vect(-134.995, -1.016, -0.777), vect(-123.176, -1.223, -3.69), vect(-107.649, 0.246, -7.219), vect(-94.086, 1.107, -9.657), vect(-89.501, 0.878, -19.604), vect(-78.187, 0.138, -22.488), vect(-120.554, -1.223, 17.055), vect(-112.317, -0.929, 15.956), vect(-110.903, 1.09, 24.729), vect(-111.693, 1.071, 28.562), vect(-124.214, 1.071, 31.632), vect(-129.707, 1.071, 35.514), vect(-142.398, 0.071, 45.007), vect(-159.528, 0.071, 47.583), vect(-156.48, 0.071, 38.717), vect(-157.928, -2.929, 25.6), vect(-142.978, 7.085, 10.534), vect(-130.718, 6.313, 11.259), vect(-128.729, 7.069, 34.008), vect(-154.721, -2.913, 13.704), vect(-151.473, 0.071, 1.882), vect(-167.714, 0.071, 9.088), vect(0.129, -0.118, 2.421), vect(-3.839, 13.951, 17.845)]

#!define minDistPayload(start, len) (distance(payloadPos, start) < len)
#!define maxDistPayload(start, len) (distance(payloadPos, start) > len)
#!define isTrueForAny(array) any([x for x in array if x])
#!define isTrueForAll(array) all([x for x in array if x])
#!define debugHud(text, pos, slot) hudSubtext(hostPlayer, text, pos, slot, Color.WHITE, HudReeval.VISIBILITY_SORT_ORDER_STRING_AND_COLOR, SpecVisibility.DEFAULT)

rule "Debug: Modify spawn points":
    @Event eachPlayer
    @Disabled
    @Condition eventPlayer == hostPlayer
    @Condition eventPlayer.isHoldingButton(Button.INTERACT)

    if eventPlayer.isHoldingButton(Button.CROUCH):
        nodes = []
        playEffect(eventPlayer, DynamicEffect.EXPLOSION_SOUND, null, eventPlayer.getPosition(), 50)
    else:
        nodes[len(nodes)] = eventPlayer.getPosition()
        playEffect(eventPlayer, DynamicEffect.RING_EXPLOSION_SOUND, null, eventPlayer.getPosition(), 50)
    
    wait(1)

globalvar gamemodeState
#!define payloadPercent gamemodeState[0]
#!define payloadPos gamemodeState[1]
#!define capturePercent gamemodeState[2]
#!define numAlivePlayersTeam1 gamemodeState[3]
#!define numAlivePlayersTeam2 gamemodeState[4]

rule "Update shared stats.":
    @Event global
    @Condition not isMatchComplete() and isGameInProgress()
    payloadPercent = updateEveryTick(getPayloadProgressPercentage())
    payloadPos = updateEveryTick(getPayloadPosition())
    capturePercent = updateEveryTick(getCapturePercentage())
    numAlivePlayersTeam1 = len([x for x in getPlayers(Team.1) if x.isAlive()])
    numAlivePlayersTeam2 = len([x for x in getPlayers(Team.2) if x.isAlive()])
    wait(0.5)
    goto RULE_START

rule "Debug: Hud":
    @Event global
    @Disabled
    debugHud("payload percent: {}%\nobjective capture: {}%\npayload position:{}".format(payloadPercent, capturePercent, payloadPos), HudPosition.RIGHT, -1)

rule "Debug: Bots":
    @Event eachPlayer
    @Team 1
    @Disabled
    createInWorldText([x for x in [hostPlayer] if eventPlayer.isAlive()], "{0}({1}) {2}m".format(heroIcon(eventPlayer.getCurrentHero()), eventPlayer.getSlot(), distance(eventPlayer, payloadPos)), eventPlayer, 1.25, Clip.NONE, WorldTextReeval.VISIBILITY_AND_STRING, Color.WHITE, SpecVisibility.DEFAULT)

rule "Spawn point randomizer":
    @Event eachPlayer
    @Team 1
    @Condition not eventPlayer.found and isTrueForAny([eventPlayer.isDead(), eventPlayer.isInSpawnRoom()]) == true
    @Condition not eventPlayer.isDummy()
    @Condition bossTrigger < 2
    
    if payloadPercent <= 1 and capturePercent < 99:
        wait(random.randint(3, 7))
    else:
        if payloadPercent < 10:
            wait(respawnTime0)
        elif payloadPercent > 10 and payloadPercent <= 15:
            wait(respawnTime1)
        elif payloadPercent > 15 and payloadPercent <= 35:
            wait(respawnTime2)
        elif payloadPercent > 35 and payloadPercent <= 75:
            wait(respawnTime3)
        elif payloadPercent > 75 and payloadPercent <= 85:
            wait(respawnTime4)
        elif payloadPercent > 85 and payloadPercent < 95:
            wait(respawnTime5)
        else:
            wait(2)

    FindSpawnPosition()
    
    wait(1)
    if RULE_CONDITION:
        goto RULE_START


rule "Respawn point trigger":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.found
    @Condition not eventPlayer.isDummy()
    eventPlayer.clearStatusEffect(Status.FROZEN)
    eventPlayer.teleport(eventPlayer.result)
    wait(1)
    eventPlayer.resurrect()
    eventPlayer.found = false

def FindSpawnPosition():
    @Name "Find spawn position (generic)"
    eventPlayer.setStatusEffect(null, Status.FROZEN, 9999)
    eventPlayer.found = false
    eventPlayer.temp = []
    eventPlayer.temp2 = []
    
    FindSpawnPositionNearPayload()
    
    if eventPlayer.found:
        eventPlayer.clearStatusEffect(Status.FROZEN)
        return

    eventPlayer.respawn()

def FindSpawnPositionNearPayload():
    @Name "Find spawn position (closest to payload)"
    eventPlayer.temp = [n for n in nodes if (maxDistPayload(n, 10) and minDistPayload(n, 32)) and not isInLoS(n, payloadPos, BarrierLos.BLOCKED_BY_ALL_BARRIERS)]
    
    for eventPlayer.itr1 in range(len(eventPlayer.temp)):
        if all([p for p in getPlayers(Team.2) if not isInLoS(p.getPosition(), val1(eventPlayer), BarrierLos.PASS_THROUGH_BARRIERS)]):
            if len(getPlayersInRadius(val1(eventPlayer), 10, Team.2, LosCheck.OFF)) == 0:
                eventPlayer.temp2.append(val1(eventPlayer))
    
    if len(eventPlayer.temp2) == 0:
        return
    else:
        eventPlayer.found = true
        eventPlayer.result = random.shuffle(random.choice(eventPlayer.temp2))

rule "Respawn Bot":
    @Event playerDied
    @Team 1
    @Condition not eventPlayer.isDummy()
    eventPlayer.disableRespawn()


rule "Bastion: Apply impulse based on its facing":
    @Event eachPlayer
    @Team 1
    @Hero bastion
    @Condition eventPlayer.isAlive() and eventPlayer.isInAlternateForm()
    @Condition bossTrigger == 0
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.startAcceleration(Vector.FORWARD + eventPlayer.getFacingDirection(), 20, 30, Relativity.TO_PLAYER, AccelReeval.DIRECTION_RATE_AND_MAX_SPEED)
    
    wait(1)
    if RULE_CONDITION:
        goto RULE_START

        
        
rule "Bastion: Cancel impulse based on its facing":
    @Event eachPlayer
    @Team 1
    @Hero bastion
    @Condition isTrueForAny([eventPlayer.isDead(), not eventPlayer.isInAlternateForm(), eventPlayer.isUsingUltimate()])
    wait(1, Wait.ABORT_WHEN_FALSE)
    eventPlayer.stopAcceleration()
    
    wait(1)
    if RULE_CONDITION:
        goto RULE_START
    
#!define bastionAimTarget eventPlayer.Z

rule "Bastion: Aim Assist":
    @Event eachPlayer
    @Team 1
    @Hero bastion
    @Condition eventPlayer.isAlive()
    bastionAimTarget = getClosestPlayer(eventPlayer.getPosition(), getOppositeTeam(eventPlayer.getTeam()))
    
    if entityExists(bastionAimTarget):
        eventPlayer.startFacing(directionTowards(eventPlayer, bastionAimTarget), 150, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
        waitUntil(not eventPlayer.isReloading(), 9999)
    
    wait(1)
    if RULE_CONDITION:
        goto RULE_START
        
rule "Update hud for spectators":
    @Event eachPlayer
    @Condition eventPlayer.isAlive() == true
    eventPlayer.enableDeathSpectateTargetHud()

rule "Debug: Skip assemble heroes":
    @Event global
    @Condition isAssemblingHeroes()
    @Disabled
    setMatchTime(1)
    wait(5)
    setMatchTime(45)

rule "Lock player heroes":
    @Event eachPlayer
    @Condition eventPlayer.hasSpawned()
    @Condition isGameInProgress()
    eventPlayer.setAllowedHeroes([eventPlayer.getCurrentHero()])

rule "Fix stuck bots":
    @Event eachPlayer
    @Team 1
    @Condition eventPlayer.isDummy() == false
    @Condition eventPlayer.isStanding()
    wait(10, Wait.ABORT_WHEN_FALSE)
    eventPlayer.setEnvironmentalKillCreditor(hostPlayer)
    kill(eventPlayer, null)

rule "Final Boss":
    @Event global
    @Condition payloadPercent >= 99
    @Condition not entityExists(Z)
    @Condition bossTrigger == 0
    disableGamemodeCompletion()
    bossTrigger = 1
    bossSlot = 5
    
    createDummy(Hero.ORISA, Team.1, bossSlot, nearestWalkablePosition(Vector.UP), Vector.FORWARD)
    bossSlot++
    
    createDummy(Hero.ORISA, Team.1, bossSlot, nearestWalkablePosition(Vector.UP), Vector.FORWARD)
    bossSlot++
    
    createDummy(Hero.JUNKRAT, Team.1, bossSlot, nearestWalkablePosition(Vector.UP), Vector.FORWARD)
    bossSlot++

    createDummy(Hero.JUNKRAT, Team.1, bossSlot, nearestWalkablePosition(Vector.UP), Vector.FORWARD)
    bossSlot++
    
#!define buttonCheck(ent, btn) if eventPlayer.getAbilityCooldown(btn) <= 0.2:\
    wait(0.2)\
    ent.forceButtonPress(btn)

rule "Detect next boss trigger":
    @Event global
    @Condition not isMatchComplete()
    
    if bossTrigger == 1:
        if len([x for x in getPlayers(Team.1) if x.isAlive() and x.isDummy()]) == 0:
            bossTrigger = 2
            return
    
    wait(0.5)
    
    if RULE_CONDITION:
        goto RULE_START

rule "Team 1: Victory":
    @Event global
    @Condition isMatchComplete() == false
    @Condition bossTrigger >= 1
    @Condition numAlivePlayersTeam2 == 0
    declareTeamVictory(Team.1)

rule "Team 2: Victory":
    @Event global
    @Condition isMatchComplete() == false
    @Condition bossTrigger == 2
    @Condition numAlivePlayersTeam1 == 0
    declareTeamVictory(Team.2)

rule "Disable respawn (boss stage)":
    @Event eachPlayer
    @Team 2
    @Condition bossTrigger == 1
    eventPlayer.disableRespawn()
    eventPlayer.forceButtonPress(Button.PRIMARY_FIRE)

#!define safeTeleportPos vect(-118.131, 0.077, 18.878)

rule "Setup final boss":
    @Event eachPlayer
    @Condition eventPlayer.isDummy()
    eventPlayer.found = true
    damageTriggerTick(eventPlayer) = 0
    eventPlayer.addHealthPool(Health.ARMOR, 150, true, false)
    eventPlayer.setStatusEffect(null, Status.INVINCIBLE, 5)
    heal(eventPlayer, null, 9999)
    wait(1)
    eventPlayer.setDamageReceived(50)
    eventPlayer.setDamageDealt(90)
    eventPlayer.setHealingReceived(150)
    eventPlayer.setMoveSpeed(60)
    wait(2)
    eventPlayer.teleport(nearestWalkablePosition(safeTeleportPos))
    setMatchTime(300)
    
    while eventPlayer.isAlive():
        if not entityExists(bossTarget) or bossTarget.isDead():
            bossTarget = random.choice([p for p in getPlayers(Team.2) if p.isAlive() and isInLoS(p, eventPlayer, BarrierLos.PASS_THROUGH_BARRIERS) and p != bossTarget])
            
            if entityExists(bossTarget):
                bossTargetTick = 24 if bossTarget.getNormalizedHealth() <= 0.5 else 12
        
        buttonCheck(eventPlayer, Button.ABILITY_1)
        buttonCheck(eventPlayer, Button.ABILITY_2)
        
        if entityExists(bossTarget):
            eventPlayer.startForcingButton(Button.PRIMARY_FIRE)

            chase(bossTargetTick, 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
            
            if bossTargetTick == 0:
                bossTarget = null
            else:
                eventPlayer.startFacing(directionTowards(eventPlayer, bossTarget), 250, Relativity.TO_WORLD, FacingReeval.DIRECTION_AND_TURN_RATE)
                eventPlayer.startThrottleInDirection(vectorTowards(eventPlayer, bossTarget), max(distance(eventPlayer, bossTarget) - 5, 0), Relativity.TO_WORLD, Throttle.REPLACE_EXISTING, ThrottleReeval.DIRECTION_AND_MAGNITUDE)
    
        eventPlayer.forceButtonPress(Button.ULTIMATE)
        eventPlayer.forceButtonPress(Button.SECONDARY_FIRE)

        if bossTargetTick <= 3:
            eventPlayer.stopForcingButton(Button.PRIMARY_FIRE)
        
        wait(1)

    eventPlayer.disableRespawn()

rule "On boss damage recive, update to new target":
    @Event playerTookDamage
    @Condition victim.isDummy()
    @Condition entityExists(attacker) and attacker != victim
    @Condition damageTriggerTick(victim) == 0
    damageTriggerTick(victim) = 3
    chase(damageTriggerTick(victim), 0, rate=1, ChaseReeval.DESTINATION_AND_RATE)
    eventPlayer.W = attacker

rule "Teleport boss to safe destination":
    @Event eachPlayer
    @Condition eventPlayer.isDummy()
    @Condition distance(eventPlayer, nearestWalkablePosition(eventPlayer)) > 1
    wait(1.25, Wait.ABORT_WHEN_FALSE)
    eventPlayer.teleport(nearestWalkablePosition(safeTeleportPos))
    bossTarget = null

rule "Defeat final boss timeout":
    @Condition entityExists(Z)
    @Condition getMatchTime() <= 1
    declareTeamVictory(Team.1)

rule "Decrease match time if payload is too far away":
    @Event global
    @Condition payloadPercent <= 85
    @Condition bossTrigger
    
    if K == 0:
        bigMessage(getAllPlayers(), "PROTECT PAYLOAD OR YOUR TEAM WILL LOSS")
        K++
    elif K == 1:
        bigMessage(getAllPlayers(), "DEFEND AND DON'T LET PAYLOAD AWAY")
        K++
    else:
        bigMessage(getAllPlayers(), "YOUR TEAM IS LOSING PAYLOAD, GO RECOVERY")
        K = 0
    
    enableGamemodeCompletion()
    setMatchTime(getMatchTime() - 25)
    wait(8)
    
    if RULE_CONDITION:
        goto RULE_START
    
    disableGamemodeCompletion()
