--This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 2.0 Generic License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/2.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
--https://creativecommons.org/licenses/by-nc-sa/2.0/  @ ZMakesThingsGo & Sheights

function init()
	status.removeEphemeralEffect( "vsokeepsit" );
end

function update(dt)
	status.removeEphemeralEffect( "vsokeepsit" );
	effect.expire();
end

function uninit()
	status.removeEphemeralEffect( "vsokeepsit" );
end
