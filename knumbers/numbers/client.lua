allowedSymbols = {
	['A'] = 'A',
	['B'] = 'B',
	['C'] = 'C',
	['Y'] = 'Y',
	['O'] = 'O',
	['P'] = 'P',
	['T'] = 'T',
	['E'] = 'E',
	['X'] = 'X',
	['M'] = 'M',
	['H'] = 'H',
	['K'] = 'K',

	['А'] = 'A',
	['В'] = 'B',
	['С'] = 'C',
	['У'] = 'Y',
	['О'] = 'O',
	['Р'] = 'P',
	['Т'] = 'T',
	['Е'] = 'E',
	['Х'] = 'X',
	['М'] = 'M',
	['Н'] = 'H',
	['К'] = 'K',

	['а'] = 'A',
	['в'] = 'B',
	['с'] = 'C',
	['у'] = 'Y',
	['о'] = 'O',
	['р'] = 'P',
	['т'] = 'T',
	['е'] = 'E',
	['х'] = 'X',
	['м'] = 'M',
	['н'] = 'H',
	['к'] = 'K',

	['0'] = '0',
	['1'] = '1',
	['2'] = '2',
	['3'] = '3',
	['4'] = '4',
	['5'] = '5',
	['6'] = '6',
	['7'] = '7',
	['8'] = '8',
	['9'] = '9',
}

--showCursor(true)

numberShop = {}

numberShop.symbolGroup = {}
numberShop.numberGroup = {}

local numbersWindow = guiCreateWindow(0.35,0.2, 0.3,0.3, 'Регистрация номеров',true)
guiSetVisible(numbersWindow,false)
guiWindowSetSizable(numbersWindow,false)
local numbersTabPanel = guiCreateTabPanel(0,0.1, 1,0.84, true,numbersWindow)

local number_select_tab = guiCreateTab('Регистрация',numbersTabPanel)

local label_selectPrice = guiCreateLabel(0,0.1,1,0.2,'Цена покупки: 500 000 Рублей',true,number_select_tab)
guiLabelSetHorizontalAlign(label_selectPrice,'center')


guiCreateLabel(0.3,0.42,0.3,0.15,'Регион:',true,number_select_tab)
local _region = guiCreateEdit(0.45,0.4, 0.25,0.15,'76',true,number_select_tab)

numberShop.symbolGroup[1] = guiCreateEdit(0.17,0.23, 0.1,0.15,'A',true,number_select_tab)
--
numberShop.numberGroup[1] = guiCreateEdit(0.28,0.23, 0.1,0.15,'1',true,number_select_tab)
numberShop.numberGroup[2] = guiCreateEdit(0.39,0.23, 0.1,0.15,'2',true,number_select_tab)
numberShop.numberGroup[3] = guiCreateEdit(0.50,0.23, 0.1,0.15,'3',true,number_select_tab)
--
numberShop.symbolGroup[2] = guiCreateEdit(0.61,0.23, 0.1,0.15,'B',true,number_select_tab)
numberShop.symbolGroup[3] = guiCreateEdit(0.72,0.23, 0.1,0.15,'C',true,number_select_tab)

function checkSpecialNumbers()
	local _s1 = guiGetText(numberShop.symbolGroup[1])
	local _s2 = guiGetText(numberShop.symbolGroup[2])
	local _s3 = guiGetText(numberShop.symbolGroup[3])

	local _n1 = guiGetText(numberShop.numberGroup[1])
	local _n2 = guiGetText(numberShop.numberGroup[2])
	local _n3 = guiGetText(numberShop.numberGroup[3])

	local _reg = guiGetText(_region)
	local _numbs = _s1.._n1.._n2.._n3.._s2.._s3.._reg
	_numbs = string.lower(_numbs)
	if specialNumbers[_numbs] then
		guiSetText(label_selectPrice, 'Цена покупки: '..specialNumbers[_numbs]..' руб')
		numberShop.currentData.selectionPrice = specialNumbers[_numbs]
	else
		guiSetText(label_selectPrice,'Цена покупки: '..numberShop.currentData.selPrice..' руб')
	end
