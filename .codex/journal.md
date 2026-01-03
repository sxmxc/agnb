# Development Journal

## 2025-02-22
- Mapped project entry (`project.godot` → `scenes/menus/main_menu.tscn`) and world flow via `scripts/ui/main_menui_control.gd`.
- Documented player slingshot mechanic from `scripts/movement/player.gd` and trajectory preview in `scripts/gameplay/trajectory_line_rigidbody.gd`.
- Identified level-end loop through `body_goal.tscn` triggering `level_end` event and UI (`level_end.gd`).
- Cataloged exports (Web/Windows configured; Linux placeholder) and hazards/checkpoints in `scenes/common/world_obstacles`.
- Created `.codex` documentation set (map, spec, PRD, design, tech, backlog, release plan, known issues).

**Risks/Unknowns**: Actual gravity value not recorded; SaveManager wiring unclear; camera framing per level unverified; world_2 content needs validation.

**Next Actions**: Measure gravity and sync trajectory preview (TASK-001); playtest world_1 for camera framing and soft-locks (FEAT-004, TASK-004); verify SaveManager flow (TASK-002).
