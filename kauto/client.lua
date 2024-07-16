local tp = {
["1"] = "1365.8,-2319.7,13.5,0,0,270",
["2"] = "1366,-2316.3994,13.5,0,0,270",
["3"] = "1365.6,-2323.3999,13.5,0,0,270",
["4"] = "1365.3,-2334,13.5,0,0,270",
["5"] = "1365.4004,-2326.8994,13  0,0,270",
["6"] = "1365.2998,-2330.3994,13.5,0,0,270",
["7"] = "1365.3,-2341,13.5,0,0,270",
["8"] = "1365.4004,-2337.5,13.5,0,0,270",
["9"] = "1365.3,-2348,13.5,0,0,270",
["10"] = "1365.4004,-2344.5996,13.5,0,0,270",
["11"] = "1365.3,-2351.7,13.5,0,0,270",
["12"] = "1365.3,-2362.1001,13.5,0,0,270",
["13"] = "1365.4004,-2355.2002,13.5,0,0,270",
["14"] = "1365.2002,-2358.7002,13.5,0,0,270",
["15"] = "1365.2,-2365.6001,13.5,0,0,270",
["16"] = "1398.2,-2348.5,13.5,0,0,180",
["17"] = "1385.0996,-2348.2998,13.5,0,0,180",
["18"] = "1384.8,-2364.3999,13.5,0,0,180",
["19"] = "1388.4004,-2348.3994,13.5,0,0,180",
["20"] = "1391.5996,-2348.5996,13.5,0,0,180",
["21"] = "1394.7998,-2348.2998,13.5,0,0,180",
["22"] = "1394.7998,-2348.2998,13.5,0,0,180",
["23"] = "1401.4,-2348.5,13.5,0,0,180",
["24"] = "1404.8,-2348.7,13.5,0,0,180",
["25"] = "1411.3,-2348.5,13.5,0,0,180",
["26"] = "1408,-2348.5996,13.5,0,0,180",
["27"] = "1411.3,-2332,13.5,0,0,180",
["28"] = "1408.2,-2332,13.5,0,0,180",
["29"] = "1388.2,-2331.5,13.5,0,0,180",
["30"] = "1404.7002,-2332,13.5,0,0,180",
["31"] = "1401.5,-2331.8994,13.5,0,0,180",
["32"] = "1398.2998,-2331.8994,13.5,0,0,180",
["33"] = "1395.0996,-2331.5996,13.5,0,0,180",
["34"] = "1391.5996,-2331.5996,13.5,0,0,180",
["35"] = "1385.1,-2314.7,13.5,0,0,180",
["36"] = "1385.2002,-2331.5,13.5,0,0,180",
["37"] = "1395,-2314.5,13.5,0,0,180",
["38"] = "1388.2002,-2314.5996,13.5,0,0,180",
["39"] = "1391.5,-2314.5996,13.5,0,0,180",
["40"] = "1411.1,-2314.8999,13.5,0,0,180",
["41"] = "1398.4004,-2314.5996,13.5,0,0,180",
["42"] = "1401.5,-2314.7998,13.5,0,0,180",
["43"] = "1404.7002,-2314.8994,13.5,0,0,180",
["44"] = "1408.0996,-2315,13.5,0,0,180",
["45"] = "1441.4,-2347.1001,13.5,0,0,180",
["46"] = "1438.2998,-2347.2002,13.5,0,0,180",
["47"] = "1444.8,-2346.8999,13.5,0,0,180",
["48"] = "1447.6,-2346.8999,13.5,0,0,180",
["49"] = "1451.2,-2346.8999,13.5,0,0,180",
["50"] = "1457.9,-2346.7,13.5,0,0,180",
["51"] = "1454.5,-2346.7002,13.5,0,0,180",
["52"] = "1385.0996,-2348.2998,13.5,0,0,180",
["53"] = "1388.2,-2364.5,13.5,0,0,180",
["54"] = "1391.6,-2364.3,13.5,0,0,180",
["55"] = "1398,-2364.3999,13.5,0,0,180",
["56"] = "1394.7002,-2364.2002,13.5,0,0,180",
["57"] = "1401.3,-2364.3,13.5,0,0,180",
["58"] = "1404.6,-2364.3,13.5,0,0,180",
["59"] = "1411.1,-2364.3999,13.5,0,0,180",
["60"] = "1408,-2364.2002,13.5,0,0,180"
}
symbols = {
	['A'] ='а',
	['B'] = 'в',
	['C'] = 'с',
	['Y'] = 'у',
	['O'] = 'о',
	['P'] = 'р',
	['T'] = 'т',
	['E'] = 'е',
	['X'] = 'х',
	['M'] = 'м',
	['H'] = 'н',
	['K'] = 'к'
}

