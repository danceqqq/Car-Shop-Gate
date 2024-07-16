prewiewTarget = nil
defaultSettings = {
	front = {x=0,y=3,z=0},
	rear = {x=0,y=0,z=0},
}

local plateFont = dxCreateFont("numbers/plates/font.ttf",25)
local regFont = dxCreateFont("numbers/plates/font.ttf",29)
local sizeX,sizeY = 893,200
sizeX,sizeY = sizeX/1.5,sizeY/1.5

previewEvent = false

function drawNumbersPreview()
	local veh = getPedOccupiedVehicle(localPlayer)
    local nums = 'A 777 BC'
    local region = '76'

    if not prewiewTarget then
        prewiewTarget = {}
        prewiewTarget = dxCreateRenderTarget(sizeX,sizeY,true)
    end
    local renderTarget = prewiewTarget

    dxSetRenderTarget(renderTarget)
    dxDrawImage(0,0,sizeX,sizeY,'numbers/plates/ru.png',180)
    dxDrawText(nums,-sizeX+60,-sizeY+20,sizeX,sizeY, tocolor(0,0,0,255),2.3,plateFont,nil,nil,nil,nil,nil,nil,nil, 180,0,0)
    dxDrawText(region,-sizeX+450,-sizeY+20,sizeX,sizeY, tocolor(0,0,0,255),1.3,regFont,nil,nil,nil,nil,nil,nil,nil, 180,0,0)
    dxSetRenderTarget()
    
    local model = getElementModel(veh)
    local tab = getElementData(veh,'previewSettings')

    if tab then
        --Рисовка сзади
        local ofx,ofy,ofz = tab.rear.x,tab.rear.y,tab.rear.z

        local x1,y1,z1 = getPositionFromElementOffset(veh, ofx, ofy,ofz)
        local x2,y2,z2 = getPositionFromElementOffset(veh, ofx, ofy+tab.rear.rot,ofz+0.15+(tab.size2 or 0))
        local fx,fy,fz = getPositionFromElementOffset(veh, ofx, ofy-0.1, ofz)
        dxDrawMaterialLine3D(x1,y1,z1, x2,y2,z2, renderTarget, tab.size, tocolor(255,255,255,255), fx,fy,fz)


        --Рисовка спереди
        local ofx,ofy,ofz = tab.front.x,tab.front.y,tab.front.z
        local x1,y1,z1 = getPositionFromElementOffset(veh, ofx, ofy, ofz)
        local x2,y2,z2 = getPositionFromElementOffset(veh, ofx, ofy+tab.front.rot, ofz+0.15+(tab.size2 or 0))

        local fx,fy,fz = getPositionFromElementOffset(veh, ofx, ofy+0.5, ofz)
        dxDrawMaterialLine3D(x1,y1,z1, x2,y2,z2, renderTarget, tab.size, tocolor(255,255,255,255), fx,fy,fz)
    end
end

local window = guiCreateWindow(0.74,0.3, 0.25,0.4,'Настройки номеров',true)
guiWindowSetSizable(window,false)
guiSetVisible(window,false)

function showUnshowCursor()
	showCursor(not isCursorShowing())
end




--ЕБУЧИЙ ГУИ, КАК ЖЕ Я ЕГО БЛЯДЬ НЕНАВИЖУ НАХУЙ--


_ADMINGUIGROUP = {}
guiCreateLabel(0.03,0.1, 0.2,0.1, 'Передние:',true,window)

guiCreateLabel(0.025,0.22, 0.15,0.1, 'X:',true,window)
local front_edit_x = guiCreateEdit(0.06, 0.2, 0.17, 0.1, '', true,window)
_ADMINGUIGROUP[front_edit_x] = front_edit_x

guiCreateLabel(0.25,0.22, 0.15,0.1, 'Y:',true,window)
local front_edit_y = guiCreateEdit(0.285, 0.2, 0.17, 0.1, '', true,window)
_ADMINGUIGROUP[front_edit_y] = front_edit_y

guiCreateLabel(0.475,0.22, 0.15,0.1, 'Z:',true,window)
local front_edit_z = guiCreateEdit(0.51, 0.2, 0.17, 0.1, '', true,window)
_ADMINGUIGROUP[front_edit_z] = front_edit_z

guiCreateLabel(0.69,0.22, 0.15,0.1, 'ROT:',true,window)
local front_edit_rot = guiCreateEdit(0.77, 0.2, 0.17, 0.1, '', true,window)
_ADMINGUIGROUP[front_edit_rot] = front_edit_rot

---zad---

guiCreateLabel(0.03,0.35, 0.2,0.1, 'Задние:',true,window)

guiCreateLabel(0.025,0.45, 0.2,0.1, 'X:',true,window)
local rear_edit_x = guiCreateEdit(0.06, 0.43, 0.15, 0.1, '', true,window)
_ADMINGUIGROUP[rear_edit_x] = rear_edit_x

guiCreateLabel(0.25,0.45, 0.2,0.1, 'Y:',true,window)
local rear_edit_y = guiCreateEdit(0.285, 0.43, 0.15, 0.1, '', true,window)
_ADMINGUIGROUP[rear_edit_y] = rear_edit_y

