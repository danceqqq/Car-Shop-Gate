home = {}
home.spawnList = {
	--[[[id] = {
		id = int id,
		owner = text owner,
		enter = table enterPos,
		exit = table exitPos,ы
		price = int price,
		capacity = int capacity,
		interior = int interior,
		dimension = int dimension,

	}]]
	--[[{
		id=1,
		owner = nil,
		enter = {-30.902935028076,28.980436325073,3.1171875},
		exit = {-29.849405288696,17.842582702637,3.1171875},
		price = 1000,
		capacity = 3,
		interior = 0,
		dimension = 0,

	}]]
}


function setCarLimit(ply,value)
	setElementData(ply, '_carLimit', value)
end

function getCarLimit(ply)
	return (getElementData(ply, '_carLimit') or 1)
end


home.interiors = {
	--[capacity] = {}
	[1] = {
		pos = {421.83941650391,2536.5500488281,10},
		interior = 10,
	},

	[2] = {
		pos = {2282.9875488281,-1139.7690429688,1050.8984375},
		interior = 11,
	},

	[3] = {
		pos = {-261.09439086914,1456.7039794922,1084.3671875},
		interior = 4,
	},

	[4] = {
		pos = {2365.2631835938,-1135.0632324219,1050.875},
		interior = 8,
	},

	[5] = {
		pos = {140.24348449707,1366.6082763672,1083.859375},
		interior = 5,
	},

}
warpBlocked = {
	--[userdata]
}

function addHome(id,owner,enter,price,capacity)
	local tab = home.interiors[capacity]
	if not tab then
		interior = home.interiors[5].interior
		exit = home.interiors[5].pos
	else
		interior = home.interiors[capacity].interior
		exit = home.interiors[capacity].pos
	end
	local dimension = id

	local data = {
		id=tonumber(id),
		owner=owner,
		enter=enter,
		exit=exit,
		price=tonumber(price),
		capacity=tonumber(capacity),
		interior=tonumber(interior),
		dimension=tonumber(dimension),
	}
	home.spawnList[id] = data
	buildHome(data)
end

function buildHome(data)
	local id =  data.id

	local enterPos = data.enter
	local exitPos = data.exit

	local interior = data.interior
	local dimension = data.dimension
	local marker_enter = false
	if not data.owner then
		marker_enter = createMarker(enterPos[1],enterPos[2],enterPos[3]-1, 'cylinder', 1.5, 0,255,0,140)
	else
		marker_enter = createMarker(enterPos[1],enterPos[2],enterPos[3], 'arrow', 1.5, 255,255,0,140)
	end
	setElementData(marker_enter,'id',id)
	setElementData(marker_enter,'data',data)

	addEventHandler('onMarkerHit',marker_enter,function(element)
		local src = source
		if getElementType(element) ~= 'player' then return end

		local login = getAccountName(getPlayerAccount(element))
		if data.owner == login then
			if warpBlocked[element] then return end
			triggerClientEvent(element,'home:openHomeControl',src,data)
		else
			if not data.owner then
				triggerClientEvent(element,'home:startHomeBuying',src)
			end
		end
	end)

	local marker_exit = createMarker(exitPos[1],exitPos[2],exitPos[3]+1, 'arrow', 1.5, 0,255,0,140)
	setElementDimension(marker_exit, dimension)
	setElementInterior(marker_exit, interior)

	setElementData(marker_exit,'id',id)
	setElementData(marker_exit,'data', data)

	setElementData(marker_enter,'parent',marker_exit)
	setElementData(marker_exit,'parent',marker_enter)
	addEventHandler('onMarkerHit',marker_exit,function(element)
		if warpBlocked[element] then return end
		if source ~= marker_exit then return end
		if getElementInterior(source) ~= getElementInterior(element) then return end
		if getElementDimension(source) ~= getElementDimension(element) then return end
		local id = getElementData(source,'id')
		local data = home.spawnList[id]
		local pos = data.enter

		setElementPosition(element, pos[1],pos[2],pos[3]+0.4)
		setElementDimension(element, 0)
		setElementInterior(element, 0)

		warpBlocked[element] = true
		setTimer(function()
			warpBlocked[element] = nil
		end,1500,1)
	end)
end

function removeHome(ply)
	local accName = getAccountName(getPlayerAccount(ply))
	if not isObjectInACLGroup("user."..accName,aclGetGroup("Admin")) then 
		outputChatBox('Ошибка: Вы не администратор',ply,255,0,0)
		return
	end
	local px,py,pz = getElementPosition(ply)
	local marker = false
	local lastDist = 99999
	for _,mrk in pairs(getElementsByType('marker')) do
		if getElementData(mrk,"data") then
			local mx,my,mz = getElementPosition(mrk)
			local dist = getDistanceBetweenPoints3D(px,py,pz, mx,my,mz)
			if (dist < lastDist) and (dist < 3) then
				lastDist = dist
				marker = mrk
			end
		end
	end
	local id = getElementData(marker,'id')
	sql.query("DELETE FROM homes WHERE id=?",{id})
	destroyElement(marker)
end
addCommandHandler('removeHome',removeHome)

function loadHomes()
	sql.query("SELECT * FROM homes",nil, function(result)
		for i=1,#result do
			local tab = result[i]
			local enter = fromJSON(tab.enter)
			tab.enter = enter
			addHome(tab.id,tab.owner,tab.enter,tab.price,tab.capacity)
		end
	end)
end
addEventHandler('onResourceStart',getResourceRootElement(getThisResource()),loadHomes)

