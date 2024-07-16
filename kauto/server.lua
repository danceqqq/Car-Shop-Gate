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

function getCarLimit(ply)
	return (getElementData(ply,'_carLimit') or 1)
end

function getFreeID()
	local result = dbPoll(dbQuery(db, "SELECT ID FROM VehicleList ORDER BY ID ASC"), -1)
	newID = false
	for i, id in pairs (result) do
		if id["ID"] ~= i then
			newID = i
			break
		end
	end
	if newID then return newID else return #result + 1 end
end

function getVehicleByID(id)
	v = false
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "ID") == id then
			v = veh
			break
		end
	end
	return v
end

function updateVehicleInfo(player)
	if isElement(player) then
		local result = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(player))), -1)
		if type(result) == "table" then
			setElementData(player, "VehicleInfo", result)
		end
	end
end

addEventHandler("onResourceStart", resourceRoot,
function()
	db = dbConnect("sqlite", "database.db")
	dbExec(db, "CREATE TABLE IF NOT EXISTS VehicleList (ID, Account, Model, X, Y, Z, RotZ, Colors, Upgrades, Paintjob, Cost, HP, numbers, region, handlings, fuel)")
	for i, player in ipairs(getElementsByType("player")) do
		updateVehicleInfo(player)
	end
end)

addEvent("onOpenGui", true)
addEventHandler("onOpenGui", root,
function()
	updateVehicleInfo(source)
end)