guiCreateLabel(0.475,0.45, 0.2,0.1, 'Z:',true,window)
local rear_edit_z = guiCreateEdit(0.51, 0.43, 0.15, 0.1, '', true,window)
_ADMINGUIGROUP[rear_edit_z] = rear_edit_z

guiCreateLabel(0.69,0.45, 0.15,0.1, 'ROT:',true,window)
local rear_edit_rot = guiCreateEdit(0.77, 0.43, 0.17, 0.1, '', true,window)
_ADMINGUIGROUP[rear_edit_rot] = rear_edit_rot

guiCreateLabel(0.03,0.58, 1,0.1, 'Размер:',true,window)
local edit_size = guiCreateEdit(0.17, 0.56, 0.18, 0.1, '', true,window)
_ADMINGUIGROUP[edit_size] = edit_size

guiCreateLabel(0.37,0.58, 1,0.1, 'Размер2:',true,window)
local edit_size2 = guiCreateEdit(0.52, 0.56, 0.18, 0.1, '', true,window)
_ADMINGUIGROUP[edit_size2] = edit_size2

guiCreateLabel(0.03,0.78, 1,0.1, 'Подсказка: Нажмите ПКМ чтобы показать/скрыть курсор.',true,window)


local button_savePlates = guiCreateButton(0.05,0.84, 0.4,0.12, 'Сохранить',true,window)
addEventHandler('onClientGUIClick',button_savePlates,function()
	if source ~= button_savePlates then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if not isElement(veh) then return end
	local tab = getElementData(veh,'previewSettings')
	local model = getElementModel(veh)
	triggerServerEvent('saveNumbersOffset',getLocalPlayer(), model,tab)
	--
	if previewEvent then
		previewEvent:remove()
		previewEvent = nil
	end
	showCursor(false)
	guiSetVisible(window,false)
	unbindKey('mouse2','down',showUnshowCursor)
end,false)


local button_cancel = guiCreateButton(0.55,0.84, 0.4,0.12, 'Отмена',true,window)
addEventHandler('onClientGUIClick',button_cancel,function()
	if source ~= button_cancel then return end
	if previewEvent then
		previewEvent:remove()
		previewEvent = nil
	end
	showCursor(false)
	guiSetVisible(window,false)
	unbindKey('mouse2','down',showUnshowCursor)
end,false)

function refreshPreviewPositions()
	if not _ADMINGUIGROUP[source] then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if not isElement(veh) then return end
	local tab = getElementData(veh,'previewSettings')

	local frontX = (tonumber(guiGetText(front_edit_x)) or 0)
	local frontY = (tonumber(guiGetText(front_edit_y)) or 0)
	local frontZ = (tonumber(guiGetText(front_edit_z)) or 0)
	local frontRot = (tonumber(guiGetText(front_edit_rot)) or 0)

	local rearX = (tonumber(guiGetText(rear_edit_x)) or 0)
	local rearY = (tonumber(guiGetText(rear_edit_y)) or 0)
	local rearZ = (tonumber(guiGetText(rear_edit_z)) or 0)
	local rearRot = (tonumber(guiGetText(rear_edit_rot)) or 0)

	local size = (tonumber(guiGetText(edit_size)) or 0.7)
	local size2 = (tonumber(guiGetText(edit_size2)) or 0)
	tab.size = size
	tab.size2 = size2
	tab.front.x = frontX
	tab.front.y = frontY
	tab.front.z = frontZ
	tab.front.rot = frontRot

	tab.rear.x = rearX
	tab.rear.y = rearY
	tab.rear.z = rearZ
	tab.rear.rot = rearRot

	setElementData(veh,'previewSettings',tab)
end
addEventHandler("onClientGUIChanged", root, refreshPreviewPositions)

function startPlateConfigEditing()
	if previewEvent then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if not isElement(veh) then 
		outputChatBox('Ошибка: вы не находитесь в машине',255,0,0)
		return
	end
	local tab = vehicleOffsets[getElementModel(veh)]
	if not tab then
		setElementData(veh, 'previewSettings', defaultSettings)
	else
		setElementData(veh, 'previewSettings', tab)
	end
	prewiewTarget = nil
	previewEvent = addEventHandler('onClientPreRender',root,drawNumbersPreview)

	showCursor(true)
	guiSetVisible(window,true)
	bindKey('mouse2','down',showUnshowCursor)

	local model = getElementModel(veh)
	local tab = vehicleOffsets[model]
	tab = tab or {}
	tab.front = tab.front or {}
	tab.rear = tab.rear or {}

	guiSetText(front_edit_x, tab.front.x or 0)
	guiSetText(front_edit_y, tab.front.y or 0)
	guiSetText(front_edit_z, tab.front.z or 0)
	guiSetText(front_edit_rot, tab.front.rot or 0)

	guiSetText(rear_edit_x, tab.front.x or 0)
	guiSetText(rear_edit_y, tab.front.y or 0)
	guiSetText(rear_edit_z, tab.front.z or 0)
	guiSetText(edit_size, tab.size or 0.7)
	guiSetText(edit_size2, tab.size2 or 0)
end
addEvent('startPlateConfigEditing',true)
addEventHandler('startPlateConfigEditing',getRootElement(),startPlateConfigEditing)
--addCommandHandler('plateconfig',startPlateConfigEditing)