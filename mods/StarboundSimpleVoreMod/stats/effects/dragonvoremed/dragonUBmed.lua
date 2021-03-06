require "/scripts/behavior.lua"
require "/scripts/vec2.lua"
require "/scripts/actions/math.lua"
require "/scripts/actions/movement.lua"
require "/scripts/actions/notification.lua"
require "/scripts/actions/position.lua"
require "/scripts/actions/status.lua"

request = false
singleton = true
stopWatch = 0

function init()

	if effect.duration() >= 30000 then
		status.addPersistentEffects( "requestvore", {"intents", "nofalldamage", "dragonacid", "paralysis"} )
		request = true
		effect.modifyDuration(-30000)
	elseif effect.duration() >= 20000 then
		status.addPersistentEffects( "requestvore", {"intents", "nofalldamage", "paralysis"} )
		request = true
		effect.modifyDuration(-20000)
	elseif effect.duration() >= 10000 then
		status.addEphemeralEffect("intents", 120.0)
		status.addEphemeralEffect("nofalldamage", 120.0)
		status.addEphemeralEffect("dragonacid", 120.0)
		status.addEphemeralEffect("paralysis", 120.0)		
		effect.modifyDuration(-10000)
	else
		status.addEphemeralEffect("intents", 120.0)
		status.addEphemeralEffect("nofalldamage", 120.0)
		status.addEphemeralEffect("paralysis", 120.0)
	end

	if world.entityExists(effect.duration()) then
		pred = effect.duration()
		effect.modifyDuration( 120.0 - effect.duration())
	else
		request = true
		uninit()
	end	
	
end

function update(dt)
	
	if world.entityExists( pred ) then
		vector = world.entityPosition( pred )
	else
		request = true
		uninit()
	end
	
	if vector ~= nil then
		mcontroller.setPosition( vector )
	else
		request = true
		uninit()
	end
	
	if effect.duration() <= 120 and request then
		effect.modifyDuration(1)
	end
	
	if stopWatch <= 120 then
		stopWatch = stopWatch + dt
	end
	
end

function uninit()

	if singleton then
		status.clearPersistentEffects("requestvore")
		status.removeEphemeralEffect("intents")
		status.removeEphemeralEffect("nofalldamage")
		status.removeEphemeralEffect("paralysis")
	
		if stopWatch >= 120 then
			world.spawnProjectile( "eggformshell" , vec2.add( world.entityPosition( entity.id() ), {0,-0.5}) )
			status.addEphemeralEffect("intents", 60.0)
			status.addEphemeralEffect("nofalldamage", 60.0)
			status.addEphemeralEffect("paralysis", 60.0)
		end
		singleton = false
	end
	effect.expire()
end