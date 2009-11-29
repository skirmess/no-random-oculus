
-- Copyright (c) 2009, Sven Kirmess

local Version = 1

function EventHandler(self, event, ...)

	if ( event == "PLAYER_ENTERING_WORLD" ) then

		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self:RegisterEvent("UPDATE_INSTANCE_INFO")

		DEFAULT_CHAT_FRAME:AddMessage(string.format("NoRandomOculus %i loaded.", Version))

		-- generate an UPDATE_INSTANCE_INFO event when the client is ready to handle it
		RequestRaidInfo()

	elseif ( event == "UPDATE_INSTANCE_INFO" ) then

		self:UnregisterEvent("UPDATE_INSTANCE_INFO")

		local numIDs = GetNumSavedInstances()
		if ( numIDs <= 0 ) then
			DEFAULT_CHAT_FRAME:AddMessage(string.format("NoRandomOculus: No instance IDs found. Neither active nor expired."))
			return
		end

		local i
		for i=1, numIDs, 1 do
			local name, id, reset, difficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName = GetSavedInstanceInfo(i)

			if ( name == NoRandomOculus_Constants.OCULUS ) then
				if ( locked == true ) then
					DEFAULT_CHAT_FRAME:AddMessage(string.format("NoRandomOculus: You are currently saved to Oculus."))
					return
				end

				if ( extended == true ) then
					DEFAULT_CHAT_FRAME:AddMessage(string.format("NoRandomOculus: Your expired ID for Oculus is already extended."))
					return
				end

				DEFAULT_CHAT_FRAME:AddMessage(string.format("NoRandomOculus: Extending you expired ID for Oculus."))
			        SetSavedInstanceExtend(i, true)

				return
			end
		end

		DEFAULT_CHAT_FRAME:AddMessage(string.format("NoRandomOculus: No instance ID for Oculus found. Neither active nor expired."))
	end
end

-- main
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", EventHandler)