function centerWindow ( center_window )
	local sx, sy = guiGetScreenSize ( )
	local windowW, windowH = guiGetSize ( center_window, false )
	local x, y = ( sx - windowW ) / 2, ( sy - windowH ) / 2
	guiSetPosition ( center_window, x, y, false )
end
local sellcarColShape = createColSphere(1713.491, -1064.974, 23.906, 40)

customCarNames = -- новые названия
{
	[400] = "Mercedes-Benz GL63",
	[404] = "ВАЗ 2106",
	[405] = "Subaru Impreza WRX STi 09",
	[409] = "BMW M5 E39",
	[418] = "Mercedes-Benz S63 W222",
	[420] = "Mercedes-Benz C63 W205",
	[421] = "ВАЗ 21099",
	[426] = "Volvo 850R Taxi",
	[438] = "BMW 730i E38",
	[445] = "BMW M5 F10",
	[466] = "Mazda 6 MPS",
	[467] = "Toyota Camry",
	[470] = "Mercedes-Benz G65 AMG",
	[479] = "BMW M5 E28",
	[490] = "Range Rover Supercharged",
	[492] = "Audi A6",
	[507] = "BMW 525i E34",
	[516] = "Mercedes-Benz S65 W221",
	[529] = "Toyota Chaser JZX100",
	[540] = "Mercedes-Benz E500 W124",
	[546] = "Renault Megane",
	[547] = "ВАЗ 2170 Приора",
	[550] = "BMW M5 E60",
	[551] = "Ford Focus III RS",
	[560] = "Mitsubishi Lancer Evo VI",
	[561] = "Mitsubishi Lancer Evo X",
	[566] = "Toyota Mark II JZX100",
	[567] = "Mazda 626",
	[579] = "Chevrolet Suburban",
	[580] = "BMW X5M",
	[585] = "Лада Vesta",
	[596] = "Chevrolet Volt",
	[597] = "Mercedes-Benz E63 W212 AMG Police",
	[598] = "Mercedes-Benz E63 AMG",
	[401] = "УАЗ 469",
	[411] = "Lexus LFA",
	[410] = "ВАЗ 2107",
	[415] = "Lamborghini Gallardo",
	[419] = "ВАЗ 2108",
	[429] = "Volkswagen Golf IV",
	[439] = "Ford Mustang Fastback 289",
	[451] = "Bentley Continental",
	[457] = "ВАЗ 1111 Ока",
	[477] = "Audi RS5",
	[480] = "Porsche 911 Carrera S",
	[489] = "Ford F-150 SVT Raptor",
	[494] = "Nissan GT-R",
	[495] = "Porsche Cayenne Turbo S",
	[496] = "Volkswagen Golf I Cabrio",
	[500] = "Shelby GT500",
	[506] = "McLaren P1",
	[517] = "Porsche Boxster GTS",
	[518] = "ВАЗ 2113",
	[526] = "Mercedes-Benz W126 Coupe",
	[533] = "Honda S2000",
	[535] = "Volvo S63R",
	[541] = "RUF RT35",
	[542] = "Subaru Forester XT",
	[543] = "Nissan Silvia S15",
	[554] = "Audi Q7",
	[558] = "Nissan Skyline R34 GT-R",
	[559] = "Toyota GT86",
	[562] = "Nissan 240SX",
	[565] = "Subaru Impreza 22B",
	[587] = "Konsing Agera",
	[589] = "Mercedes-Benz CLS500 W219",
	[599] = "Toyota Land Cruiser 200",
	[602] = "Chevrolet Corvette",
	[603] = "Ferrari 250 GT Lusso",
	[403] = "Камаз 53215",
	[414] = "Mitsubishi Canter",
	[416] = "Rolls Royce Ghost EWB",
	[431] = "Volvo Keolis",
	[437] = "Mercedes-Benz O345",
	[508] = "Audi RS7",
	[515] = "Iveco Stralis",
	[525] = "Ford F-100 Эвакуатор",
	[582] = "Mercedes-Benz Sprinter",
}

function getNamesTable()
	return customCarNames
end



setTimer ( function ()

local theCol = getElementData(root, "BlockExportCol")
	
function isInColExport ()
	if isElement(theCol) and isElementWithinColShape(localPlayer,theCol) then
		return true else return false
	end
end
 
function ClientExplosionCFunction()
 if isInColExport ()  then
  cancelEvent ()
 end
end
addEventHandler("onClientExplosion", root, ClientExplosionCFunction)

end , 1000, 1 )

local screX, screY = guiGetScreenSize()
 
Window_VS = guiCreateWindow(373, 219, 557, 303,"Управление транспортом",false)
guiSetAlpha(Window_VS, 0.88)
guiWindowSetSizable(Window_VS, false)
guiSetVisible(Window_VS, false)
centerWindow(Window_VS)
Grid_VS = guiCreateGridList(10, 28, 361, 235, false, Window_VS)
guiGridListSetSelectionMode(Grid_VS, 2)
guiGridListAddColumn(Grid_VS,"Транспорт",0.5)
guiGridListAddColumn(Grid_VS,"Цена (Руб)",0.17)
guiGridListAddColumn(Grid_VS,"Номера",0.25)
guiSetAlpha(Window_VS, 0.88)


