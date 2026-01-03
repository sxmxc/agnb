# Release Plan

## Milestones
1. **Stabilization (P0)**: Fix sidecar null usage, add World 2 body goal, add restart/unstick, align trajectory preview with physics, and audit World 2 spawn flow/doors. Smoke World 1/2 end-to-end.
2. **Readability & Persistence (P1)**: Camera readability pass with shake toggle, Save/Load decision, HUD/tutorial clarity, level content QA sweep.
3. **Export & Beta**: Verify Web/Windows exports; resolve remaining P1 bugs; performance sanity (60fps) on world scenes.
4. **RC**: Full playthrough across worlds with checkpoints, doors, and dialogue; zero P0/P1; store assets/text ready if shipping externally.
5. **Release**: Publish builds; document known issues; open hotfix window for crash/soft-lock fixes.

## Bug Bar & Performance Targets
- No P0/P1 open; no crashes on menu start, spawn, checkpoint respawn, or level-end UI.
- 60 FPS target on PC/Web in world scenes; web load <5s for main menu.
- No soft-locks (World 2 has goal; restart always available).

## QA Matrix (Smoke)
- Boot main menu → start World 1 → reach checkpoint → die and respawn with HUD updates.
- Aim/launch over moving platforms and conveyors; verify trajectory preview vs outcome on flat/sloped tiles.
- Open locked door with and without keys; HUD counts update; error dialogue plays when lacking keys.
- Trigger body goal (World 1 & World 2) → end dialogue → level-end UI → Continue to next world/level.
- Pause/resume and restart; settings sliders adjust audio; shake toggle works if added.
- Save/load path (if enabled) restores position/resources; otherwise buttons hidden/disabled gracefully.
- Web/Windows exports boot and accept input.

## Store/Packaging Assumptions
- Assets: existing skull/body art and UI ok for prototype; screenshots/trailer TBD if releasing publicly.
- Platform text: include control scheme, restart/checkpoint info, and accessibility toggles (shake/volume) if enabled.

## Known / Unknown
- **Known:** World 2 lacks body goal today; sidecar pointer unset; SaveManager wiring unclear.
- **Unknown:** Final export targets beyond Web/Windows; controller support scope; analytics/telemetry approach.
