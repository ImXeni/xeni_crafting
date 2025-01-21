return {
    benchlocations = {
        [1] =  {coords = vec4(-11.18, -1120.4, 27.45, 125.0), model = 'gr_prop_gr_tool_draw_01a', boxZoneSize = vec3(0.80000000000001, 0.85000000000001, 1.1), job = 'police',},
        [2] =  {coords = vec4(-9.92, -1122.48, 27.54, 183.73), model = 'gr_prop_gr_tool_draw_01a', boxZoneSize = vec3(0.80000000000001, 0.85000000000001, 1.1), job = nil,},
    },

    items = {
        ['weapon_pistol'] = {
            job = 'ammunation',
            image = 'nui://ox_inventory/web/images/weapon_pistol.png',
            requiredmaterials = {
                weaponparts = 3
            }
        },
        ['weapon_combatpistol'] = {
            job = 'ammunation',
            image = 'nui://ox_inventory/web/images/weapon_combatpistol.png',
            requiredmaterials = {
                weaponparts = 5
            }
        },
        ['weapon_appistol'] = {
            job = nil,
            image = 'nui://ox_inventory/web/images/weapon_appistol.png',
            requiredmaterials = {
                switch = 1
            }
        },

    }


}