Button_VS_sn = guiCreateButton(381, 28, 166, 25, "Респавн", false, Window_VS)
Button_VS_dy = guiCreateButton(381, 63, 166, 25, "Убрать", false, Window_VS)
Button_VS_Warp = guiCreateButton(381, 98, 166, 25, "Телепорт", false, Window_VS)
Button_VS_bp = guiCreateButton(381, 133, 166, 25, "Метка", false, Window_VS)
Button_VS_lk = guiCreateButton(381, 168, 166, 25, "Откр/Закр", false, Window_VS)
Button_VS_sl = guiCreateButton(381, 203, 166, 25, "В б/у салон", false, Window_VS)
Button_VS_give = guiCreateButton(381, 238, 166, 25, "Игроку", false, Window_VS)


Window_CHK = guiCreateWindow(screX/2-155,screY/2-60,310,120,"Внимание!",false)
guiSetVisible(Window_CHK, false)
guiSetProperty(Window_CHK, "AlwaysOnTop", "true")
guiWindowSetSizable(Window_CHK, false)
Label_CHK = guiCreateLabel(21,28,266,36,"",false,Window_CHK)
guiLabelSetColor(Label_CHK, 38, 122, 216)
guiLabelSetHorizontalAlign(Label_CHK,"center",true)
Button_CHK_Y = guiCreateButton(17,73,129,36,"Да",false,Window_CHK)
Button_CHK_N = guiCreateButton(161,73,129,36,"Нет",false,Window_CHK)

function updateGridList()
	local data = getElementData(localPlayer, "VehicleInfo")
	if data then
		local rw, cl = guiGridListGetSelectedItem(Grid_VS)
		guiGridListClear(Grid_VS)
		for i, data in ipairs (data) do
			local carName = customCarNames[ tonumber(data['Model']) ] or getVehicleNameFromModel(data["Model"])
			local ID = data["ID"]
			local numbers = data['numbers']
			local reg = data['region']
			

			local s1 = symbols[string.sub(numbers,1,1)]
			local s2 = symbols[string.sub(numbers,5,5)]
			local s3 = symbols[string.sub(numbers,6,6)]
			local nums = string.sub(numbers,2,4)

			local nums_2 = '|'..s1..nums..s2..s3..'|'..tostring(reg)..'|'
			local Cost = data["Cost"]
			local HP = math.floor(data["HP"])
			local PreCost = math.ceil(Cost*.9*HP/100/10)
			local row = guiGridListAddRow(Grid_VS)
			guiGridListSetItemText(Grid_VS, row, 1, carName, false, true)
			guiGridListSetItemData(Grid_VS, row, 1, ID)
			guiGridListSetItemText(Grid_VS, row, 3, nums_2, false, true)
			guiGridListSetItemText(Grid_VS, row, 2, PreCost, false, true)
			--guiGridListSetItemText(Grid_VS, row, 3, HP.." HP", false, true)
		end
		guiGridListSetSelectedItem(Grid_VS, rw, cl)
	end
end



bindKey("F3", "down",
function()
if getElementInterior(localPlayer) == 0 and getElementDimension(localPlayer) == 0 then
if getElementData(localPlayer, "MissionWarProtection") and getElementData(localPlayer, "MissionProtection")then return end
    guiSetVisible(Window_VS, not guiGetVisible(Window_VS))
	guiSetVisible (Window_CHK, false)
	showCursor(guiGetVisible(Window_VS))
	end
end)

triggerServerEvent("onOpenGui", localPlayer)

addEventHandler("onClientElementDataChange", root,
function(dd)
	if getElementType(source) == "player" and source == localPlayer and dd == "VehicleInfo" then
		local data = getElementData(source, dd)
		if data then
			updateGridList()
		end
	end
end)

