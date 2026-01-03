# Development Journal

## 2025-02-22
- Mapped project entry (`project.godot` → `scenes/menus/main_menu.tscn`) and world flow via `scripts/ui/main_menui_control.gd`.
- Documented player slingshot mechanic from `scripts/movement/player.gd` and trajectory preview in `scripts/gameplay/trajectory_line_rigidbody.gd`.
- Identified level-end loop through `body_goal.tscn` triggering `level_end` event and UI (`level_end.gd`).
- Cataloged exports (Web/Windows configured; Linux placeholder) and hazards/checkpoints in `scenes/common/world_obstacles`.
- Created `.codex` documentation set (map, spec, PRD, design, tech, backlog, release plan, known issues).

**Risks/Unknowns**: Actual gravity value not recorded; SaveManager wiring unclear; camera framing per level unverified; world_2 content needs validation.

**Next Actions**: Measure gravity and sync trajectory preview (TASK-001); playtest world_1 for camera framing and soft-locks (FEAT-004, TASK-004); verify SaveManager flow (TASK-002).

## 2025-03-29
- Reviewed project entry, autoloads, and main menu flow; confirmed main scene launches world selection via `DataManager.world_dict` and `main_menui_control.gd`.
- Indexed worlds/levels: World 1 contains three chunks with body goal only in `level_2`; World 2 has two chunks but no body goal and includes both `world.gd` and `world_sidecar.gd`.
- Documented mechanics: rotation-based grounded launch, trajectory preview simulation, checkpoints/death/life system, doors/keys/pickups, moving platforms/conveyors, dialogue NPCs.
- Identified critical gaps: `GameManager.current_sidecar` never set (null risk for dialogue/level-end), missing World 2 completion path, no restart control, SaveManager not wired, potential double-spawn in World 2.
- Updated `.codex/` docs (map, feature inventory, PRD, slingshot spec, todo, release plan, known issues) to reflect current state and prioritized P0 tasks.

## 2025-05-05
- Implemented `GameManager.current_sidecar` by pointing it at the active `World` and clearing it on exit to stop HUD/timer null refs.
- Guarded dialogue and level-end flows so they pause/resume timers only when a sidecar with a HUD exists; save/load resumes timers safely.
- Marked P0-01 in the backlog as done to reflect the sidecar fix.
