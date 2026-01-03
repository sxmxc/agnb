# Slingshot Spec (Observed)

## Controls & Inputs
- **Aim**: Hold `move_left` / `move_right` (A/D) to rotate the skull. Holding Shift (`fine_tune_left/right`) quarter-speeds rotation for precision. `move_up` currently triggers rotation reset to 0 via tween (`rotation_correction_speed` 0.2s).
- **Launch**: `jump` (Space) fires only while grounded, applying velocity `Vector2.UP.rotated(rotation) * jump_force` and marking `is_jumping`.
- **Braking**: Holding `move_down` (S) lerps velocity toward zero each physics frame scaled by `brake_factor` (1.0).
- **Interaction**: `use` (E) drives Interactor nodes for doors, pickups, and dialogue.

## Physics Behavior
- **Body**: `CharacterBody2D` with manual `move_and_collide` step in `_apply_physics` (`scripts/movement/player.gd`).
- **Forces**: `jump_force = 500`; gravity pulls by `ProjectSettings["physics/2d/default_gravity"]` (default 980) minus `drag` (project linear damp). No charge curve.
- **Bounces**: Collisions bounce velocity by `bounciness = 0.5`; `Moveable` bodies receive impulse `-normal * push_force` (100). Braking lerp is the only in-air dampener.
- **Grounding**: Ray casts in group `ground_casts` detect floor/animated bodies and moving TileMap conveyor velocities. Launch is blocked if not grounded.
- **Rotation reset**: Tween drives rotation back to zero on `move_up`; no dedicated reset action or snap angles.

## Trajectory Preview
- **When shown**: Only while grounded, rotation ≠ 0, and control is not locked. Clears when airborne or control-locked.
- **Simulation**: `scripts/gameplay/trajectory_line_rigidbody.gd` simulates up to 100 points using current direction, `jump_force`, gravity, and drag. Raycasts ahead, bouncing with 0.5 damp and stopping on moving platforms/moving TileMap tiles.
- **Display**: Line2D with scrolling texture in `scenes/common/player.tscn`; no power meter or aim reticle.

## Camera & Feedback
- **Camera**: Phantom Camera host in worlds with optional camera triggers; impact events pulse `PhantomCameraNoiseEmitter2D` on the player.
- **Audio/FX**: Jump uses `DataManager.audio_dict["jump"]`; impacts play `"impact"` and trigger `ImpactParticles` plus camera noise. Death hides sprite and plays `DeathParticles`.
- **HUD**: No trajectory numeric hints; HUD focuses on keys/lives/coins/timer.

## Fail/Reset Flow
- **Death**: `death_zone.tscn` calls `Player.die()`, delays ~2s, then emits `player_died`. `world.gd` respawns at last checkpoint and decrements lives; if lives hit 0 it emits `game_over` (game-over UI present in scene).
- **Checkpoints**: `player_checkpoint.gd` emits `checkpoint_reached` when an Interactor touches; world stores `current_checkpoint` for respawn.
- **Unstuck**: No explicit restart or self-destruct input; braking and rotation reset are the only recovery tools.

## Known / Unknown
- **Known**: Launch locked to grounded state; no mid-air steering beyond rotation/brake; rotation reset bound to `move_up`; trajectory uses project gravity and drag.
- **Unknown**: Exact gravity if project settings change; whether alternative player scripts (`player_v_1/2/3.gd`, `rigid_body_character.gd`) will replace the current controller; camera zoom/framing tuning per level.
