# Technical Notes

## Architecture Overview
- **Autoloads** (`project.godot`): SoundManager, SceneTransitionManager, DataManager, SaveManager, GameManager, CameraShakeManager, EventBus, DialogueManager, PhantomCameraManager.
- **World Controller**: `scripts/gameplay/world.gd` manages player spawn, HUD wiring, intro/end dialogue, and checkpoint tracking. Mirrors `scripts/utilities/world_sidecar.gd` pattern.
- **Player**: `scripts/movement/player.gd` (`CharacterBody2D`) instantiated via `world.gd` from `scenes/common/player.tscn`.
- **UI**: HUD and timers in `scenes/common/ui/player_hud.tscn`; level end flow in `scenes/common/ui/level_end.tscn` (`level_end.gd`). Menus managed by `scripts/ui/main_menui_control.gd`.
- **Dialogue**: DialogueManager plugin with balloon scene `dialogue/balloons/dialogue_panel.tscn` triggered in world intro/end.

## Scene Organization Rules
- World scenes host Level nodes (`scripts/gameplay/level.gd`) that encapsulate TileMaps and camera triggers.
- Obstacles/hazards live under `scenes/common/world_obstacles/`; interactables under `scenes/common/world_interactables/`.
- Cameras use Phantom Camera scenes (`goal_cam.tscn`, `level_camera_2d.tscn`) with triggers (`2d_camera_trigger.gd`).

## State Management
- Lives/coins/timers tracked in GameManager/current_sidecar; events via EventBus (player_died, checkpoint_reached, level_end, etc.).
- Level progression keyed by `DataManager.world_dict` and scene transitions handled by SceneTransitionManager.

## Physics Approach
- Player uses manual `move_and_collide` to manage bounce behavior. Gravity pulled from project settings; bouncing scaled via export vars.
- Moving platforms detected by raycasts into TileMap or AnimatableBody2D.
- Trajectory preview simulates same forces with raycasts to predict contact/bounce.

## Save/Config
- SaveManager autoload exists but flow not wired in world/menus yet (needs verification). Settings resource at `game_resources/settings/default.tres` referenced by menu.

## Performance Considerations
- Keep TileMaps chunked per level; limit particle counts. Phantom Camera noise should be optional to reduce shake cost.
- Avoid excessive trajectory points; currently capped at 100.

## Testing Strategy
- Manual playtests per level for launch feel, bounce consistency, and camera framing.
- Smoke tests: boot main menu, start world_1, hit checkpoint, die and respawn, reach body goal and continue.
- Future: minimal unit tests for trajectory math and collision responses if adopting GUT.

## Known / Unknown
- **Known:** Exports configured for Web and Windows; Linux preset lacks path.
- **Unknown:** SaveManager integration state; controller input mappings; whether lives/coins persist between worlds. Add checks before release.
