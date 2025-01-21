local config = require 'config.server'
local shared = require 'config.shared'

RegisterNetEvent('xeni_craftingbenches:server:grantItem', function(itemName, requiredmaterials)
    local player = source  
    for material, amount in pairs(requiredmaterials) do
        local playerHasMaterial = exports.ox_inventory:GetItemCount(player, material)
        
        if playerHasMaterial < amount then
            exports.qbx_core:Notify('Error', 'error', 5000, 'Not Enough Materials')
            return
        end
    end

    for material, amount in pairs(requiredmaterials) do
        exports.ox_inventory:RemoveItem(player, material, amount)
    end

    exports.ox_inventory:AddItem(player, itemName, 1)
end)
