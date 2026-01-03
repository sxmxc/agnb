# Repository Map

## Start Here
- **Main entry:** `project.godot` → `run/main_scene` points to `scenes/menus/main_menu.tscn`.
- **Gameplay flow:** `scenes/menus/main_menu.tscn` (script `scripts/ui/main_menui_control.gd`) loads world scenes from `game_resources/world_refs` (e.g., `world_1.tres`) into `scenes/worlds/world_1.tscn`, which hosts level chunks and the player.
- **Player:** `scenes/common/player.tscn` (script `scripts/movement/player.gd`) is spawned by `scripts/gameplay/world.gd`.

## Scenes and Scripts
- **Menus:** `scenes/menus/main_menu.tscn` (UI flow in `scripts/ui/main_menui_control.gd`), background motion via `scripts/ui/skull_launcher.gd`, settings control `scripts/ui/settings_control.gd`.
- **Worlds:** `scenes/worlds/world_1.tscn`, `world_2.tscn` use `scripts/gameplay/world.gd` to manage player spawn, HUD, dialogue, checkpoints, and level-end events.
- **Levels:** Level chunks under `scenes/worlds/world_1/level_*.tscn` and `world_2/level_*.tscn` share `scripts/gameplay/level.gd` (sets size, camera trigger setup). Body goal example in `world_1/level_2.tscn` instancing `scenes/common/world_obstacles/body_goal.tscn`.
- **Player Control:** `scripts/movement/player.gd` (CharacterBody2D). Trajectory preview `scripts/gameplay/trajectory_line_rigidbody.gd`. Variants `player_v_1.gd`, `player_v_2.gd`, `player_v_3.gd`, and `rigid_body_character.gd` exist but are unused by the current world spawner.
- **Camera:** Phantom Camera plugin. Goal camera scene `scenes/common/camera/goal_cam.tscn` with `scenes/common/camera/goal_cam.gd`; triggers via `scenes/common/camera/2d_camera_trigger.gd` and `camera_trigger_targeter.gd`.
- **UI:** HUD `scenes/common/ui/player_hud.tscn`, level end `scenes/common/ui/level_end.tscn` (`level_end.gd`), pause `scenes/common/ui/pause_menu.tscn`, load button `scenes/common/ui/load_button.tscn`.
- **Autoloads:** Defined in `project.godot`: `SoundManager`, `SceneTransitionManager`, `DataManager`, `SaveManager`, `GameManager`, `CameraShakeManager`, `EventBus`, `DialogueManager`, `PhantomCameraManager`.
- **Dialogue:** Resources under `dialogue/`, panel `dialogue/balloons/dialogue_panel.tscn` used in world intro/end.
- **Obstacles & Hazards:** `scenes/common/world_obstacles` includes `death_zone.tscn` (`scripts/gameplay/death_zone.gd`), `moving_platform.tscn`, `conveyor.tscn`, `body_goal.tscn` (level completion trigger), `player_checkpoint.tscn`.

## Assets
- **Art:** Pixel art in `assets/aseprite/` (e.g., skull, background, body sprite) and `sprites/`.
- **Audio:** Music and SFX under `assets/audio/`; configured via `scripts/preloads/data_manager.gd`.
- **Shaders:** Post-processing and utility shaders under `shaders/` and `scenes/post_processing`.

## Known / Unknown
- **Known:** Main scene path, player controller location, level-end is tied to `body_goal.tscn` emitting `level_end` event.
- **Unknown:** Exact tile layouts per level (TileMap data), camera tuning per level, completeness of world_2 flow and whether additional cutscenes exist. Validate during playtests.
