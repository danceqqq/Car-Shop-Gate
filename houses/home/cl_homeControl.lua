homeControl = {}

local window_homeControl = guiCreateWindow(0.35,0.2, 0.3,0.3, 'Управление домом',true)
guiWindowSetSizable(window_homeControl,false)
guiSetVisible(window_homeControl,false)

local label_homePrice = guiCreateLabel(0,0.12,1,0.1,'Цена дома: 2000$',true,window_homeControl)
guiLabelSetHorizontalAlign(label_homePrice,'center')

local label_homeCapacity = guiCreateLabel(0,0.22,1,0.1,'Вместимость гаража: 3',true,window_homeControl)
guiLabelSetHorizontalAlign(label_homeCapacity,'center')

local _l1 = guiCreateLabel(0,0.32,1,0.1,'Вы можете продать дом за 75% от его цены',true,window_homeControl)
guiLabelSetHorizontalAlign(_l1,'center')

local button_enterHome = guiCreateButton(0, 0.48, 1, 0.11, 'Войти в дом', true,window_homeControl)
addEventHandler('onClientGUIClick',button_enterHome,function()
	if source ~= button_enterHome then return end
	guiSetVisible(window_homeControl,false)
	showCursor(false)

	--local data = homeControl.data
	triggerServerEvent('home:warpToHome',getLocalPlayer(),homeControl.marker)
	homeControl = {}
end)


local window_sellHome = guiCreateWindow(0.35,0.2, 0.3,0.17, 'Продажа дома',true)
guiWindowSetSizable(window_sellHome,false)
guiSetVisible(window_sellHome,false)

local label_sellPrice = guiCreateLabel(0,0.15,1,0.12,'Цена продажи: 2000$',true,window_sellHome)
guiLabelSetHorizontalAlign(label_sellPrice,'center')

local _l2 = guiCreateLabel(0,0.3,1,0.12,'Вы уверены что хотите продать дом?',true,window_sellHome)
guiLabelSetHorizontalAlign(_l2,'center')

local button_confrimSell = guiCreateButton(0, 0.47, 1, 0.2, 'Продать', true,window_sellHome)
addEventHandler('onClientGUIClick',button_confrimSell,function()
	if source ~= button_confrimSell then return end
	guiSetVisible(window_sellHome,false)
	showCursor(false)
	local data = homeControl.data
	local marker = homeControl.marker
	triggerServerEvent('home:sellHome',getLocalPlayer(), data,marker)
end)

local button_cancelSell = guiCreateButton(0, 0.7, 1, 0.2, 'Не продавать', true,window_sellHome)
addEventHandler('onClientGUIClick',button_cancelSell,function()
	if source ~= button_cancelSell then return end
	guiSetVisible(window_homeControl,true)
	guiSetVisible(window_sellHome,false)
end)

local button_sellHome = guiCreateButton(0, 0.60, 1, 0.11, 'Продать дом', true,window_homeControl)
addEventHandler('onClientGUIClick',button_sellHome,function()
	if source ~= button_sellHome then return end
	guiSetText(label_sellPrice, 'Цена продажи: '..(homeControl.data.price*0.75)..'$')
	guiSetVisible(window_homeControl,false)
	guiSetVisible(window_sellHome,true)
end)





local button_cancelControl = guiCreateButton(0, 0.84, 1, 0.11, 'Отмена', true,window_homeControl)
addEventHandler('onClientGUIClick',button_cancelControl,function()
	if source ~= button_cancelControl then return end
	guiSetVisible(window_homeControl,false)
	showCursor(false)
	homeControl = {}
end)




local window_sellHomeToPlayer = guiCreateWindow(0.4,0.2,0.2,0.45, 'Продать дом игроку', true)
guiWindowSetSizable(window_sellHomeToPlayer,false)
guiSetVisible(window_sellHomeToPlayer,false)

local grid_playerList = guiCreateGridList(0, 0.07, 1, 0.6, true, window_sellHomeToPlayer)
local column_playerName = guiGridListAddColumn(grid_playerList, 'Имя', 0.85)

local edit_homePrice = guiCreateEdit(0,0.7, 1, 0.08, 'Цена', true, window_sellHomeToPlayer)

local button_sendSell = guiCreateButton(0,0.8, 1,0.08, 'Отправить предложение',true,window_sellHomeToPlayer)
addEventHandler('onClientGUIClick',button_sendSell,function()
	if source ~= button_sendSell then return end

	local name = guiGridListGetItemText(grid_playerList, guiGridListGetSelectedItem(grid_playerList), 1 )
    if name == '' then return end

    local price = tonumber(guiGetText(edit_homePrice))
    if not price then
    	outputChatBox('Ошибка: Неверно введена цена',255,0,0)
    	return
    end
    
    triggerServerEvent('home:sendHomeSellInvite',localPlayer,name, homeControl.data, price)

	guiSetEnabled(window_homeControl,true)
	guiSetVisible(window_sellHomeToPlayer,false)
end)


local button_cancel = guiCreateButton(0,0.9, 1,0.08, 'Отмена',true,window_sellHomeToPlayer)
addEventHandler('onClientGUIClick',button_cancel,function()
	if source ~= button_cancel then return end

	guiSetEnabled(window_homeControl,true)
	guiSetVisible(window_sellHomeToPlayer,false)
end)

local button_sellHomeToPlayer = guiCreateButton(0, 0.72, 1, 0.11, 'Продать игроку', true,window_homeControl)
addEventHandler('onClientGUIClick',button_sellHomeToPlayer,function()
	if source ~= button_sellHomeToPlayer then return end

	guiSetEnabled(window_homeControl,false)
	guiSetVisible(window_sellHomeToPlayer,true)
	guiBringToFront(window_sellHomeToPlayer)
	guiGridListClear(grid_playerList)
	for id, player in ipairs(getElementsByType("player")) do
		local row = guiGridListAddRow(grid_playerList)
		guiGridListSetItemText(grid_playerList, row, column_playerName, getPlayerName(player), false, false )
	end
end)







function openHomeControl(data)
	homeControl.data = data
	homeControl.marker = source

	guiSetText(label_homeCapacity,'Вместимость гаража: '..data.capacity)
	guiSetText(label_homePrice,'Цена дома: '..data.price..'$')
	guiSetVisible(window_homeControl,true)
	showCursor(true)
end
addEvent('home:openHomeControl',true)
addEventHandler('home:openHomeControl',getRootElement(),openHomeControl)