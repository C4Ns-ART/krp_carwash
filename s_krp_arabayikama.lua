obje = {}
function arabaYikamaFonksiyonu(localPlayer, komut, aracID)
    if not aracID then
        outputChatBox("[KRP]:#ffffff Taşıt ID girmediniz!",localPlayer,149,22,36,true)
    return end
    
    if getElementData(localPlayer, "aracyikiyor") == true then
        outputChatBox("[KRP]:#FFFFFF Zaten şuanda araç yıkama işlemi gerçekleştiriyorsunuz!",localPlayer,149,22,36,true)
    return end

    local theVehicle = exports.pool:getElement("vehicle", aracID)
    if getElementData(localPlayer, "loggedin") == 1 then -- Karaktere giriş yaptıysa.
        if not getPedOccupiedVehicle(localPlayer) then -- Araç içerisinde değilse.
            local x,y,z = getElementPosition(localPlayer)
            local xv,yv,zv = getElementPosition(theVehicle)
            local int = getElementInterior(localPlayer)
            local dim = getElementDimension(localPlayer)
            if getDistanceBetweenPoints3D(x,y,z,xv,yv,zv) < 2 then -- Karakter ile Araç birbirine yakınsa.
                --if exports.global:hasItem(localPlayer, 10035, 1) then -- Yıkama süngeri varsa.
                    exports.global:sendLocalDoAction(localPlayer, "Elinde yıkama süngeri bulunmaktadır.")
                    exports.global:sendLocalMeAction(localPlayer, "elindeki yıkama süngerini kovaya batırır ve aracı yıkamaya başlar.")
                    setElementData(localPlayer, "aracyikiyor", true)
                    obje[localPlayer] = createObject(1778,x,y+1.5,z-1)
                    setElementInterior(obje[localPlayer], int)
                    setElementDimension(obje[localPlayer], dim)
                    setElementFrozen(localPlayer, true)
                    exports.global:applyAnimation(localPlayer, "bar", "barserve_bottle", -1, true, false, false) -- Kaynak yap animasyonu
                    triggerClientEvent("aracYikamaGonderildi", localPlayer, localPlayer, theVehicle)
                    outputChatBox("[KRP]:#FFFFFF Aracı temizlemeye başladınız!",localPlayer,149,22,36,true)
                    setTimer(function()
                        exports.global:sendLocalDoAction(localPlayer, "Aracın temizlendiği görünmektedir.")
                        destroyElement(obje[localPlayer])
                        obje[localPlayer] = nil
                        outputChatBox("[KRP]:#FFFFFF Aracın temizliğini tamamladınız!",localPlayer,149,22,36,true)
                        setElementFrozen( localPlayer, false )
                        setPedAnimation(localPlayer, "", "")
                        setElementData(localPlayer, "aracyikiyor", nil)
                    end,10000,1)
                --else
                    --outputChatBox("[KRP]:#FFFFFF Aracı yıkamak için [ Yıkama Süngeri ] adlı eşyaya ihtiyacınız bulunmakta!",localPlayer,149,22,36,true)
                --end
            else
                outputChatBox("[KRP]:#FFFFFF [ID: "..tonumber(aracID).."] taşıtın yakınında değilsiniz!",localPlayer,149,22,36,true)
            end
        else
            outputChatBox("[KRP]:#FFFFFF Araç içerisindeyken araç temizleme işlemini yapamazsınız!",localPlayer,149,22,36,true)
        end
    end
end
addCommandHandler("aracyikama", arabaYikamaFonksiyonu)