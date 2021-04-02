-- by: minipunch
-- for: Initially made for USA Realism RP (https://usarrp.net)
-- purpose: Provide public servants with blips for all other active emergency personnel

local ACTIVE_EMERGENCY_PERSONNEL = {}

local CLIENT_UPDATE_INTERVAL_MS = 3000

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
	TriggerClientEvent("eblips:toggle", person.src, true)
end)

RegisterServerEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	-- remove from list --
	ACTIVE_EMERGENCY_PERSONNEL[src] = nil
	-- deactive blips when off duty --
	TriggerClientEvent("eblips:toggle", src, false)
end)

-- Clean up blip entry for on duty player who leaves --
AddEventHandler("playerDropped", function()
	if ACTIVE_EMERGENCY_PERSONNEL[source] then
		ACTIVE_EMERGENCY_PERSONNEL[source] = nil
	end
end)

Citizen.CreateThread(function()
	while true do
		for id, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
			ACTIVE_EMERGENCY_PERSONNEL[id].coords = GetEntityCoords(GetPlayerPed(id))
			TriggerClientEvent("eblips:updateAll", id, ACTIVE_EMERGENCY_PERSONNEL)
		end
		Wait(CLIENT_UPDATE_INTERVAL_MS)
	end
end)