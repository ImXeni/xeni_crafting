local config = require 'config.client'
local shared = require 'config.shared'

local spawnedBenches = {}

local function playerHasJob(job)
    if job then
        return exports.qbx_core:HasPrimaryGroup(job)
    else
        return exports.qbx_core:HasPrimaryGroup('unemployed')
    end
end

local function getRequiredMaterials(itemData)
    local requiredMaterials = ""
    for material, amount in pairs(itemData.requiredmaterials) do
        requiredMaterials = requiredMaterials .. material .. ": " .. amount .."x" .. "\n"
    end
    return requiredMaterials
end


local function benchMenu()
    local options = {}

    for itemName, itemData in pairs(shared.items) do
        if playerHasJob(itemData.job) then
            local requiredMaterials = getRequiredMaterials(itemData)
            table.insert(options, {
                title = itemName,
                description = 'Required: \n' .. requiredMaterials,
                icon = itemData.image or '',
                onSelect = function()
                    if lib.progressCircle({
                        duration = 10000, 
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                            car = true, 
                        },
                        anim = {
                            dict = 'mp_player_intdrink',
                            clip = 'loop_bottle',
                        },
                    }) then
                        TriggerServerEvent('xeni_craftingbenches:server:grantItem', itemName, itemData.requiredmaterials)
                    end
                end,
            })
        end
    end
    lib.registerContext({
        id = 'event_menu',
        title = 'Crafting Bench',
        options = options,
    })
    lib.showContext('event_menu')
end

local function targetBenches(coords, size, rotation, job)
    local options = {
        label = 'Use Bench',
        icon = 'fa-solid fa-screwdriver-wrench',
        distance = 1,
        onSelect = benchMenu,
    }

    if job then
        options.groups = { [job] = 0 }
    end

    exports.ox_target:addBoxZone({
        coords = coords,
        name = 'Benches',
        size = size,
        rotation = rotation,
        drawSprite = true,
        options = options,
    })
end

local function spawnBenches()
    for _, bench in ipairs(shared.benchlocations) do
        local model = lib.requestModel(bench.model)
        local benchObject = CreateObject(model, bench.coords.x, bench.coords.y, bench.coords.z - 1, false, false, false)
        FreezeEntityPosition(benchObject, true)
        SetEntityHeading(benchObject, bench.coords.w)
        targetBenches(bench.coords, bench.boxZoneSize, bench.coords.w, bench.job)

        table.insert(spawnedBenches, benchObject)
    end
end

local function removeBenches()
    for _, benchObject in ipairs(spawnedBenches) do
        if DoesEntityExist(benchObject) then
            DeleteEntity(benchObject)
        end
    end
    spawnedBenches = {}
end

AddEventHandler('onResourceStop', function(resource)
    if resource ~= cache.resource then return end
    removeBenches()
end)

AddEventHandler('onClientResourceStart', function(resource)
    if resource ~= cache.resource then return end
    spawnBenches()
end)