function WINDOW_CLICK_VEHICLE (button, state, absoluteX, absoluteY)
	local id = guiGridListGetSelectedItem(Grid_VS)
	local ID = guiGridListGetItemData(Grid_VS, id, 1)
	if source == Button_VS_close then
		guiSetVisible(Window_VS, false)
		showCursor(false)
	end
	if (source == Grid_VS) then
		if id == -1 and idd then
			guiGridListSetSelectedItem(Grid_VS, idd, 1)
			return false
		else
			idd = guiGridListGetSelectedItem(Grid_VS)
		end
	elseif id == -1 then
	elseif (source == Button_VS_sn) then
	if not isInColExport () then
		triggerServerEvent("SpawnMyVehicle", localPlayer, ID)
                end
	elseif (source == Button_VS_dy) then 
		triggerServerEvent("DestroyMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_lt) then 
		triggerServerEvent("LightsMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_bp) then 
		triggerServerEvent("BlipMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_lk) then 
		triggerServerEvent("LockMyVehicle", localPlayer, ID)
	elseif (source == Button_VS_sl) then 
		if localPlayer.vehicle and localPlayer.vehicle:getData("ID") == ID then
			if isElementWithinColShape(localPlayer.vehicle, sellcarColShape) then
				guiSetVisible(Window_CHK, true)
				local carName = guiGridListGetItemText(Grid_VS, guiGridListGetSelectedItem(Grid_VS), 1)
				local carprice = guiGridListGetItemText(Grid_VS, guiGridListGetSelectedItem(Grid_VS), 2)
				guiSetText(Label_CHK, 'Вы серьёзно хотите продать "'..carName..'" за (Руб.): '..carprice)
			else
	outputChatBox("[Автосалон]Невозможно продать автомобиль.Вы и ваш автомобиль должны находится на б/у рынке.", 255, 0, 0)
			end
		end
	elseif source == Button_VS_give then
		createPlayersList(id)
	elseif source == Button_CHK_Y then
		triggerServerEvent("SellMyVehicle", localPlayer, ID)
		guiSetVisible(Window_VS, false)
		guiSetVisible(Window_CHK, false)
		showCursor(false)
	elseif source == Button_CHK_N then
		guiSetVisible (Window_CHK, false)
	elseif source == Button_VS_Spc then
      if getElementInterior(localPlayer) == 0 then
if getElementData(localPlayer,"Stats") < 2 then
		SpecVehicle(ID)
end
end
	elseif source == Button_VS_Fix then
		triggerServerEvent("FixMyVehicle", localPlayer, ID)
	elseif source == Button_VS_Warp then
	       if not isInColExport () then
		triggerServerEvent("WarpMyVehicle", localPlayer, ID)
                      end
	elseif source == Button_PLS_Y then
		local row = guiGridListGetSelectedItem ( playerList_PLS )
		if row and row ~= -1 then
			-- if guiGridListGetItemText ( playerList_PLS, row, 1 ) == getPlayerName ( localPlayer ) then
				-- return true
			-- end
			if (tonumber(guiGetText (edit_PLS_price)) or 0) >= 0 then
				outputChatBox ( "Ожидайте ответа игрока", 10, 250, 10 )
				invitations_send = true
				triggerServerEvent ( 'inviteToBuyCarSended', localPlayer, guiGridListGetItemText ( playerList_PLS, row, 1 ), guiGetText (edit_PLS_price) or 0, guiGridListGetItemText(Grid_VS, id, 1), guiGridListGetItemData(Grid_VS, id, 1) )
				destroyElement ( Window_PLS )
			end
		end
	elseif source == Button_PLS_N then
		destroyElement ( Window_PLS)
	end
end
addEventHandler("onClientGUIClick", resourceRoot, WINDOW_CLICK_VEHICLE)

function invitationsClickVehicle ()
	if source == Button_ABC_Y then
		showCursor ( false )
		destroyElement ( Window_ABC )
		if getPlayerMoney () >= ( tonumber(inv_price) or 0 ) then
			triggerServerEvent ("invitationBuyCarAccepted",localPlayer, inv_player, inv_acc, inv_price, inv_veh_name, inv_veh_id)
		else
			outputChatBox ( "У вас не хватает денег, сделка отменена", 250, 10, 10 )
			triggerServerEvent ("invitationBuyCarNotAccepted",localPlayer, inv_player )
		end
		if #listOfInvitations > 0 then
			createAcceptBuyCarWindow (listOfInvitations[1][1],listOfInvitations[1][2],listOfInvitations[1][3],listOfInvitations[1][4] )
			table.remove (listOfInvitations,1)
		end
	elseif source == Button_ABC_N then
		showCursor ( false )
		triggerServerEvent ("invitationBuyCarNotAccepted",localPlayer, inv_player )
		destroyElement ( Window_ABC )
		if #listOfInvitations > 0 then
			createAcceptBuyCarWindow (listOfInvitations[1][1],listOfInvitations[1][2],listOfInvitations[1][3],listOfInvitations[1][4] )
			table.remove (listOfInvitations,1)
		end
	end
end

addEventHandler("onClientGUIClick", resourceRoot, invitationsClickVehicle)

function createPlayersList (row_id)
	showCursor ( true )
	Window_PLS = guiCreateWindow(screX/2-155,screY/2-220,310,420,"Выбор покупателя",false)
	guiSetVisible(Window_PLS, true)
	guiSetProperty(Window_PLS, "AlwaysOnTop", "true")
	guiWindowSetSizable(Window_PLS, false)
	Label_PLS_info = guiCreateLabel(21,28,266,36,"Выберите покупателя и введите цену:",false,Window_PLS)
	edit_PLS_price = guiCreateEdit ( 110,58,90,36, guiGridListGetItemText(Grid_VS, row_id, 2) or 0, false, Window_PLS )
	guiLabelSetColor(Label_PLS_info, 38, 122, 216)
	guiLabelSetHorizontalAlign(Label_PLS_info,"center",true)
	Button_PLS_Y = guiCreateButton(17,379,129,36,"Выбор",false,Window_PLS)
	Button_PLS_N = guiCreateButton(161,379,129,36,"Отмена",false,Window_PLS)
	addEventHandler("onClientGUIChanged", edit_PLS_price, function(element) 
		guiSetText ( edit_PLS_price, string.gsub (guiGetText( edit_PLS_price ), "%a", "") )
	end)
	playerList_PLS = guiCreateGridList ( 21, 100, 268, 265, false, Window_PLS )
	local column = guiGridListAddColumn( playerList_PLS, "Игроки", 0.85 )
	if ( column ) then
		for id, player in ipairs(getElementsByType("player")) do
			local row = guiGridListAddRow ( playerList_PLS )
			guiGridListSetItemText ( playerList_PLS, row, column, getPlayerName ( player ), false, false )
		end
	end

end

--createPlayersList ()

listOfInvitations = {}
inv_player, inv_acc, inv_price, inv_veh_name, inv_veh_id = nil, nil, nil, nil, nil


addEvent("recieveInviteToBuyCar", true)
addEventHandler("recieveInviteToBuyCar", root, 
function(player, acc, price, veh_name, veh_id)
	if player and price and acc and veh_name and veh_id then
		if getPlayerFromName ( player ) then
			if not isElement ( Window_ABC ) then
				createAcceptBuyCarWindow (player,acc,price, veh_name, veh_id)
			else	
				table.insert ( listOfInvitations, {player,acc,price, veh_name, veh_id})
			end
		else
			outputChatBox ( "Игрок не найден, продажа отменена", source, 250, 10, 10)
		end
	end
end)

addEvent("cleanCarInvitations", true)
addEventHandler("cleanCarInvitations", root, 
function()
	invitations_send = false
end)

function createAcceptBuyCarWindow(player,acc,price, veh_name, veh_id)
	showCursor ( true )
	inv_player, inv_acc, inv_price, inv_veh_name, inv_veh_id = player,acc,price, veh_name, veh_id
	Window_ABC = guiCreateWindow(screX/2-155,screY/2-220,410,100,"Вам предложили купить машину",false)
	guiSetVisible(Window_ABC, true)
	guiSetProperty(Window_ABC, "AlwaysOnTop", "true")
	guiWindowSetSizable(Window_ABC, false)
	Label_ABC_info = guiCreateLabel(10,28,390,36,player.." предложил вам купить его автомобиль "..veh_name.." за "..price.." руб",false,Window_ABC)
	guiLabelSetColor(Label_ABC_info, 38, 216, 38)
	guiLabelSetHorizontalAlign(Label_ABC_info,"center",true)
	Button_ABC_Y = guiCreateButton(17,70,129,36,"Купить",false,Window_ABC)
	Button_ABC_N = guiCreateButton(264,70,129,36,"Не покупать",false,Window_ABC)
end

function SpecVehicle(id)

	if spc then 
		removeEventHandler("onClientPreRender", root, Sp)
		setCameraTarget(localPlayer)
		if isTimer(freezTimer) then killTimer(freezTimer) end
		freezTimer = setTimer(function() setElementFrozen(localPlayer, false) end, 2500, 1)
		spc = false
	return end
	for i, vehicle in ipairs(getElementsByType("vehicle")) do
		if getElementData(vehicle, "Owner") == localPlayer and getElementData(vehicle, "ID") == id then
			cVeh = vehicle
			spc = true
			addEventHandler("onClientPreRender", root, Sp)
			guiSetVisible(Window_VS, false)
			showCursor(false)
			break
		  end
                        
	end
end

function Sp()
	if isElement(cVeh) then
		local x, y, z = getElementPosition(cVeh)
		setElementFrozen(localPlayer, true)
		setCameraMatrix(x, y-1, z+15, x, y, z)

	else
		removeEventHandler("onClientPreRender", root, Sp)
		setCameraTarget(localPlayer)
		if isTimer(freezTimer) then killTimer(freezTimer) end
		freezTimer = setTimer(function() setElementFrozen(localPlayer, false) end, 2500, 1)
		spc = false
      end
end
 
 
ShopMarkersTable = {}	

local ShopTable = {
	[1] = {ID = {{506, 90000000}
                ,{587, 95000000}
                ,{507, 5500}
		,{409, 10000}
		,{535, 80000}
		,{479, 40000}
		,{580, 64000}
		,{554, 90000}
		,{560, 35000}
                ,{562, 98000}
                ,{575, 30000}
                ,{576, 70000}
                ,{580, 94500}
                ,{597, 15000}
                ,{598, 73500}
                ,{585, 64000}
		}, vPosX = 2134, vPosY = -1170, vPosZ = 35.15, PosX = 2133, PosY = -1149, PosZ = 23.4, CamX = 2134.1, CamY = -1160, CamZ = 35, lookAtX = 2133.3, lookAtY = -1168, lookAtZ = 28},
	[2] = {ID = {{457, 25000}
                    ,{404, 65000}
                    ,{419, 79000}
                    ,{410, 75000}
                    ,{518, 125000}
                    ,{547, 320000}
					,{585, 650000}
       	      }, vPosX = 552, vPosY = -1288, vPosZ = 30, PosX = 1489, PosY = -1722, PosZ = 13, CamX = 1500, CamY = -1722.40, CamZ = 25.54, lookAtX = 1489, lookAtY = -1722.40, lookAtZ = 30.54},
	[3] = {ID = {{599, 4700000}
        ,{529, 450000}
        ,{566, 450000}
        ,{467, 950000}
        ,{411, 15000000}
        ,{477, 4000000}
        ,{554, 3000000}
        ,{602, 6300000}
        ,{596, 970000}
		,{489, 3000000}
        ,{439, 3700000}

		}, vPosX = 1942.5, vPosY = 2052, vPosZ = 11, PosX = 1946, PosY = 2068, PosZ = 10, CamX = 1930.36, CamY = 2052.78, CamZ = 14.71, lookAtX = 1931.36, lookAtY = 2052.78, lookAtZ = 14.43},
	[4] = {ID = {{540, 700000}
    ,{420, 2900000}
	,{400, 5900000}
	,{470, 15000000}
    ,{598, 6500000}
	,{411, 15000000}
    ,{526, 12000000}	
    ,{516, 10000000}	
    ,{507, 320000}	
    ,{438, 650000}	
    ,{409, 950000}	
    ,{550, 7500000}	
    ,{401, 2500000}
	,{445, 7000000}
    ,{580, 8000000}		

		}, vPosX = -1950, vPosY = 266, vPosZ = 36.2, PosX = -1954, PosY = 299, PosZ = 34, CamX = -1960.18, CamY = 266.06, CamZ = 37.94, lookAtX = -1959.2, lookAtY = 266.06, lookAtZ = 37.73},
	[5] = {ID = {{405, 870000}
        ,{542, 750000}
        ,{565, 500000}
        ,{567, 200000} 		
        ,{543, 350000}  
        ,{558, 980000} 
        ,{496, 7500000} 
        ,{533, 750000} 

		}, vPosX = -1660, vPosY = 1213, vPosZ = 7, PosX = -1634, PosY = 1199, PosZ = 6, CamX = -1648.9, CamY = 1212.27, CamZ = 10.16, lookAtX = -1649.88, lookAtY = 1212.27, lookAtZ = 9.94}
}

VehicleShop_Window = guiCreateWindow(screX-350,screY-450, 343, 436, "Автосалон San Andreas", false)
guiSetVisible(VehicleShop_Window, false)
guiWindowSetSizable(VehicleShop_Window , false)
guiSetAlpha(VehicleShop_Window, 0.8)
carGrid = guiCreateGridList(9, 20, 324, 329, false, VehicleShop_Window)
guiGridListSetSelectionMode(carGrid, 0)
carColumn = guiGridListAddColumn(carGrid, "Транспорт", 0.5)
costColumn = guiGridListAddColumn(carGrid, "Стоимость", 0.4)
carButton = guiCreateButton(14, 355, 86, 56,"Купить", false, VehicleShop_Window)
closeButton = guiCreateButton(237, 355, 86, 56, "Закрыть", false, VehicleShop_Window)
carColorButton = guiCreateButton(128, 355, 86, 56,"Выбрать цвет", false, VehicleShop_Window)
guiSetProperty(carButton, "NormalTextColour", "FF069AF8")
guiSetProperty(closeButton, "NormalTextColour", "FF069AF8")
guiSetProperty(carColorButton, "NormalTextColour", "FF069AF8")  





for i, M in ipairs(ShopTable) do
	ShopMarker = createMarker(M["PosX"], M["PosY"], M["PosZ"], "cylinder", 2, 38, 122, 216)
	ShopMarkerShader = createMarker(M["PosX"], M["PosY"], M["PosZ"], "cylinder", 2, 38, 122, 216)
	ShopMarkersTable[ShopMarker] = true
	setElementData ( ShopMarker, "shopID", i )
	setElementID(ShopMarker, tostring(i))
	createBlip(2134,-1170,28.15, 55, 0, 0, 0, 0, 0, 0, 400) -- Иконка автосалона Toyota 
	createBlip(1942.5,2052,11, 55, 0, 0, 0, 0, 0, 0, 400) -- Иконка автосалона BMW 
	createBlip(-1627,1195,7.2,55, 0, 0, 0, 0, 0, 0, 400) -- Иконка автосалона Mercedes-Benz 
	createBlip(-1950,266,36.2,55, 0, 0, 0, 0, 0, 0, 400) -- Иконка автосалона Mercedes-Benz 
	
	

	
end 

function getVehicleModelFromNewName (name)
	for i,v in pairs ( customCarNames ) do
		if v == name then
			return i
		end
	end
	return false
end
winOpened = false

local _sx,_sy = guiGetScreenSize()
function draw()
	if winOpened ~= true then return end
	local limit = (getElementData(localPlayer, '_carLimit') or 1)
	dxDrawText('Мест в гараже: '..limit, _sx*0.43,_sy*0.03, _sx,_sy, tocolor(255,140,0), 1.5)
end
addEventHandler('onClientRender',root,draw)

addEventHandler("onClientGUIClick", resourceRoot,
function()
	if (source == carGrid) then
		local carName = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 1)
		local carprice = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 2)
		if guiGridListGetSelectedItem(carGrid) ~= -1 then
			if isElement(CarName) then
				guiSetText(CarName, carName)
			end
			if isElement(CarPrice) then
				guiSetText(CarPrice,"(Рубли)" ..carprice)
			end
			local carID = getVehicleModelFromNewName(carName) or getVehicleModelFromName(carName)
			if isElement(veh) then
				setElementModel(veh, carID)
			return end
			veh = createVehicle(carID, ShopTable[i]["vPosX"], ShopTable[i]["vPosY"], ShopTable[i]["vPosZ"])
			setVehicleDamageProof(veh, true)
			setElementFrozen(veh, true)
			setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
			timer = setTimer(function() local x, y, z = getElementRotation(veh) setElementRotation(veh, x, y, z+3) end, 50, 0)
			
		else
			guiSetText(CarName, "Noun")
			guiSetText(CarPrice, "Noun")
			r1, g1, b1, r2, g2, b2 = math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
		elseif (source == carColorButton) then
		openColorPicker()
	elseif (source == carButton) then
		if guiGridListGetSelectedItem(carGrid) then
			local carName = guiGridListGetItemText(carGrid, guiGridListGetSelectedItem(carGrid), 1)
			local carID = getVehicleModelFromNewName(carName) or getVehicleModelFromName(carName)
			local carCost = guiGridListGetItemText (carGrid, guiGridListGetSelectedItem(carGrid), 2)
			local r1, g1, b1, r2, g2, b2 = getVehicleColor(veh, true)
			winOpened = false
			triggerServerEvent("onBuyNewVehicle", localPlayer, carID, carCost, r1, g1, b1, r2, g2, b2)
			outputChatBox("[Автосалон] #FFFF00Вы купили: #00FFFF"..carName, 38, 122, 216, true)
			guiSetVisible(VehicleShop_Window, false)
			showCursor(false)
			setElementFrozen(localPlayer, false)
			fadeCamera(false, 1.0)
			setTimer(function() fadeCamera(true, 0.5) setCameraTarget(localPlayer) end, 1000, 1)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	elseif (source == closeButton) then
		if guiGetVisible(VehicleShop_Window) then 
			winOpened = false
			guiSetVisible(VehicleShop_Window, false)
			showCursor(false)
			setElementFrozen(localPlayer, false)
			fadeCamera(false, 1.0)
			setElementData ( localPlayer, "atVehShop", false)
			setTimer(function() fadeCamera(true, 0.5) setCameraTarget(localPlayer) end, 1000, 1)
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
		end
	end
end)

function openColorPicker()
	if (colorPicker.isSelectOpen) or not isElement(veh) then return end
	colorPicker.openSelect(colors)
end

function closedColorPicker()
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (veh and isElement(veh)) then
		r1, g1, b1, r2, g2, b2 = getVehicleColor(veh, true)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
	end
end
addEventHandler("onClientRender", root, updateColor)

--[[addCommandHandler("xx", function()
	local x, y, z, lx, ly, lz = getCameraMatrix()
	setCameraMatrix(x, y, z, lx, ly, lz)
	outputChatBox(x..", "..y..", "..z..", "..lx..", "..ly..", "..z)
end)]]

addEventHandler("onClientMarkerHit", resourceRoot,
function(player)
	if getElementType(player) ~= "player" or player ~= localPlayer or isPedInVehicle(player) then return end
	if ShopMarkersTable[source] then
		winOpened = true
		i = tonumber(getElementID(source))
		guiGridListClear(carGrid)
		for i, v in ipairs(ShopTable[i]["ID"]) do
			local carName = customCarNames[ v[1] ] or getVehicleNameFromModel(v[1])
			local row = guiGridListAddRow(carGrid)
			guiGridListSetItemText(carGrid, row, 1, carName, false, true)
			guiGridListSetItemText(carGrid, row, 2, tostring(v[2]), false, true)
		end
		setCameraMatrix(ShopTable[i]["CamX"], ShopTable[i]["CamY"], ShopTable[i]["CamZ"], ShopTable[i]["lookAtX"], ShopTable[i]["lookAtY"], ShopTable[i]["lookAtZ"])
		guiSetVisible(VehicleShop_Window, true)
		showCursor(true)
		setElementData ( player, "atVehShop", getElementData ( source, "shopID"))
		guiGridListSetSelectedItem(carGrid, 0, 1)
		setTimer(function()
			setElementFrozen(localPlayer, true)
			local carName = guiGridListGetItemText(carGrid, 0, 1)
			local carID = getVehicleModelFromNewName(carName) or getVehicleModelFromName(carName)
			local x, y, z = ShopTable[i]["vPosX"], ShopTable[i]["vPosY"], ShopTable[i]["vPosZ"]
			if isElement(veh) then
				destroyElement(veh)
			end
			if isTimer(timer) then
				killTimer(timer)
			end
			r1, g1, b1, r2, g2, b2 = math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255), math.random(0, 255)
			veh = createVehicle(carID, x, y, z)
			setVehicleDamageProof(veh, true)
			setElementFrozen(veh, true)
			setVehicleColor(veh, r1, g1, b1, r2, g2, b2)
			timer = setTimer(function() local x, y, z = getElementRotation(veh) setElementRotation(veh, x, y, z+3) end, 50, 0)
		end, 100, 1)
	end
end)

