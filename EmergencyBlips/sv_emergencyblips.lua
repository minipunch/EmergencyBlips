-- by: minipunch
-- for: Initially made for USA Realism RP (https://usarrp.net)
-- purpose: Provide public servants with blips for all other active emergency personnel

local ACTIVE_EMERGENCY_PERSONNEL = {}

--[[
person = {
 src = 123,
 color = 3,
 name = "Taylor Weitman"
}
]]

RegisterServerEvent("eblips:add")
AddEventHandler("eblips:add", function(person)
	ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
	for k, v in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		TriggerClientEvent("eblips:updateAll", k, ACTIVE_EMERGENCY_PERSONNEL)
	end
	TriggerClientEvent("eblips:toggle", person.src, true)
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	-- remove from list --
	ACTIVE_EMERGENCY_PERSONNEL[src] = nil
	-- update client blips --
	for k, v in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		TriggerClientEvent("eblips:remove", tonumber(k), src)
	end
	-- deactive blips when off duty --
	TriggerClientEvent("eblips:toggle", src, false)
end)

-- Clean up blip entry for on duty player who leaves --
AddEventHandler("playerDropped", function()
	if ACTIVE_EMERGENCY_PERSONNEL[source] then
		ACTIVE_EMERGENCY_PERSONNEL[source] = nil
	end
end)
