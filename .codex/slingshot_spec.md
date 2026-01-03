# Slingshot Spec (Observed)

## Controls
- **Aim**: Rotate the skull using `move_left`/`move_right` (A/D). Hold Shift (`fine_tune_left/right`) for quarter-speed rotation (`tilt_speed` 2.0 rad/s default). `move_up` (W) requests rotation reset to 0 via tween (`rotation_correction_speed` 0.2s).
- **Charge/Power**: Fixed `jump_force` (500) in `scripts/movement/player.gd`; no charge curve. Trajectory preview only when grounded and rotation ≠ 0.
- **Release**: `jump` action (Space) fires when grounded, applying velocity `Vector2.UP.rotated(rotation) * jump_force` and setting `is_jumping`.
- **Braking**: Holding `move_down` (S) lerps velocity toward zero each physics frame scaled by `brake_factor` (1.0).

## Physics Behavior
- **Body**: `CharacterBody2D` with manual `move_and_collide` in `_apply_physics`.
- **Gravity**: Adds `ProjectSettings["physics/2d/default_gravity"] * delta` each frame, minus `drag` (default linear damp). No custom gravity toggle.
- **Velocity Dampening**: Brake lerp, plus linear damp scaling each trajectory step; no continuous air drag outside gravity term.
- **Bounciness**: On collision, velocity bounces on normal scaled by `bounciness` (0.5). Colliding `Moveable` bodies receive impulse `-normal * push_force` (100).
- **Floor Detection**: Ground rays in group `ground_casts` set `is_grounded`; moving platforms and TileMap linear velocities flag `on_moving_platform` and adjust `platform_velocity`.
- **Trajectory Preview**: `scripts/gameplay/trajectory_line_rigidbody.gd` simulates up to 100 points using current direction, `jump_force`, gravity, and drag. Raycasts ahead; bounces on static colliders (half velocity). Stops early on moving platforms or moving TileMap tiles.

## Camera & Feedback
- **Camera**: Phantom Camera nodes (e.g., `GoalCam` and player-mounted) handle framing; player spawns with a `PhantomCameraNoiseEmitter2D` to pulse on impacts. No dynamic zoom tied to shot strength.
- **Audio/FX**: Jump uses `SoundManager` with `DataManager.audio_dict["jump"]`; impacts play `"impact"` and trigger `impact_particles` plus camera noise.
- **UI**: Trajectory line visible only while grounded and rotation non-zero; disappears on control lock or while airborne. No explicit power meter.

## Fail/Reset States
- **Death**: `death_zone.tscn` (`scripts/gameplay/death_zone.gd`) calls `Player.die()`, hiding the sprite, playing particles, emitting `EventBus.player_died` after ~2s. World respawns at current checkpoint until lives depleted.
- **Level End**: `body_goal.tscn` (Area2D) triggers `level_end` event via `EventInteractable`, leading to dialogue and `level_end.gd` UI.
- **Stall Cases**: No explicit unstuck timer; braking input slows the skull, and rotation reset can zero trajectory preview.

## Tuning Table
- `jump_force = 500`, `tilt_speed = 2.0`, `brake_factor = 1.0`, `rotation_correction_speed = 0.2`, `bounciness = 0.5`, `push_force = 100` (`scripts/movement/player.gd`).
- Gravity: `ProjectSettings["physics/2d/default_gravity"]` (project default; currently inherited from engine settings).
- Trajectory preview points: 100; bounce damp factor 0.5 (`scripts/gameplay/trajectory_line_rigidbody.gd`).

## Edge Cases
- Rotation reset sets rotation to zero, which also clears trajectory lines; launching with rotation=0 would apply pure upward force, but preview is hidden.
- Because mid-air rotation is allowed, players can adjust facing for upcoming landings without affecting current velocity (no torque applied).
- Bounciness plus sloped collisions can cause repeated ricochets; braking input mitigates but no cap on bounce count.
- Moving platforms detected via TileMap linear velocity; if velocities change mid-flight there is no predictive compensation.

## Known / Unknown
- **Known:** Launch only available while grounded; mid-air control limited to rotation and braking lerp.
- **Unknown:** Exact gravity value in Project Settings; camera follow specifics per level; whether other player variants (`player_v_1/2/3`) will replace the current controller.
