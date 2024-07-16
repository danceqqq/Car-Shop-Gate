

function saveNumbersOffset(m,t)
	local model = m
	local config = t
	local conf = toJSON(config)
	sql.query("SELECT * FROM plateConfig WHERE id=?",{model}, function(result)
		if #result >= 1 then
			sql.query("UPDATE plateConfig SET offset=? WHERE id=?",{conf,model})
		else
			sql.query("INSERT INTO plateConfig VALUES (?,?)",{model,conf})
		end
	end)
	setTimer(function()
		for _,ply in ipairs(getElementsByType('player')) do
			loadPlatePositions(ply)
		end
	end,1000,1)
end
addEvent('saveNumbersOffset',true)
addEventHandler('saveNumbersOffset',getRootElement(),saveNumbersOffset)


function loadPlatePositions(pl)
	local ply = pl
	sql.query("SELECT * FROM plateConfig",nil, function(result)
		for i=1,#result do
			local tab = result[i]
			local model = tab.id
			local config = fromJSON(tab.offset)
			triggerClientEvent(ply,'loadPlatePositions',ply, model,config)
		end
	end)
end
addEventHandler('onPlayerLogin',root,function()
	loadPlatePositions(source)
end)

addEventHandler('onResourceStart',getResourceRootElement(getThisResource()),function()
	for _,ply in ipairs(getElementsByType('player')) do
		loadPlatePositions(ply)
	end
end)

function startPlateConfigEditing(p)
	local ply = p
	local accName = getAccountName(getPlayerAccount(ply))
	if isObjectInACLGroup ("user."..accName, aclGetGroup("Admin")) then
		outputChatBox('ur admin')
		triggerClientEvent(ply,'startPlateConfigEditing',ply)
	end
	outputChatBox('ur not admin')
end
addCommandHandler('plateconfig',startPlateConfigEditing)