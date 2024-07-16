home = {}
home.temp = {}

local window_buyHome = guiCreateWindow(0.35,0.2, 0.3,0.23, 'Покупка дома',true)
guiWindowSetSizable(window_buyHome,false)
guiSetVisible(window_buyHome,false)

local label_homePrice = guiCreateLabel(0,0.12,1,0.1,'Цена дома: 2000$',true,window_buyHome)
guiLabelSetHorizontalAlign(label_homePrice,'center')

local label_homeCapacity = guiCreateLabel(0,0.22,1,0.1,'Вместимость гаража: 3',true,window_buyHome)
guiLabelSetHorizontalAlign(label_homeCapacity,'center')

local label_home_i1 = guiCreateLabel(0,0.32,1,0.1,'Хотите приобрести этот дом?',true,window_buyHome)
guiLabelSetHorizontalAlign(label_home_i1,'center')

local button_buyHome = guiCreateButton(0, 0.48, 1, 0.2, 'Купить', true,window_buyHome)
addEventHandler('onClientGUIClick',button_buyHome,function()
	if source ~= button_buyHome then return end
	local money = getPlayerMoney()
	local data = home.temp.data
	local marker = home.temp.marker
	if money < data.price then 
		outputChatBox('Ошибка: у вас не хватает денег для покупки этого дома',255,0,0)
	else
		triggerServerEvent('home:buyHome',getLocalPlayer(),data,marker)
	end

	guiSetVisible(window_buyHome,false)
	showCursor(false)
	home.temp = {}
end)



local button_cancelHomeBuying = guiCreateButton(0, 0.7, 1, 0.2, 'Отмена', true,window_buyHome)
addEventHandler('onClientGUIClick',button_cancelHomeBuying,function()
	if source ~= button_cancelHomeBuying then return end
	guiSetVisible(window_buyHome,false)
	showCursor(false)
	home.temp = {}
end)
function startHomeBuying()
	local ply = getLocalPlayer()
	local marker = source
	local data = getElementData(marker,'data')
	home.temp.data = data
	home.temp.marker = marker
	guiSetVisible(window_buyHome,true)
	showCursor(true)

	guiSetText(label_homePrice, 'Цена дома: '..data.price..'$')
	guiSetText(label_homeCapacity, 'Вместимость гаража: '..data.capacity)
end
addEvent('home:startHomeBuying',true)
addEventHandler('home:startHomeBuying',getRootElement(),startHomeBuying)


