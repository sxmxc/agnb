# Repository Map

## Start Here
- **Engine entry:** `project.godot` → `run/main_scene` points to `scenes/menus/main_menu.tscn`.
- **Menu flow:** `scenes/menus/main_menu.tscn` (logic in `scripts/ui/main_menui_control.gd`) starts the first world from `game_resources/world_refs/*.tres`, plays UI audio via `SoundManager`, and routes to settings/save/load UI.
- **Gameplay loop:** Worlds (`scenes/worlds/world_*.tscn`) load level chunks, spawn the skull player (`scenes/common/player.tscn` with `scripts/movement/player.gd`), manage checkpoints/deaths/dialogue in `scripts/gameplay/world.gd`, and present HUD/pause/game-over/level-end UI.
- **Level completion:** Body goal prefab `scenes/common/world_obstacles/body_goal.tscn` fires `level_end` events consumed in `world.gd` and `scenes/common/ui/level_end.gd`; currently only placed in `world_1/level_2.tscn`.

## Scenes & Prefabs
- **Menus/UI:**
  - Main menu: `scenes/menus/main_menu.tscn` with background animation, start/settings buttons, and volume sliders (`scripts/ui/settings_control.gd`).
  - UI prefabs: HUD `scenes/common/ui/player_hud.tscn`, pause `scenes/common/ui/pause_menu.tscn`, game over `scenes/common/ui/game_over_ui.tscn`, level end `scenes/common/ui/level_end.tscn`, save/load buttons.
- **Player & Camera:**
  - Player: `scenes/common/player.tscn` (CharacterBody2D) uses `scripts/movement/player.gd` and trajectory preview `scripts/gameplay/trajectory_line_rigidbody.gd`.
  - Camera: Phantom Camera host in worlds; camera trigger targeting via `scripts/camera/camera_trigger_targeter.gd` and area clamps via `scripts/camera/camera_area.gd`; minimap viewport nodes live in each world scene.
- **Worlds/Levels:**
  - World 1: `scenes/worlds/world_1.tscn` includes levels `world_1/level_0.tscn`, `level_1.tscn`, `level_2.tscn` (body goal lives here), minimap, HUD, pause, death zone.
  - World 2: `scenes/worlds/world_2.tscn` includes levels `world_2/level_0.tscn` and `level_1.tscn`, minimap, HUD, pause, death zone, and a `WorldSidecar` helper (`scripts/utilities/world_sidecar.gd`) in addition to `world.gd`.
- **Interactables & Hazards:**
  - Collectibles: `scenes/common/world_interactables/pickup_interactable.tscn` using `scripts/interaction/world_items/key_interactable.gd` for keys/coins/lives.
  - Doors: `scenes/common/world_interactables/door_interactable.tscn` with `scripts/interaction/world_items/door_interactable.gd` and `scripts/gameplay/door.gd`.
  - Checkpoints: `scenes/common/world_obstacles/player_checkpoint.tscn` (`scripts/gameplay/player_checkpoint.gd`).
  - Death: `scenes/common/world_obstacles/death_zone.tscn` (`scripts/gameplay/death_zone.gd`).
  - Moving terrain: `scenes/common/world_obstacles/moving_platform.tscn` (`scripts/gameplay/moving_platform.gd`), `scenes/common/world_obstacles/conveyor.tscn` with constant linear velocity.
  - Dialogue NPC: `scenes/common/world_interactables/tutorial_mouse.tscn` using `scripts/interaction/dialog/speech_interactable.gd`.

## Autoloads & Resources
- **Autoload singletons:** `SoundManager`, `SceneTransitionManager`, `DataManager`, `SaveManager`, `GameManager`, `CameraShakeManager`, `EventBus`, `DialogueManager`, `PhantomCameraManager` (configured in `project.godot`).
- **Data resources:** World refs in `game_resources/world_refs/*.tres`; value references for pause/game over flags in `game_resources/value_refs`; audio paths in `scripts/preloads/data_manager.gd`.

## Notable Flows & Gaps
- **Respawn loop:** `death_zone.gd` → `Player.die()` → `world.gd` respawns at last checkpoint and decrements lives (no manual restart UI).
- **Level end:** `body_goal.tscn` triggers `level_end` event, launching dialogue then `level_end.gd` tally. World 2 currently lacks any body goal placement, preventing progression.
- **Save/Load:** SaveManager (`scripts/utilities/save_manager.gd`) and save/load buttons exist but are not wired into menu/world flow; persistence is unverified.
- **Sidecar usage:** `scripts/utilities/world_sidecar.gd` mirrors `world.gd` behavior and is only instanced in `world_2.tscn`, creating potential duplication/confusion. `GameManager.current_sidecar` is referenced but never set.
