-- by: minipunch
-- for: USA Realism RP
-- purpose: provide public servant with blips for all other active emergency personnel

local ACTIVE = false
local ACTIVE_EMERGENCY_PERSONNEL = {}

------------
-- events --
------------
RegisterNetEvent("eblips:toggle")
AddEventHandler("eblips:toggle", function(on)
	-- toggle blip display --
	ACTIVE = on
	-- remove all blips if turned off --
	if not ACTIVE then
		RemoveAnyExistingEmergencyBlips()
	end
end)

RegisterNetEvent("eblips:updateAll")
AddEventHandler("eblips:updateAll", function(personnel)
	ACTIVE_EMERGENCY_PERSONNEL = personnel
end)

RegisterNetEvent("eblips:update")
AddEventHandler("eblips:update", function(person)
	ACTIVE_EMERGENCY_PERSONNEL[person.src] = person
end)

RegisterNetEvent("eblips:remove")
AddEventHandler("eblips:remove", function(src)
	RemoveAnyExistingEmergencyBlipsById(src)
end)


---------------
-- functions --
---------------
function RemoveAnyExistingEmergencyBlips()
	for src, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(src)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			ACTIVE_EMERGENCY_PERSONNEL[src] = nil
		end
	end
end

function RemoveAnyExistingEmergencyBlipsById(id)
		local possible_blip = GetBlipFromEntity(GetPlayerPed(GetPlayerFromServerId(id)))
		if possible_blip ~= 0 then
			RemoveBlip(possible_blip)
			ACTIVE_EMERGENCY_PERSONNEL[id] = nil
		end
end

-----------------------------------------------------
-- Watch for emergency personnel to show blips for --
-----------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if ACTIVE then
			for src, info in pairs(ACTIVE_EMERGENCY_PERSONNEL) do
				local player = GetPlayerFromServerId(src)
				local ped = GetPlayerPed(player)
				if GetPlayerPed(-1) ~= ped then
					if GetBlipFromEntity(ped) == 0 then
						local blip = AddBlipForEntity(ped)
						SetBlipSprite(blip, 1)
						SetBlipColour(blip, info.color)
						SetBlipAsShortRange(blip, true)
						SetBlipDisplay(blip, 4)
						SetBlipShowCone(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(info.name)
						EndTextCommandSetBlipName(blip)
					end
				end
			end
		end
		Wait(1)
	end
end)
