# Product Requirements Document

## Vision
Guide a disembodied skull through side-scrolling stages using only slingshot arcs. Each stage ends with a false “body” reveal, pushing the darkly comic search forward.

## Pillars
1. **Slingshot Mastery**: Aiming, arc prediction, and bounce control are the core verbs.
2. **Readability & Fairness**: Clear landing zones, minimal blind leaps, consistent physics.
3. **Fast Retries**: Immediate respawn/checkpoint, minimal downtime.
4. **Tone**: Dark humor/absurdity; light dialogue between stages.

## Target Audience & Platforms
- Audience: Fans of physics-momentum platformers (e.g., Angry Birds trajectory meets platforming).
- Platforms (assumed): PC (Windows/Linux) and Web export; controller support optional. Marked assumption until validated.

## Scope (MoSCoW)
- **Must**: Slingshot-only traversal (rotation aim + space to launch), trajectory preview, checkpoints/death reset, level-end body reveal with dialogue, functional HUD/pause, exports for Web/Windows.
- **Should**: Camera framing that keeps arc and landing visible; consistent bounce surfaces; quick restart option; simple settings (audio toggle, volume).
- **Could**: Gamepad aim/launch, accessibility assists (slow-mo aim, colorblind-safe hazards), optional collectibles scoring.
- **Won’t (for now)**: Mid-air steering that alters velocity, RPG-style progression, complex inventory.

## UX Requirements
- Aiming clarity: trajectory line visible when grounded and aimed; consider angle snapping for onboarding.
- Landing visibility: camera keeps destination area on screen; avoid off-screen hazards.
- Feedback: audio/FX on launch, impact, and death; quick fade/restart.
- Time-to-retry: respawn in <2s; button/menu option to restart level.

## Difficulty Philosophy
- Skill comes from learning arc timing and bounce behavior. Early levels teach safe angles; later stages add moving platforms, conveyors, and ricochet challenges.
- Tuning knobs: `jump_force`, `tilt_speed`, `brake_factor`, `bounciness`, gravity, hazard spacing, checkpoint density.

## Accessibility
- Visual clarity: high-contrast landing zones; limit screen shake (Phantom Camera noise) or provide toggle.
- Input: allow remapping; deadzone/aim-sensitivity tuning for controllers if added.
- Comfort: option to reduce motion blur/shake; provide color-safe hazard indicators.

## Acceptance Criteria (Musts)
- Player can aim/launch with current controls; trajectory preview matches applied arc within tolerance.
- Death zones reset player at last checkpoint; lives decrement displayed.
- Body goal triggers end dialogue and transitions to level-end UI with continue option.
- Exports build on Web and Windows without missing dependencies.

## Release Criteria / DoD
- All P0/P1 items in `todo.md` closed; no known crash-on-boot; level-end loop works across all shipped levels.
- Stable FPS on target hardware (60fps on PC/Web in test scenes); no soft-locks without recovery.
- Basic accessibility options present or explicitly deferred with TODO.