end

for i=1,3 do 
	guiEditSetMaxLength(numberShop.symbolGroup[i],1)
	addEventHandler("onClientGUIChanged",numberShop.symbolGroup[i],function(element)
		checkSpecialNumbers()
	end)
end



for i=1,3 do 
	guiEditSetMaxLength(numberShop.numberGroup[i],1) 
	addEventHandler("onClientGUIChanged",numberShop.numberGroup[i],function(element)
		checkSpecialNumbers()
	end)
end


guiEditSetMaxLength(_region,3)
addEventHandler("onClientGUIChanged",_region,function(element)
	numberShop.regNum2 = ''
	local str = guiGetText(source)
	local len = string.len(str)
	for i=1,len do
		local symb = string.sub(str,i,i)
		for i2=0,9 do
			if symb == tostring(i2) then
				numberShop.regNum2 = numberShop.regNum2..symb
			end
		end
	end
	guiSetText(_region,numberShop.regNum2)
	checkSpecialNumbers()
end)

function grabNumbers()
	numberShop.currentNums = ''
	local s1 = guiGetText(numberShop.symbolGroup[1])
	local s2 = guiGetText(numberShop.symbolGroup[2])
	local s3 = guiGetText(numberShop.symbolGroup[3])

	local n1 = guiGetText(numberShop.numberGroup[1])
	local n2 = guiGetText(numberShop.numberGroup[2])
	local n3 = guiGetText(numberShop.numberGroup[3])

	local _numbers = {s1,n1,n2,n3,s2,s3}
	for i=1,6 do
		local symb = _numbers[i]
		if not allowedSymbols[symb] then
			outputChatBox('symb: '..tostring(symb))
			return false
		end
		numberShop.currentNums = numberShop.currentNums..allowedSymbols[symb]
	end
	return numberShop.currentNums
end

local button_buySelect = guiCreateButton(0.3, 0.6, 0.4, 0.17, 'Купить', true,number_select_tab)
addEventHandler('onClientGUIClick',button_buySelect,function()
	if source ~= button_buySelect then return end
	local money = getPlayerMoney(getLocalPlayer())
	if numberShop.currentData.selectionPrice > money then
		outputChatBox('[Регистрация номеров] На данный момент, у вас не повзоляет сумма для регистрация новых номеров.',255,0,0)
		return
	end

	local numbers = grabNumbers()
	if numbers == false then 
		outputChatBox('[Регистрация номеров]: поле "Номера" заполнено некорректно (не все символы поддерживаются)',255,0,0)
		return 
	end
	local region = guiGetText(_region)
	if string.len(region) < 2 then
		outputChatBox('[Регистрация номеров]: поле "Регион" заполнено некорректно (минимум 2 цифры)',255,0,0)
		return
	end
	local veh = getPedOccupiedVehicle(getLocalPlayer())
	if not isElement(veh) then return end
	local data = numberShop.currentData
	triggerServerEvent('numbers:buyNumbers',getLocalPlayer(),veh,numbers,region,data.selectionPrice)
	guiSetVisible(numbersWindow,false)
	showCursor(false)
end)

local button_cancelSelect = guiCreateButton(0.3, 0.8, 0.4, 0.17, 'Отмена', true,number_select_tab)
addEventHandler('onClientGUIClick',button_cancelSelect,function()
	if source ~= button_cancelSelect then return end
	guiSetVisible(numbersWindow,false)
	showCursor(false)
end)

function startNumberSelect(data)
	numberShop.currentData = data
	numberShop.currentData.selPrice = data.selectionPrice
	guiSetText(label_randomPrice,'Цена покупки: '..data.price..'$')
	guiSetText(label_selectPrice,'Цена покупки: '..data.selectionPrice..'$')

	guiSetVisible(numbersWindow,true)
	showCursor(true)

	checkSpecialNumbers()
end
addEvent('numbers:startNumberSelect',true)
addEventHandler('numbers:startNumberSelect',getRootElement(),startNumberSelect)
