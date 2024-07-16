customCarNames = exports.kautov:getNamesTable()

function getCarModelByName(name)
	for model,cName in pairs(customCarNames) do
		if name == cName then
			return model
		end
	end
end

function guiGridListGetSelectedItemText(gridList,column)
    local item = guiGridListGetSelectedItem ( gridList )
    if item then
        return guiGridListGetItemText ( gridList, item, column or 1 )
    end
    return false
end

win_transfer = guiCreateWindow(0.37,0.25, 0.3,0.45, 'Обмен номерами', true)
guiSetVisible(win_transfer,false)
guiWindowSetSizable(win_transfer,false)



local grid_players = guiCreateGridList(0,0.07, 1, 0.5, true,win_transfer)
local column_playerName = guiGridListAddColumn(grid_players,'Ник',0.2)


local column_vehName = guiGridListAddColumn(grid_players,'Название авто', 0.4)
local column_vehNumber = guiGridListAddColumn(grid_players,'Номер', 0.3)


function refreshPlayerList()
	guiGridListClear(grid_players)
	local lx,ly,lz = getElementPosition(localPlayer)
	for _,ply in ipairs(getElementsByType('player')) do
		local px,py,pz = getElementPosition(ply)
		if getDistanceBetweenPoints3D(lx,ly,lz, px,py,pz) < 20 then
			local veh = getPedOccupiedVehicle(ply)
			if veh then
				local numbers = getElementData(veh,'numbers')
				local region = getElementData(veh,'region')
				local carName = customCarNames[getElementModel(veh)]
				if numbers then
					local row = guiGridListAddRow(grid_players)

					guiGridListSetItemText(grid_players, row, 1, getPlayerName(ply), false, true)
					guiGridListSetItemText(grid_players, row, 2, carName, false, true)
					guiGridListSetItemText(grid_players, row, 3, numbers..'|'..region, false, true)

					local name = getPlayerName(ply)
					guiGridListSetItemText(grid_players, row, 1, name, false, true)
				end
			end
		end
	end
end
refreshPlayerList()

----------------------------------------

--guiCreateLabel(0.1,0.6, 0.4, 0.05, 'Ваша доплата:', true,win_transfer)
--local edit_price = guiCreateEdit(0,0.65, 1, 0.07, '', true,win_transfer)

local button_sendRequest = guiCreateButton(0,0.73, 1,0.1, 'Отправить предложение', true,win_transfer)

local button_close = guiCreateButton(0,0.86, 1,0.1, 'Закрыть', true,win_transfer)
-------------------
--------------
--------------------
------------------
-----------------
---------------------
---------------------
local window_2 = guiCreateWindow(0.37,0.25, 0.3,0.33, 'Обмен номерами', true)
guiWindowSetSizable(window_2,false)
guiSetVisible(window_2,false)

local label_getNumbers = guiCreateLabel(0.03,0.15, 0.4,0.07, 'Вы получите номера: ', true,window_2)
local label_giveNumbers = guiCreateLabel(0.03,0.22, 0.4,0.07, 'Вы отдадите номера: ', true,window_2)

local label_getMoney = guiCreateLabel(0.03,0.29, 0.4,0.07, 'Вы получите денег: ', true,window_2)
local label_giveMoney = guiCreateLabel(0.03,0.36, 0.4,0.07, 'Вы отдадите денег: ', true,window_2)

local edit_surcharge = guiCreateEdit(0,0.45, 0.4,0.1, '', true,window_2)
local button_surcharge = guiCreateButton(0.43,0.45, 0.4,0.1, 'Установить доплату', true,window_2)

local label_myStatus = guiCreateLabel(0.03,0.58, 0.4,0.07, 'Ваш статус: Не готов', true,window_2)
local button_ready = guiCreateButton(0.35,0.57, 0.3,0.09, 'Я готов!', true,window_2)

local label_partnerStatus = guiCreateLabel(0.03,0.65, 0.4,0.07, 'Статус партнера: Не готов', true,window_2)


local button_confirmTransfer = guiCreateButton(0,0.74, 1,0.11, 'Совершить сделку', true,window_2)
local button_cancelTransfer = guiCreateButton(0,0.86, 1,0.11, 'Отменить сделку', true,window_2)