function destroyVehicle(theVehicle)
	if isElement(theVehicle) then
		local Owner = getElementData(theVehicle, "Owner")
		if Owner then
			local x, y, z = getElementPosition(theVehicle)
			local _, _, rz = getElementRotation(theVehicle)
			local r1, g1, b1, r2, g2, b2 = getVehicleColor(theVehicle, true)
			local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
			upgrade = ""
			for _, upgradee in ipairs (getVehicleUpgrades(theVehicle)) do
				if upgrade == "" then
					upgrade = upgradee
				else
					upgrade = upgrade..","..upgradee
				end
			end
			local Paintjob = getVehiclePaintjob(theVehicle) or 3
			local id = getElementData(theVehicle, "ID")
			local numbers = getElementData(theVehicle,'numbers')
			local region = getElementData(theVehicle,'region')
			local handlings = toJSON(getVehicleHandling(theVehicle))
			local fuel = getElementData(theVehicle,'fuel')
			dbExec(db, "UPDATE VehicleList SET X = ?, Y = ?, Z = ?, RotZ = ?, HP = ?, Colors = ?, Upgrades = ?, Paintjob = ?, numbers=?,region=?,handlings=?,fuel=? WHERE Account = ? AND ID = ?", x, y, z, rz, getElementHealth(theVehicle), color, upgrade, Paintjob,numbers,region,handlings,fuel, getAccountName(getPlayerAccount(Owner)), id)
			updateVehicleInfo(Owner)
			local attached = getAttachedElements(theVehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
		end
		destroyElement(theVehicle)
	end
end

addEvent("onBuyNewVehicle", true)
addEventHandler("onBuyNewVehicle", root, 
function(Model, cost, r1, g1, b1, r2, g2, b2, nospawn)
	abc = false
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ?", getAccountName(getPlayerAccount(source))), -1)
	for i, data in ipairs (data) do
		if data["Model"] == Model then
			abc = false
			break
		end
	end
	local limit = getCarLimit(source)
	if #data+1 > limit then
		outputChatBox('[Автосалон] #FF0000У вас нет мест в гараже, чтобы увеличить кол-во мест купите дом.',source,38, 122, 216)
		return
	end
	--if #data >= 20 then outputChatBox("[Автосалон] #FF0000Извините, но всего можно купить 20 транспортных средств.", source, 38, 122, 216, true) return end
	if abc then outputChatBox("[Автосалон] #FF0000Вы уже имеете этот транспорт", source, 38, 122, 216, true) return end
	if getPlayerMoney(source) >= tonumber(cost) then
		takePlayerMoney ( source, cost )
		local x, y, z = getElementPosition(source)
		local _, _, rz = getElementRotation(source)
		local color = r1..","..g1..","..b1..","..r2..","..g2..","..b2
		if not nospawn then
				vehicle = createVehicle(Model, x-5, y+5, z, 0, 0, rz)
		else
			vehicle = client.vehicle
			vehicle.frozen = false
			vehicle.collisionsEnabled = true
			local sellInfo = vehicle:getData("sellInfo")
			if type(sellInfo) == "table" then --and sellInfo.numbers then				
			 outputChatBox("")
				--setnumbers = sellInfo.numbers
			end
			vehicle:removeData("sellInfo")
		end
		setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
		setElementData(vehicle, "Owner", source)
		local NewID = getFreeID()
		setElementData(vehicle, "ID", NewID)

		--------------

		local numbers = getElementData(vehicle,'numbers')
		local region = getElementData(vehicle,'region')
		if not numbers or numbers == '0' or numbers == 0 then
			local num1 = tostring(math.random(0,9))
			local num2 = tostring(math.random(0,9))
			local num3 = tostring(math.random(0,9))

			local symbol_1 = symbols[math.random(#symbols)]
			local symbol_2 = symbols[math.random(#symbols)]
			local symbol_3 = symbols[math.random(#symbols)]

			numbers = symbol_1..num1..num2..num3..symbol_2..symbol_3
			setElementData(vehicle,'numbers',numbers)
			setElementData(vehicle,'region','76')
			region = '76'
		end
		local fuel = getElementData(vehicle,'fuel')
		-----------
		dbExec(db, "INSERT INTO VehicleList VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", NewID, getAccountName(getPlayerAccount(source)), Model, x-5, y+5, z, rz, color, "", 3, cost, 1000, numbers,region, nil, fuel)
		outputChatBox("[Автосалон] #FFFF00Вы купили данный транснпорту за: "..cost.." руб", source, 38, 122, 216, true)
		updateVehicleInfo(source)
		vv[vehicle] = setTimer(function(source)
			--if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
			if isElement(source) and getElementHealth(source) <= 255 then
				setElementHealth(source, 255.5)
				setVehicleDamageProof(source, true)
				setVehicleEngineState(source, false)
			end
		end, 50, 0, vehicle)
		addEventHandler("onVehicleDamage", vehicle,
		function(loss)
			local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
			setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
		end)
		addEventHandler("onVehicleEnter", vehicle,
		function(player)
			if getElementHealth(source) <= 255.5 then 
				setVehicleEngineState(source, false)
			else
				if isVehicleDamageProof(source) then
					setVehicleDamageProof(source, false)
				end
			end
		end)
	else
		outputChatBox("[Автосалон] #FF0000У вас недостаточно .", source, 38, 122, 216, true)
	end
end)

vv = {}

addEvent("SpawnMyVehicle", true)
addEventHandler("SpawnMyVehicle", root, 
function(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
	if type(data) == "table" and #data ~= 0 then
		if getVehicleByID(id) then
			outputChatBox("[Автосалон] #58FAF4Ваше транспорт #58FAF4уже заспавнен.", source, 38, 122, 216, true)
		else
			local color = split(data[1]["Colors"], ',')
			r1 = color[1] or 255
			g1 = color[2] or 255
			b1 = color[3] or 255
			r2 = color[4] or 255
			g2 = color[5] or 255
			b2 = color[6] or 255
			vehicle = createVehicle(data[1]["Model"], data[1]["X"], data[1]["Y"], data[1]["Z"], 0, 0, data[1]["RotZ"])
			setElementData(vehicle, "ID", id)
			setElementData(vehicle,'numbers',data[1]['numbers'])
			setElementData(vehicle,'region',data[1]['region'])
			setElementData(vehicle,'fuel', data[1]['fuel'])
			local handlings = fromJSON(data[1]['handlings'])
			for key,value in pairs(handlings) do
				setVehicleHandling(vehicle, key, value)
			end

			local upd = split(tostring(data[1]["Upgrades"]), ',')
			for i, upgrade in ipairs(upd) do
				addVehicleUpgrade(vehicle, upgrade)
			end
			local Paintjob = data[1]["Paintjob"] or 3
			setVehiclePaintjob(vehicle, Paintjob) 
			setVehicleColor(vehicle, r1, g1, b1, r2, g2, b2)
			if data[1]["HP"] <= 255.5 then data[1]["HP"] = 255 end
			setElementHealth(vehicle, data[1]["HP"])
			setElementData(vehicle, "Owner", source)
			vv[vehicle] = setTimer(function(source)
		--		if not isElement(source) then killTimer(vv[source]) vv[source] = nil end
				if isElement(source) and getElementHealth(source) <= 255 then
					setElementHealth(source, 255.5)
					setVehicleDamageProof(source, true)
					setVehicleEngineState(source, false)
				end
			end, 50, 0, vehicle)
			addEventHandler("onVehicleDamage", vehicle,
			function(loss)
				local account = getAccountName(getPlayerAccount(getElementData(source, "Owner")))
				setTimer(function(source) if isElement(source) then dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND Model = ?", getElementHealth(source), account, getElementModel(source)) updateVehicleInfo(getElementData(source, "Owner")) end end, 100, 1, source)
			end)
			addEventHandler("onVehicleEnter", vehicle,
			function(player)
				if getElementHealth(source) <= 255.5 then 
					setVehicleEngineState(source, false)
				else
					if isVehicleDamageProof(source) then
						setVehicleDamageProof(source, false)
					end
				end
			end)
			outputChatBox("[Автосалон] #58FAF4Ваш транспорт #00FF00заспавнен.", source, 38, 122, 216, true)
		end
	else
		outputChatBox("[Автосалон] #FF0000Возникла проблема с транспортом, сообщите об этом админу.", source, 38, 122, 216, true)
	end
end)

addEvent("DestroyMyVehicle", true)
addEventHandler("DestroyMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
		if type(data) == "table" and #data ~= 0 then
			local numbers = getElementData(vehicle,'numbers')
			local region = getElementData(vehicle,'region')
			local account = getAccountName(getPlayerAccount(getElementData(vehicle, "Owner")))
			local handlings = toJSON(getVehicleHandling(vehicle))
			local fuel = getElementData(vehicle,'fuel')
			dbExec(db, "UPDATE VehicleList SET numbers = ?,region = ?,handlings = ?,fuel = ? WHERE Account = ? AND Model = ? AND numbers = ?", numbers,region,handlings,fuel, account, getElementModel(vehicle), numbers)
			destroyVehicle(vehicle)
			outputChatBox ("[Автосалон] #58FAF4Ваше транспортное средство #FF0000убрано.", source, 38, 122, 216, true)
		else
			outputChatBox("[Автосалон] #FF0000Выберите для начала транспорт.", source, 38, 122, 216, true)
		end
	else
		outputChatBox("[Автосалон] #58FAF4Ваш транспорт #FF0000не был заспавнен.", source, 38, 122, 216, true)
	end
end)

addEvent("LightsMyVehicle", true)
addEventHandler("LightsMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		local Vehicle = getPedOccupiedVehicle(source)
		if Vehicle == vehicle then
			if getVehicleOverrideLights(vehicle) ~= 2 then
				setVehicleOverrideLights(vehicle, 2)
				outputChatBox("[Автосалон] #58FAF4На Вашем транспорте #00FF00включены фары.", source, 38, 122, 216, true)
			elseif getVehicleOverrideLights(vehicle) ~= 1 then
				setVehicleOverrideLights(vehicle, 1)
				outputChatBox("[Автосалон] #58FAF4На Вашем транспорте #FF0000выключены фары.", source, 38, 122, 216, true)
			end
		else
			outputChatBox("[Автосалон] #FF0000Вы не в автомобиле!", source, 38, 122, 216, true)
		end
	else
		outputChatBox("[Автосалон] #58FAF4Ваш транспорт #FF0000не заспавнен.", source, 38, 122, 216, true)
	end
end)

addEvent("LockMyVehicle", true)
addEventHandler("LockMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, true)
			setVehicleDoorsUndamageable(vehicle, true)
			setVehicleDoorState(vehicle, 0, 0)
			setVehicleDoorState(vehicle, 1, 0)
			setVehicleDoorState(vehicle, 2, 0)
			setVehicleDoorState(vehicle, 3, 0) 
			outputChatBox("[Автосалон] #58FAF4Ваш транспорт #FF0000закрыт.", source, 38, 122, 216, true)
		elseif isVehicleLocked(vehicle) then
			setVehicleLocked(vehicle, false)
			setVehicleDoorsUndamageable(vehicle, false)
			outputChatBox("[Автосалон] #58FAF4Ваш транспорт #00FF00открыт.", source, 38, 122, 216, true)
		end
	else
		outputChatBox("[Автосалон] #58FAF4Ваш транспорт #FF0000не заспавнен.", source, 38, 122, 216, true)
	end
end)

addEvent("BlipMyVehicle", true)
addEventHandler("BlipMyVehicle", root, 
function(id)
	local vehicle = getVehicleByID(id)
	if isElement(vehicle) then
		if not getElementData(vehicle, "ABlip") then
			setElementData(vehicle, "ABlip", true)
			createBlipAttachedTo(vehicle, 41, 2, 255, 0, 0, 255, 0, 65535, source)
			outputChatBox("[Автосалон] #58FAF4Ващ транспорт #00FF00отмечен на карте, #FFFF00используйте F11 чтобы найти его.", source, 38, 122, 216, true)
		else
			local attached = getAttachedElements(vehicle)
			if (attached) then
				for k,element in ipairs(attached) do
					if getElementType(element) == "blip" then
						destroyElement(element)
					end
				end
			end
			setElementData(vehicle, "ABlip", false)
			outputChatBox("[Автосалон] #58FAF4С Вашего транспорта #FF0000снят маркер.", source, 38, 122, 216, true)
		end
	else
		outputChatBox("[Автосалон] #58FAF4Ваш транспорт #FF0000не заспавнен.", source, 38, 122, 216, true)
	end
end)

addEvent("FixMyVehicle", true)
addEventHandler("FixMyVehicle", root, 
function(id)

	if getPlayerMoney(source) >= tonumber(0) then
		takePlayerMoney ( source, 0 )
		local vehicle = getVehicleByID(id)
		if isElement(vehicle) then
			fixVehicle(vehicle)
			setVehicleEngineState(vehicle, true)
			if isVehicleDamageProof(vehicle) then
				setVehicleDamageProof(vehicle, false)
			end
		end
		dbExec(db, "UPDATE VehicleList SET HP = ? WHERE Account = ? AND ID = ?", 1000, getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		outputChatBox ("[Автосалон] #58FAF4Ваш транспорт #00FF00починен.", source, 38, 122, 216, true)
	else
		outputChatBox("[Автосалон] #FF0000У вас недостаточно средств для починки.", source, 38, 122, 216, true)
	end
end)

addEvent("WarpMyVehicle", true)
addEventHandler("WarpMyVehicle", root, 
function(id)
    if not isPedInVehicle (source) then
	if getElementInterior(source) == 0 then
		if getPlayerMoney(source) >= tonumber(0) then
			local vehicle = getVehicleByID(id)
			if isElement(vehicle) then
				takePlayerMoney ( source, 0 )
				local x, y, z = getElementPosition(source)
				setElementPosition(vehicle, x+3, y+2, z+1.5)
				outputChatBox ("[Автосалон] #58FAF4Ваш транспорт #00FF00доставлен к Вам.", source, 38, 122, 216, true)
			else
				outputChatBox("[Автосалон] #58FAF4Ваш транспорт #FF0000не заспавнен.", source, 38, 122, 216, true)
			end
		else
			outputChatBox("[Автосалон] #FF0000У вас нет средств для телепорта транспорта.", source, 38, 122, 216, true)
		end
	else
		outputChatBox("[Автосалон] #FF0000Вы не можете изменять автомобиль, пока Вы внутри.", source, 38, 122, 216, true)
	end
     else
             outputChatBox("[Автосалон] #FF0000Не можем телепортировать Ваш транснпорт .. Пожалуйста, выйдите из другого транспорта .", source, 38, 122, 216, true)
    end
end)
	
addEvent("SellMyVehicle", true)
addEventHandler("SellMyVehicle", root, 
function(id)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	local seconds = time.second
	local vehicle = getVehicleByID(id)
	local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id), -1)
	if type(data) == "table" and #data ~= 0 then
		local Money = math.ceil((data[1]["Cost"]*.9)*math.floor(data[1]["HP"])/100/10)
		givePlayerMoney (source, Money)
		
		if isElement(vehicle) then 
			if not vehicle:getData("sellInfo") then		
				makeSellVehicle(vehicle, Money)
			end 
		end
		dbExec(db, "DELETE FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), id)
		updateVehicleInfo(source)
		outputChatBox("[Автосалон] #FF0000Вы продали свой автомобиль за "..Money"Руб.", source, 38, 122, 216, true)
	end
end)

function getDataOnLogin(_, account)
	updateVehicleInfo(source)
end
addEventHandler("onPlayerLogin", root, getDataOnLogin)

function SaveVehicleDataOnQuit()
	for i, veh in ipairs (getElementsByType("vehicle")) do
		if getElementData(veh, "Owner") == source then
			destroyVehicle(veh)
		end
	end
end
addEventHandler("onPlayerQuit", root,SaveVehicleDataOnQuit)

addEvent("inviteToBuyCarSended", true)
addEventHandler("inviteToBuyCarSended", root, 
function(player, price, veh_name, veh_id)
	if player and price and veh_name and veh_id then
		local pl = getPlayerFromName ( player )
		if pl then
			triggerClientEvent ( pl, "recieveInviteToBuyCar", pl, getPlayerName (source), getAccountName(getPlayerAccount(source)), price, veh_name, veh_id )
		else
			outputChatBox ( "Игрок не найден, продажа отменена", source, 250, 10, 10)
			triggerClientEvent ( source, "cleanCarInvitations", source )
		end
	end
end)


addEvent("invitationBuyCarNotAccepted", true)
addEventHandler("invitationBuyCarNotAccepted", root, 
function(player, acc, price, veh_name, veh_id)
	local pl = getPlayerFromName ( player )
	if pl then
		triggerClientEvent ( pl, "cleanCarInvitations", pl )
		outputChatBox ( "Игрок отказался покупать ваше авто", pl, 250, 10, 10)
	end 
end)

addEvent("invitationBuyCarAccepted", true)
addEventHandler("invitationBuyCarAccepted", root, 
function(player, acc, price, veh_name, veh_id)
	local pl = getPlayerFromName ( player )
	local avail = false
	if pl and getAccountName ( getPlayerAccount (pl)) == acc then
		avail = true
		triggerClientEvent ( pl, "cleanCarInvitations", pl )
		--outputChatBox ( "Игрок отказался покупать ваше авто", pl, 250, 10, 10)
	else
		for i, v in ipairs( getElementsByType ( 'player' ) ) do
			if getAccountName(getPlayerAccount ( v )) == acc then
				avail = true
				pl = v
				break
			end
		end
	end
	price = tonumber(price) or 0
	if avail then
		if isGuestAccount ( getPlayerAccount ( source ) ) then
			triggerClientEvent ( pl, "cleanCarInvitations", pl )
			outputChatBox ( "Вы не зашли в аккаунт, сделка отменена", source, 250, 10, 10 )
			outputChatBox ( "Игрок не зашел в аккаунт, сделка отменена", pl, 250, 10, 10 )
			return true
		end
		if getPlayerMoney ( source ) >= price then
			local vehicle = getVehicleByID(tonumber(veh_id))
			local data = dbPoll(dbQuery(db, "SELECT * FROM VehicleList WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(pl)), veh_id), -1)
			if type(data) == "table" and #data ~= 0 and isElement ( vehicle ) then
				givePlayerMoney ( pl, price )
				takePlayerMoney ( source, price )		
				dbExec(db, "UPDATE VehicleList SET Account = ? WHERE Account = ? AND ID = ?", getAccountName(getPlayerAccount(source)), getAccountName(getPlayerAccount(pl)), veh_id)
				updateVehicleInfo(source)
				updateVehicleInfo(pl)
				setElementData(vehicle, "Owner", source)
				setElementData(vehicle, "ownercar", getAccountName(getPlayerAccount(source)))
				outputChatBox("[Автосалон] #00FF00Вы продали Ваш транспорт за "..price"Руб.", pl, 38, 122, 216, true)
				outputChatBox("[Автосалон] #00FF00Вы купили автомобиль за "..price"Руб.", source, 38, 122, 216, true)
				triggerClientEvent ( pl, "cleanCarInvitations", pl )
			else
				outputChatBox ( "Машина не найдена, сделка отменена", source, 250, 10, 10 )
				outputChatBox ( "Машина не найдена, сделка отменена. Попробуйте заспавнить автомобиль.", pl, 250, 10, 10 )
				triggerClientEvent ( pl, "cleanCarInvitations", pl )
			end
		else
			outputChatBox ( "У вас не хватает денег, сделка отменена", source, 250, 10, 10 )
		end
	else
		outputChatBox ( "Игрок не найден, сделка отменена", source, 250, 10, 10)
	end
end)



function makeSellVehicle(vehicle, price)

	if not isElement(vehicle) then
		return false
	end
	if vehicle:getData("sellInfo") then
		return false
	end
	local sellInfo = {
		price = price,
	}
	for k, v in pairs(vehicle:getAllData()) do
		if k ~= 'numbers' and k ~= 'region' then
			vehicle:removeData(k)
		end
	end
	vehicle.frozen = true
	vehicle.collisionsEnabled = false
	vehicle:setData("sellInfo", sellInfo)
	setTimer(function ()
		if isElement(vehicle) then
			if vehicle:getData("sellInfo") then
				destroyElement(vehicle)
			end
		end
	end, 1 * 60 * 60 * 1000, 1)
	return true
end

addEventHandler("onVehicleEnter", root, function (player)
	local sellInfo = source:getData("sellInfo")
	if type(sellInfo) ~= "table" then
		return false
	end
	triggerClientEvent(player, "showBuyGUI", source)
end)


function updateNumbers(ply,veh,numbers,region, oldNums)
	local model = getElementModel(veh)
	dbExec(db, "UPDATE VehicleList SET numbers=?,region=? WHERE Account = ? AND Model = ? AND numbers=?",numbers,region, getAccountName(getPlayerAccount(ply)), model, oldNums)

	setTimer(function()
		updateVehicleInfo(ply)
	end,400,1)

end


function setNewNumbers(ply,model,oldNums,oldReg,current)

	local id = string.find(current,'|')
	local nums = string.sub(current,0,id)
	local reg = string.sub(current,id+1,id+3)

	local login = getAccountName(getPlayerAccount(ply))
	dbExec(db, "UPDATE VehicleList SET numbers=?,region=? WHERE Account = ? AND Model = ? AND numbers=?",nums,reg, getAccountName(getPlayerAccount(ply)), model, oldNums,oldReg)

	setTimer(function()
		updateVehicleInfo(ply)
	end,400,1)
end