function buyHome(data,marker)
	local ply = source
	local login = getAccountName(getPlayerAccount(ply))
	local x,y,z = getElementPosition(marker)
	takePlayerMoney(ply,data.price)

	home.spawnList[data.id].owner = login
	setCarLimit(ply,getCarLimit(ply)+data.capacity)

	setMarkerType(marker,'arrow')
	setMarkerColor(marker,255,255,0,140)
	setMarkerSize(marker,1.5)
	setElementPosition(marker,x,y,z+2)
	sql.query("UPDATE homes SET owner=? WHERE id=?",{login,data.id})
	outputChatBox('Поздравляем с покупкой дома!',ply,0,255,0)
end
addEvent('home:buyHome',true)
addEventHandler('home:buyHome',getRootElement(),buyHome)

function sellHome(data,marker)
	local ply = source
	local login = getAccountName(getPlayerAccount(ply))
	local x,y,z = getElementPosition(marker)

	givePlayerMoney(ply,data.price*0.75)

	home.spawnList[data.id].owner = nil
	setCarLimit(ply,getCarLimit(ply)-data.capacity)
	setMarkerType(marker,'cylinder')
	setMarkerColor(marker,0,255,0,140)
	setMarkerSize(marker,2)
	setElementPosition(marker,x,y,z-2)
	sql.query("UPDATE homes SET owner=? WHERE id=?",{nil,data.id})

	outputChatBox('Вы продали дом и получили'..(data.price*0.75)..'$',ply,0,255,0)
end
addEvent('home:sellHome',true)
addEventHandler('home:sellHome',getRootElement(),sellHome)

function addNewHome(ply,cmd,price,capacity)
	local accName = getAccountName(getPlayerAccount(ply))
	if not isObjectInACLGroup("user."..accName,aclGetGroup("Admin")) then 
		outputChatBox('Ошибка: Вы не администратор',ply,255,0,0)
		return
	end
	if not price or not tonumber(price) then
		outputChatBox('Ошибка: вы не ввели цену',ply,255,0,0)
		return
	end
	if not capacity or not tonumber(capacity) then
		outputChatBox('Ошибка: вы не ввели вместимость',ply,255,0,0)
		return
	end
	local x,y,z = getElementPosition(ply)
	local enter = toJSON({x,y,z})
	sql.query("INSERT INTO homes VALUES (?,?,?,?,?)",{nil,nil,enter,price,capacity})
end
addCommandHandler('addhome',addNewHome)


function warpToHome(marker)
	local ply = source
	warpBlocked[ply] = true
	local parent = getElementData(marker,'parent')
	setElementInterior(ply, getElementInterior(parent))
	setElementDimension(ply, getElementDimension(parent))
	local x,y,z = getElementPosition(parent)
	setElementPosition(ply, x,y,z)

	setTimer(function()
		warpBlocked[ply] = nil
	end,1500,1)
end
addEvent('home:warpToHome',true)
addEventHandler('home:warpToHome',getRootElement(),warpToHome)

homeOffers = {}

function sendHomeSellInvite(nick,data,price)
	local ply = getPlayerFromName(nick)
	if not ply then
		outputChatBox('Ошибка: игрок '..nick..' не на сервере',source,255,0,0)
		return
	end
	homeOffers[ply] = {
		data = data,
		sender = source,
		price = price
	}
	outputChatBox('ВНИМАНИЕ! Игрок "'..getPlayerName(source)..'" предложил вам купить свой дом',ply,255,100,0)
	outputChatBox('Цена: '..price..'$. Вместимость: '..data.capacity,ply,255,100,0)
	outputChatBox('Чтобы принять предложение введите /haccept Чтобы отклонить введите /hreject',ply,255,100,0)
end
addEvent('home:sendHomeSellInvite',true)
addEventHandler('home:sendHomeSellInvite',root,sendHomeSellInvite)


function acceptHomeBuyOffer(ply)
	if not homeOffers[ply] then return end
	local htab = homeOffers[ply]
	if getPlayerMoney(ply) < htab.price then
		outputChatBox('Ошибка: Не хватает денег для покупки',ply,255,0,0)
		return
	end
	if not isElement(htab.sender) then
		outputChatBox('Ошибка: Продавец не онлайн',ply,255,0,0)
		return
	end

	outputChatBox('Игрок "'..getPlayerName(ply)..'" Принял ваше предложение о покупке дома. Вы получили '..htab.price..'$',htab.sender,0,255,0)
	takePlayerMoney(ply, htab.price)
	givePlayerMoney(htab.sender, htab.price)

	setCarLimit(htab.sender,getCarLimit(htab.sender)+htab.data.capacity)

	local homeID = htab.data.id
	local login = getAccountName(getPlayerAccount(ply))

	sql.query("UPDATE homes SET owner=? WHERE id=?",{login, homeID})
	home.spawnList[homeID].owner = login

	setCarLimit(ply,getCarLimit(ply)+htab.data.capacity)
	homeOffers[ply] = nil
end
addCommandHandler('haccept',acceptHomeBuyOffer)

function rejectHomeBuyOffer(ply)
	if not homeOffers[ply] then return end
	local htab = homeOffers[ply]
	outputChatBox('Игрок "'..getPlayerName(ply)..'" Отклонил ваше предложение о покупке дома',htab.sender,255,0,0)
	homeOffers[ply] = nil
end
addCommandHandler('hreject',rejectHomeBuyOffer)


function onLogin()
	local ply = source
	setCarLimit(ply, 1)
	local login = getAccountName(getPlayerAccount(ply))
	sql.query('SELECT * FROM homes WHERE owner=?',{login},function(result)
		for i=1,#result do
			local data = result[i]
			setCarLimit(ply, getCarLimit(ply)+data['capacity'])
		end
	end)
end
addEventHandler('onPlayerLogin',root,onLogin)