addEventHandler('onClientGUIClick',root,function()
	if source == button_sendRequest then

		local name = guiGridListGetSelectedItemText(grid_players,column_playerName)
		if name == '' then return end

		local ply = getPlayerFromName(name)
		if not name then
			outputChatBox('Ошибка: Игрок не найден',255,0,0)
			return
		end

		triggerServerEvent('addTransfer',localPlayer,ply)
		return
	end

	if source == button_close then
		showCursor(false)
		guiSetVisible(win_transfer,false)
		return
	end

	if source == button_surcharge then
		local value = guiGetText(edit_surcharge)
		if not tonumber(value) then
			outputChatBox('Ошибка: Некорректное значение',255,0,0)
			return
		end
		if getPlayerMoney(localPlayer) < tonumber(value) then
			outputChatBox('Ошибка: Не хватает денег на счету',255,0,0)
			return
		end
		setElementData(localPlayer,'_surcharge',tonumber(value))

		triggerServerEvent('refreshTransferInfo',localPlayer)
		return
	end
	if source == button_cancelTransfer then
		triggerServerEvent('reject',localPlayer)
		return
	end

	if source == button_ready then
		setElementData(localPlayer,'_exchangeState',1)
		triggerServerEvent('refreshTransferInfo',localPlayer)
		return
	end

	if source == button_confirmTransfer then
		local parent = getElementData(localPlayer,'_exchangeParent')
		local myStatus = getElementData(localPlayer,'_exchangeState')
		local parentStatus = getElementData(parent,'_exchangeState')

		if myStatus == 1 and parentStatus == 1 then
			triggerServerEvent('confirmTransfer',localPlayer)
			showCursor(false)
			guiSetVisible(window_2,false)
		end
	end
end)

function hideWindows()
	showCursor(false)
	guiSetVisible(window_2,false)
	guiSetVisible(win_transfer,false)
end
addEvent('hideWindows',true)
addEventHandler('hideWindows',root,hideWindows)

setElementData(localPlayer,'_exchangeParent',nil)
setElementData(localPlayer,'_exchangeState',0)

function refreshTransferInfo()
	showCursor(true)
	guiSetVisible(window_2,true)
	guiSetVisible(win_transfer,false)

	local parent = getElementData(localPlayer,'_exchangeParent')
	local veh = getPedOccupiedVehicle(parent)
	local numbers = getElementData(veh,'numbers')
	local region = getElementData(veh,'region')
	local surcharge = getElementData(parent,'_surcharge')
	local status = (getElementData(parent,'_exchangeState') or 0)

	local veh2 = getPedOccupiedVehicle(localPlayer)
	local myNumbers = getElementData(veh2,'numbers')
	local myRegion = getElementData(veh2,'region')
	local mySurcharge = getElementData(localPlayer,'_surcharge') 
	local myStatus = (getElementData(localPlayer,'_exchangeState') or 0)


	guiSetText(label_getNumbers,'Вы получите номера: '..numbers..'|'..region)
	guiSetText(label_giveNumbers,'Вы получите номера: '..myNumbers..'|'..myRegion)

	guiSetText(label_getMoney,'Вы получите денег: '..(surcharge or '0')..'$')
	guiSetText(label_giveMoney,'Вы отдадите денег: '..(mySurcharge or '0')..'$')

	if myStatus == 0 then
		guiSetText(label_myStatus,'Ваш статус: Не готов')
	else
		guiSetText(label_myStatus,'Ваш статус: Готов')
	end

	if state == 0 then
		guiSetText(label_partnerStatus,'Статус партнёра: Не готов')
	else
		guiSetText(label_partnerStatus,'Статус партнёра: Готов')
	end
end
addEvent('refreshTransferInfo',true)
addEventHandler('refreshTransferInfo',root,refreshTransferInfo)

function buildMarkers()
	for _,pos in pairs(markers) do
		local marker = createMarker(pos[1],pos[2],pos[3]-1, 'cylinder', 3, 255,150,0,150)
		addEventHandler('onClientMarkerHit',marker,function(ply,_)
			if ply ~= localPlayer then return end
			local veh = getPedOccupiedVehicle(ply)
			if not isElement(veh) then return end
			if getPedOccupiedVehicleSeat(ply) ~= 0 then return end
			if getElementData(veh,'Owner') ~= ply then return end
			showCursor(true)
			guiSetVisible(win_transfer,true)
			refreshPlayerList()
		end)
	end
end