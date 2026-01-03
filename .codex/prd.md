# Product Requirements Document

## Vision
Guide a disembodied skull through side-scrolling stages using rotation-driven launch arcs, snappy retries, and light dark-humor dialogue while searching for its body.

## Pillars
1. **Arc Mastery**: Rotation aim + predictable launch and bounce; readable trajectory line.
2. **Readability & Fairness**: Landing zones and hazards stay on-screen; camera anticipates arcs.
3. **Fast Retries**: Checkpoints and instant restart keep downtime low; no soft-locks.
4. **Tone & Flavor**: Quippy skull dialogue and body-hunt reveals at level ends.

## Audience & Platforms
- PC/Web keyboard focus; controller support nice-to-have.
- Players who enjoy physics momentum platformers (Angry Birds arc feel meets platform obstacles).

## Scope (MoSCoW)
- **Must**: Grounded launch mechanic with trajectory preview; checkpoints/death reset; level-end body goal and dialogue; HUD with keys/lives/coins/timer; pause and basic settings; playable World 1 and World 2 with level-end path.
- **Should**: Restart/unstuck control; camera framing that keeps launch/landing visible; clear feedback for doors/keys; working save/load or clearly disabled.
- **Could**: Gamepad aim, accessibility assists (reduced shake/slow-mo aim), extra collectibles scoring.
- **Won’t**: Mid-air steering that changes velocity; RPG progression.

## UX Requirements
- **Aiming clarity**: Trajectory line matches actual physics; add optional angle snap or reticle for onboarding.
- **Landing visibility**: Camera triggers keep upcoming landing zone on-screen; avoid blind hazards.
- **Feedback**: Audio/FX on launch, impact, pickup, door unlock; dialogue for locked doors and tutorials.
- **Retry speed**: Respawn <2s; manual restart from HUD/pause.

## Content Completeness
- At least one world with a functional body goal (World 1 already has), and World 2 brought to parity (goal placement + dialogue/end UI). Levels should include checkpoints, a mix of moving platforms/conveyors, and at least one door/key loop.

## Acceptance Criteria (Musts)
- Launch + trajectory preview behave consistently across slope/moving surface collisions (`player.gd` and `trajectory_line_rigidbody.gd`).
- Death zones always reset to last checkpoint with life decrement visible in HUD.
- Body goal triggers end dialogue and shows `level_end` UI; continue button loads the next world/level without crash (no reliance on unset `GameManager.current_sidecar`).
- Pause/resume works; settings sliders adjust audio buses; restart option present.
- Web/Windows exports build without missing assets.

## Definition of Done
- P0/P1 items in `.codex/todo.md` closed; no known soft-locks (World 2 goal added; restart available).
- Camera framing validated on all shipped levels; shake/limits tuned or toggleable.
- Save/load either functional (documented) or hidden; known issues tracked in `.codex/known_issues.md`.
