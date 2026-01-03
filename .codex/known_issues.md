# Known Issues

- **Unset sidecar reference**: `GameManager.current_sidecar` is never assigned, yet `level_end.gd` and `speech_interactable.gd` read it for HUD/timer; end-of-level or dialogue can crash/null-ref until fixed. (`scripts/gameplay/world.gd`, `scripts/utilities/world_sidecar.gd`, `scenes/common/ui/level_end.gd`)
- **World 2 lacks body goal**: No `body_goal.tscn` instance in `scenes/worlds/world_2/level_*.tscn`, so players cannot finish the world or trigger level-end UI.
- **Possible double-spawn in World 2**: `world.gd` and `world_sidecar.gd` both spawn players; scene contains both, risking duplicate players/HUD state. (`scenes/worlds/world_2.tscn`)
- **Restart absent**: No manual restart/unstick control; soft-lock risk when stuck between slopes/platforms.
- **Door/key feedback minimal**: Door requires keys but HUD lacks required-key prompt; error dialogue fires only on interaction.
- **Save/Load unverified**: SaveManager autoload and save/load buttons exist but flow is not connected/tested; persistence unclear.
- **Camera/readability unvalidated**: Camera triggers/limits per level not audited; shake not user-toggleable; potential off-screen landings.
