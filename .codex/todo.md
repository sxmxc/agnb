# Backlog

## P0 — Ship Blockers
- **P0-01: Fix sidecar null usage**  
  - Acceptance: `GameManager.current_sidecar` is set (or references removed) so `level_end.gd` and `speech_interactable.gd` no longer crash when accessing HUD/timer.  
  - Touchpoints: `scripts/gameplay/world.gd` or `scripts/utilities/world_sidecar.gd`, `scenes/common/ui/level_end.gd`, `scripts/interaction/dialog/speech_interactable.gd`.
- **P0-02: Add level-end goal to World 2**  
  - Acceptance: A body goal exists in World 2, triggers `level_end` dialogue/UI, and Continue advances without errors.  
  - Touchpoints: `scenes/worlds/world_2/level_*.tscn`, `scenes/common/world_obstacles/body_goal.tscn`, dialogues.
- **P0-03: Restart/unstuck control**  
  - Acceptance: HUD or pause menu exposes Restart that respawns at last checkpoint within 2s; death zones remain as fallback.  
  - Touchpoints: `scenes/common/ui/player_hud.tscn`, `scenes/common/ui/pause_menu.tscn`, `scripts/gameplay/world.gd`.
- **P0-04: Trajectory/physics validation**  
  - Acceptance: Trajectory preview matches actual flight on flat, sloped, and moving platforms (within small tolerance); document gravity value in spec; adjust math if needed.  
  - Touchpoints: `scripts/movement/player.gd`, `scripts/gameplay/trajectory_line_rigidbody.gd`, `project.godot` gravity settings.
- **P0-05: World 2 flow audit**  
  - Acceptance: Confirm World 2 does not double-spawn player via `world.gd` + `world_sidecar.gd`; choose one flow and remove redundancy. Player spawns once with HUD active.  
  - Touchpoints: `scenes/worlds/world_2.tscn`, `scripts/gameplay/world.gd`, `scripts/utilities/world_sidecar.gd`.
- **P0-06: Locked door readability**  
  - Acceptance: Locked doors clearly indicate required keys (HUD prompt or indicator); spending key reliably opens door and updates HUD.  
  - Touchpoints: `scripts/interaction/world_items/door_interactable.gd`, HUD messaging.

## P1 — Polish & Quality
- **P1-01: Camera readability pass**  
  - Acceptance: Camera triggers/limits keep launch origin and landing in frame; shake intensity clamped or toggle added in settings.  
  - Touchpoints: `scripts/camera/camera_trigger_targeter.gd`, `scripts/camera/camera_area.gd`, Phantom Camera settings, `scripts/ui/settings_control.gd` for toggle.
- **P1-02: Save/Load decision**  
  - Acceptance: Save/load buttons either wired to `SaveManager` and tested (keys/coins/progress restored) or hidden/disabled with tooltip.  
  - Touchpoints: `scripts/utilities/save_manager.gd`, menu scenes, HUD if persistence enabled.
- **P1-03: HUD clarity & onboarding**  
  - Acceptance: Display level name/world in HUD, optional angle/force hint, and tutorial text for trajectory/brake controls.  
  - Touchpoints: `scenes/common/ui/player_hud.tscn`, tutorial dialogue resources.
- **P1-04: Content QA sweep**  
  - Acceptance: Each shipped level lists checkpoints, hazards, and interactables; no blind spikes/pits; conveyors/moving platforms signposted.  
  - Touchpoints: `scenes/worlds/world_*/level_*.tscn`, `design.md`.

## P2 — Nice-to-haves
- **P2-01: Gamepad support**  
  - Acceptance: Gamepad aims/launches with sensitivity tuning; UI navigation confirmed.  
  - Touchpoints: `project.godot` input map, `scripts/movement/player.gd`, menu controls.
- **P2-02: Juice & feedback**  
  - Acceptance: Add landing/launch screen shake toggle, extra particles, and audio variety without impacting readability.  
  - Touchpoints: `scripts/movement/player.gd`, `game_resources/audio`, camera shake settings.

## Immediate Next 10 Tasks
1. P0-01 Fix sidecar null usage.  
2. P0-02 Add level-end goal to World 2.  
3. P0-03 Add restart/unstuck control in HUD/pause.  
4. P0-04 Validate trajectory vs physics and document gravity.  
5. P0-05 Audit World 2 spawn flow (`world.gd` vs `world_sidecar.gd`).  
6. P0-06 Improve locked door feedback and HUD key usage.  
7. P1-01 Tweak camera triggers/limits and add shake toggle.  
8. P1-02 Decide and wire/hide Save/Load.  
9. P1-03 Improve HUD/tutorial onboarding for aim/brake.  
10. P1-04 Run level content QA pass for fairness/soft-locks.