addEventHandler("onClientRender", getRootElement(), function()
	for index, car in pairs(getElementsByType('vehicle')) do
        if car:getData("sellInfo") then
			local sellInfo = car:getData("sellInfo")
			local x, y, z = getElementPosition(car)
			local x2, y2, z2 = getElementPosition(localPlayer)				
			z = z+1
			local sx, sy = getScreenFromWorldPosition(x, y, z)
			if(sx) and (sy) then
				local distance = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
				if(distance < 20) then
					local fontbig = 2-(distance/10)
					dxDrawBorderedCarText("Цена: "..tostring(sellInfo.price).." руб", sx, sy, sx, sy, tocolor(255, 255, 255, 200,true), fontbig, "default-bold", "center")	
				end
			end
		end
	end
end)

function dxDrawBorderedCarText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
	dxDrawText ( text, x - 1, y - 1, w - 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y - 1, w + 1, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y + 1, w - 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y + 1, w + 1, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x - 1, y, w - 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x + 1, y, w + 1, h, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y - 1, w, h - 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y + 1, w, h + 1, tocolor ( 0, 0, 0, 255 ), scale, font, alignX, alignY, clip, wordBreak, false )
	dxDrawText ( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wordBreak, postGUI )
end

local sellGUI = {}
sellGUI.window = guiCreateWindow(155,60,310,120,"Внимание!",false)
guiSetVisible(sellGUI.window, false)
guiSetProperty(sellGUI.window, "AlwaysOnTop", "true")
guiWindowSetSizable(sellGUI.window, false)
sellGUI.label = guiCreateLabel(21,28,266,36,"",false,sellGUI.window)
guiLabelSetColor(sellGUI.label, 38, 122, 216)
guiLabelSetHorizontalAlign(sellGUI.label,"center",true)
sellGUI.yes = guiCreateButton(17,73,129,36,"Да",false,sellGUI.window)
sellGUI.no = guiCreateButton(161,73,129,36,"Нет",false,sellGUI.window)

addEvent("showBuyGUI", true)
addEventHandler("showBuyGUI", root, function ()
	local sellInfo = source:getData("sellInfo") 
	if type(sellInfo) ~= "table" then
		return
	end
	showCursor(true)
	sellGUI.window.visible = true
	sellGUI.label.text = "Купить этот автомобиль за " .. tostring(sellInfo.price) .. " Руб.?"
end)


addEventHandler("onClientGUIClick", sellGUI.window, function ()
	showCursor(false)
	sellGUI.window.visible = false	
	if source == sellGUI.yes then
		Button_VS_sl.enabled = true
		local sellInfo = localPlayer.vehicle:getData("sellInfo") 
		if type(sellInfo) ~= "table" then
			return
		end			
		local r1, g1, b1, r2, g2, b2 = getVehicleColor(localPlayer.vehicle, true)
		triggerServerEvent("onBuyNewVehicle", localPlayer, 
			localPlayer.vehicle.model, 
			sellInfo.price, 
			r1, g1, b1, r2, g2, b2,
			true
		)
	else
		setControlState("enter_exit", true)
	end
end)
