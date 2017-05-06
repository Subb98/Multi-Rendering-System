/* Multi-Rendering Example 0.3 [06.05.2017]
 * thanks: PRoSToTeM@ for consultations */

#pragma semicolon 1

#include <amxmodx>
#include <multirendering>

enum _:COLOR_DATA {
    cd_r,
    cd_g,
    cd_b
}

new g_r_index[33][COLOR_DATA];

public plugin_natives() {
    set_native_filter("native_filter");
}

public plugin_init() {
    register_plugin("Multi-Rendering Example", "0.3", "Subb98");

    register_clcmd("say /r", "CmdSetR");
    register_clcmd("say /g", "CmdSetG");
    register_clcmd("say /b", "CmdSetB");
    register_clcmd("say /ur", "CmdUnsetR");
    register_clcmd("say /ug", "CmdUnsetG");
    register_clcmd("say /ub", "CmdUnsetB");
}

public native_filter(const name[], const index, const trap) {
    if(!trap) {
        return PLUGIN_HANDLED;
    }

    return PLUGIN_CONTINUE;
}

public CmdSetR(const id) {
    log_amx("func: CmdSetR(%d) | g_r_index[%d][cd_r] = %d", id, id, add_user_rendering(id, g_r_index[id][cd_r], kRenderFxGlowShell, 255, 0, 0, kRenderGlow, 16));
}

public CmdSetG(const id) {
    log_amx("func: CmdSetG(%d) | g_r_index[%d][cd_g] = %d", id, id, add_user_rendering(id, g_r_index[id][cd_g], kRenderFxGlowShell, 0, 255, 0, kRenderGlow, 16));
}

public CmdSetB(const id) {
    log_amx("func: CmdSetB(%d) | g_r_index[%d][cd_b] = %d", id, id, add_user_rendering(id, g_r_index[id][cd_b], kRenderFxGlowShell, 0, 0, 255, kRenderGlow, 16));
}

public CmdUnsetR(const id) {
    log_amx("func: CmdUnsetR(%d) | g_r_index[%d][cd_r] = %d, result = %d", id, id, g_r_index[id][cd_r], remove_user_rendering(id, g_r_index[id][cd_r]));
}

public CmdUnsetG(const id) {
    log_amx("func: CmdUnsetG(%d) | g_r_index[%d][cd_g] = %d, result = %d", id, id, g_r_index[id][cd_g], remove_user_rendering(id, g_r_index[id][cd_g]));
}

public CmdUnsetB(const id) {
    log_amx("func: CmdUnsetB(%d) | g_r_index[%d][cd_b] = %d, result = %d", id, id, g_r_index[id][cd_b], remove_user_rendering(id, g_r_index[id][cd_b]));
}
