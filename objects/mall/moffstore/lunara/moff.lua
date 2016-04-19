temp = 0

talkLines = {	"Nice clothes you've got there!",
				"You know, clothes belong to moths!",
				"Are you gonna eat those socks over there?",
				"Ever wonder what its like inside a moth?",
				"Feel free to snuggle!",
				"RAWR! I am a ferocious and fluffy moff!"
}

function update(dt)

	temp = math.random(5)
	
	if temp == 1 then
		entity.setAnimationState("bodyState", "gurgle")
	elseif temp < 5 then
		entity.setAnimationState("bodyState", "blink")
	end
	
	if temp < 3 then
		local people = world.entityQuery( entity.position(), 20, {
			includedTypes = {"player"},
			boundMode = "CollisionArea"
		})
		
		if #people > 0 then
			entity.say( talkLines[ math.random( #talkLines ) ] )
		end
	end

end
