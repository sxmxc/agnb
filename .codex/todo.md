# Backlog

## High Priority Items
- EPIC-001: Ship slingshot-first vertical slice (world_1) with reliable arc feel and level completion loop.

- FEAT-001: Slingshot feel polish
  - Priority: P0 | Effort: M | Risk: Med
  - Acceptance: Aiming rotation, trajectory preview, and applied launch arc match within small error; bounce behaves consistently on slopes; braking stops motion reliably.
  - Touchpoints: `scripts/movement/player.gd`, `scripts/gameplay/trajectory_line_rigidbody.gd`, `project.godot` (input/physics), level TileMaps.
  - Dependencies: None.

- FEAT-002: Fast retry & checkpoints
  - Priority: P0 | Effort: M | Risk: Med
  - Acceptance: Death resets within 2s to last checkpoint; add explicit restart button in HUD/pause; no soft-lock pits without death volume.
  - Touchpoints: `scripts/gameplay/world.gd`, `scenes/common/ui/player_hud.tscn`, `scenes/common/world_obstacles/death_zone.tscn`, checkpoints.
  - Dependencies: FEAT-001 for stable physics.

- FEAT-003: Level-end body reveal loop
  - Priority: P0 | Effort: S | Risk: Low
  - Acceptance: Reaching `body_goal.tscn` triggers dialogue (`not_my_body.dialogue`) and shows `level_end.tscn` with Continue to next world/level.
  - Touchpoints: `scenes/common/world_obstacles/body_goal.tscn`, `scripts/gameplay/world.gd`, `scenes/common/ui/level_end.gd`, dialogue resources.
  - Dependencies: FEAT-002 (checkpoint/death flow) to avoid conflicts.

- FEAT-004: Camera framing & readability
  - Priority: P1 | Effort: M | Risk: Med
  - Acceptance: Camera keeps launch origin and target in view; reduce shake intensity toggle; ensure trajectory line not obscured. Validate on world_1 levels.
  - Touchpoints: `scenes/common/camera/*`, Phantom Camera settings, level camera triggers.
  - Dependencies: FEAT-001.

- FEAT-005: Accessibility & settings basics
  - Priority: P1 | Effort: M | Risk: Low
  - Acceptance: Audio volume toggle/sliders wired to SoundManager; optional screen shake toggle; document keybindings; placeholder for controller support.
  - Touchpoints: `scripts/ui/settings_control.gd`, `game_resources/settings/default.tres`, camera noise emitters.
  - Dependencies: FEAT-004 (shake control) optional.

- FEAT-006: Export readiness
  - Priority: P1 | Effort: S | Risk: Med
  - Acceptance: Web and Windows exports build without missing assets; Linux preset path set; version info updated.
  - Touchpoints: `export_presets.cfg`, `project.godot`, build pipeline docs.
  - Dependencies: Stabilized features.

## Supporting Tasks
- TASK-001: Verify gravity value and align trajectory preview with runtime gravity.
  - Priority: P0 | Effort: S | Risk: Med
  - Acceptance: Document actual gravity in `slingshot_spec.md`; adjust preview math if needed.
  - Dependencies: FEAT-001.

- TASK-002: Audit SaveManager wiring
  - Priority: P1 | Effort: S | Risk: Med
  - Acceptance: Determine whether saves/settings persist; document or disable nonfunctional UI elements.
  - Dependencies: None.

- TASK-003: Level content review
  - Priority: P1 | Effort: M | Risk: Med
  - Acceptance: List hazards/checkpoints/body goal placement per level; ensure no blind hazards; update `design.md` with findings.
  - Dependencies: FEAT-004.

- TASK-004: Soft-lock prevention
  - Priority: P0 | Effort: M | Risk: Med
  - Acceptance: Add fail volumes or unstuck timer where bounce traps exist; braking should allow recovery. Document locations fixed.
  - Dependencies: FEAT-002.

## Bugs / Issues
- BUG-001: Rotation reset tied to `move_up` instead of dedicated `reset_rotation` action
  - Priority: P1 | Effort: S | Risk: Low
  - Acceptance: Update input mapping and UI hints; ensure trajectory preview handles reset cleanly.
  - Touchpoints: `scripts/movement/player.gd`, `project.godot` input map.

## Chores
- CHORE-001: Update documentation after each feature change (journal/todo/specs).
  - Priority: P1 | Effort: S | Risk: Low
  - Acceptance: `.codex/` files reflect latest implementation and decisions.

