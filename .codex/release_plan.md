# Release Plan

## Milestones
1. **Prototype Stabilization (P0)**: Polish slingshot feel (FEAT-001), fast retry loop (FEAT-002), level-end loop (FEAT-003).
2. **Content Complete (P1)**: Camera/readability (FEAT-004), settings/accessibility (FEAT-005), level content review (TASK-003), soft-lock fixes (TASK-004).
3. **Beta**: Export readiness (FEAT-006); integrate save/settings decisions (TASK-002); performance profiling on target platforms.
4. **RC**: Full playthrough of all worlds; bug triage to BUG/CHORE list; finalize store assets (capsule/screenshot/trailer tasks TBD).
5. **Release**: Ship Web and Windows builds; post-launch hotfix window for crash/soft-lock fixes.

## Bug Bar & Performance Targets
- No P0/P1 open issues; no crashes on boot/start/level transition.
- 60 FPS target on PC/Web in world_1 scenes; load times <5s on Web.
- No known soft-locks; death/reset always available.

## QA Matrix (Smoke)
- Boot main menu, start world_1, reach checkpoint, die and respawn.
- Launch arcs across conveyors/moving platforms; trajectory preview matches outcome.
- Reach body goal, play dialogue, view level-end UI, continue to next level/world.
- Pause/resume and settings adjustments do not break audio/state.
- Exports (Web/Windows/Linux) launch and input works (keyboard at minimum).

## Store Requirements (Assumed Steam-ready)
- Capsule art (portrait & landscape), 5+ screenshots, short trailer showing slingshot + body reveal loop.
- Text: description, feature bullets, controls, accessibility notes.

## Post-Launch
- Week 1 hotfix scope: crash fixes, soft-lock fixes, major camera/readability adjustments based on feedback.
- Collect telemetry manually via feedback form until analytics strategy decided (assumption).

## Known / Unknown
- **Known:** Export presets exist for Web/Windows; Linux preset missing path; dialogues in place for intro/end.
- **Unknown:** Final store platform(s); telemetry/analytics approach; controller support guarantees.
