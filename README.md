# Multi-Rendering System
Multi-Rendering System – it [AMX Mod X](https://github.com/alliedmodders/amxmodx) plugin, allow resolve conflicts at using *_rendering natives. The plugin adds own natives, which must be used in other plugins at working with player's rendering. This will avoid conflicts.

```c
/* Sets rendering for player's model
 * Assigns a unique index to the setted rendering and returns it as an integer (2 arg)
 * Usage example: add_user_rendering(id, g_index[id], kRenderFxGlowShell, 0, 100, 200, kRenderGlow, 10); */
native add_user_rendering(const id, &r_index, const fx = kRenderFxNone, const r = 255, const g = 255, const b = 255, const render = kRenderNormal, const amount = 16);

/* Removes rendering by unique index
 * In success, to unique index (2 arg) assigned value 0 (R_INDEX_NULL) and it returned as an integer
 * In failure, returns -1 (INVALID_HANDLE)
 * Usage example: remove_user_rendering(id, g_index[id]); */
native remove_user_rendering(const id, &r_index);
```
