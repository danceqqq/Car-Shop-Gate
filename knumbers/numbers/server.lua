

symbols = {
	'A',
	'B',
	'C',
	'Y',
	'O',
	'P',
	'T',
	'E',
	'X',
	'M',
	'H',
	'K'
}


function buyRandomNumbers(ply,veh,region,price)
	local num1 = tostring(math.random(0,9))
	local num2 = tostring(math.random(0,9))
	local num3 = tostring(math.random(0,9))

	local symbol_1 = symbols[math.random(#symbols)]
	local symbol_2 = symbols[math.random(#symbols)]
	local symbol_3 = symbols[math.random(#symbols)]

	local numbers = symbol_1..num1..num2..num3..symbol_2..symbol_3
	local oldNums = getElementData(veh,'numbers')
	takePlayerMoney(ply,price)
	outputChatBox('Поздравляем с получением номеров! Ваши номера: "'..numbers..'|'..region..'"',ply,0,255,0)
	setElementData(veh,'numbers',numbers)
	setElementData(veh,'region',region)
	exports["kautoshop"]:updateNumbers(ply,veh,numbers,region,oldNums)
	local model = getElementModel(veh)
	local login = getAccountName(getPlayerAccount(ply))
	local numbers = numbers..region
	--[[sql.query("SELECT * FROM vehicles WHERE numbers=?",{numbers..region}, function(result)
		if #result == 0 then
			takePlayerMoney(ply,price)
			outputChatBox('Поздравляем с получением номеров! Ваши номера: "'..numbers..'"',ply,0,255,0)
			setElementData(veh,'numbers',numbers)
			setElementData(veh,'region',region)

			local model = getElementModel(veh)
			local login = getAccountName(getPlayerAccount(ply))
			local numbers = numbers..region
			sql.query("UPDATE vehicles SET numbers=? WHERE owner=? AND model=?",{numbers, login,model})
		else

			buyRandomNumbers(ply,veh,region,price)
		end
	end)]]

end
addEvent('numbers:buyRandomNumbers',true)
addEventHandler('numbers:buyRandomNumbers',getRootElement(),buyRandomNumbers)

function buyNumbers(veh,numbers,region,price)
	local ply = source
	takePlayerMoney(ply,price)
	outputChatBox('Поздравляем с получением номеров! Ваши номера: "'..numbers..'"',ply,0,255,0)
	setElementData(veh,'numbers',numbers)
	setElementData(veh,'region',region)
	exports["kautoshop"]:updateNumbers(ply,veh,numbers,region)
	local model = getElementModel(veh)
	local login = getAccountName(getPlayerAccount(ply))

	local numbers = numbers..region
	--sql.query("UPDATE vehicles SET numbers=? WHERE owner=? AND model=?",{numbers, login,model})

end
addEvent('numbers:buyNumbers',true)
addEventHandler('numbers:buyNumbers',getRootElement(),buyNumbers)

function createNumberShopPoints()
	for _,tab in pairs(numberPoints) do
		local pos = tab.pos
		local markerColor = tab.markerColor
		local markerSize = tab.markerSize

		local marker = createMarker(pos[1],pos[2],pos[3],'cylinder',markerSize,unpack(markerColor))
		setElementData(marker,'data',tab)
		
		addEventHandler('onMarkerHit',marker,function(element)
			if getElementType(element) ~= 'player' then return end
			if isGuestAccount(getPlayerAccount(element)) then return end
			local veh = getPedOccupiedVehicle(element)
			if not veh then return end
			--if not getElementData(veh,'owner') then return end

			triggerClientEvent(element,'numbers:startNumberSelect',source,getElementData(source,'data'))
		end)
	end
end
createNumberShopPoints()