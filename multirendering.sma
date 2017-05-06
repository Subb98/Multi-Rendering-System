/* Multi-Rendering System 0.3 [06.05.2017]
 * thanks: PRoSToTeM@ for consultations */

#pragma semicolon 1

#include <amxmodx>
#include <engine>
#include <multirendering>

enum _:RENDERING_DATA {
    rd_r_index,
    rd_fx,
    rd_r,
    rd_g,
    rd_b,
    rd_render,
    rd_amount
}

new Array:g_data[33];

new g_maxplayers;

public plugin_natives() {
    register_native("add_user_rendering", "native_add_user_rendering");
    register_native("remove_user_rendering", "native_remove_user_rendering");
}

public plugin_init() {
    register_plugin("Multi-Rendering System", "0.3", "Subb98");

    g_maxplayers = get_maxplayers();

    for(new i = 1; i <= g_maxplayers; i++) {
        g_data[i] = ArrayCreate(RENDERING_DATA);
    }
}

public client_putinserver(id) {
    if(!is_user_hltv(id)) {
        ArrayClear(g_data[id]);
    }
}

public plugin_end() {
    for(new i = 1; i <= g_maxplayers; i++) {
        ArrayDestroy(g_data[i]);
    }
}

public native_add_user_rendering() {
    new id = get_param(1);
    new r_index = get_param_byref(2);
    new data[RENDERING_DATA];

    if(r_index) {
        check_rendering(id, r_index, ArraySize(g_data[id]), data);
    }

    static unique_r_index;

    data[rd_fx] = get_param(3);
    data[rd_r] = get_param(4);
    data[rd_g] = get_param(5);
    data[rd_b] = get_param(6);
    data[rd_render] = get_param(7);
    data[rd_amount] = get_param(8);

    set_rendering(id, data[rd_fx], data[rd_r], data[rd_g], data[rd_b], data[rd_render], data[rd_amount]);

    data[rd_r_index] = ++unique_r_index; // unique index number, autoincrement

    ArrayPushArray(g_data[id], data);
    set_param_byref(2, data[rd_r_index]);

    return data[rd_r_index];
}

public native_remove_user_rendering() {
    new id = get_param(1);
    new r_index = get_param_byref(2);
    new size = ArraySize(g_data[id]);
    new data[RENDERING_DATA];

    if(!check_rendering(id, r_index, size, data)) {
        return INVALID_HANDLE;
    }

    if(--size) {
        ArrayGetArray(g_data[id], size - 1, data);
        set_rendering(id, data[rd_fx], data[rd_r], data[rd_g], data[rd_b], data[rd_render], data[rd_amount]);
    } else {
        set_rendering(id);
    }

    set_param_byref(2, R_INDEX_NULL);

    return R_INDEX_NULL;
}

bool:check_rendering(const id, const r_index, const size, data[]) {
    for(new i; i < size; i++) {
        ArrayGetArray(g_data[id], i, data);

        if(data[rd_r_index] == r_index) {
            ArrayDeleteItem(g_data[id], i);
            return true;
        }
    }

    return false;
}
