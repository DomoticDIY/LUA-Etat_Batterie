-- =========================================
-- Check battery level for all used devices
-- =========================================

-- User Configuration
BatteryThreshold = 20
WeeklySummary = true -- Envoi le W-E (oui ou non)
SummaryDay = 1 -- Sunday is 1
EmailTo = "tel.domi@gmail.com"
ReportHour = 08
ReportMinute = 30
Domoticz = "localhost"
DomoticzPort = "8080"
Sujet = ''
Message = ''
EnvoiMail = false

json = (loadfile "/home/pi/domoticz/scripts/lua/JSON.lua")() -- linux
--json = (loadfile "C:\\Domoticz\\scripts\\lua\\json.lua")() -- windows
commandArray = {}
time = os.date("*t")

-- Weekly Device Battery Summary
if WeeklySummary == true and time.wday == SummaryDay and time.hour == ReportHour and time.min == ReportMinute then

    -- Get a list of all devices
    handle = io.popen("curl 'http://" .. Domoticz .. ":" .. DomoticzPort .. "/json.htm?type=devices&order=name'")
    devicesJson = handle:read('*all')
    handle:close()
    devices = json:decode(devicesJson)
    BattToReplace = false
    Sujet = 'Info Domoticz : Niveau des Batteries'
    for i,device in ipairs(devices.result) do
        if device.BatteryLevel < 100 then -- and device.Used == 1 then
            Message = Message .. device.Name .. ' : Batteries = ' .. device.BatteryLevel .. '%<br>'
            print(device.Name .. ' : Batteries = ' .. device.BatteryLevel .. '%')
            EnvoiMail = true
        end
    end

-- Daily Low Battery Report
elseif time.hour == ReportHour and time.min == ReportMinute then

    -- Get a list of all devices
    handle = io.popen("curl 'http://" .. Domoticz .. ":" .. DomoticzPort .. "/json.htm?type=devices&order=name'")
    devicesJson = handle:read('*all')
    handle:close()
    devices = json:decode(devicesJson)
    BattToReplace = false
    Sujet = 'Alerte Domoticz : Niveau Batteries faible'
    for i,device in ipairs(devices.result) do
        if device.BatteryLevel < BatteryThreshold then -- and device.Used == 1 then
            Message = Message .. device.Name .. ' : Batteries = ' .. device.BatteryLevel .. '%<br>'
            print(device.Name .. ' : Batteries = ' .. device.BatteryLevel .. '%')
            EnvoiMail = true
        end
    end

end

if EnvoiMail == true then
    commandArray['SendEmail']=Sujet .. '#' .. Message .. '#' .. EmailTo
end

return commandArray
