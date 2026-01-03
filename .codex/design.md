# Design Notes

## Core Loop
- Launch the skull toward the level exit using slingshot arcs; manage rebounds and conveyors/moving platforms.
- On reaching the “body” (`body_goal.tscn`), play end dialogue (“not my body”) and continue to the next level/world via `level_end.gd`.

## Stage Loop
1. Spawn at current checkpoint (`player_checkpoint.tscn`) in a world scene.
2. Aim/launch, traverse hazards and platforms.
3. Hit death zones to respawn; reach body goal to trigger dialogue and score UI.
4. Transition to next world or repeat loop.

## Level Design Principles
- Keep landing zones visible; avoid blind off-screen arcs. Use camera triggers to frame targets.
- Teach angles: early ramps with clear surfaces; later add conveyors/moving platforms to influence bounce.
- Provide recovery: frequent checkpoints, brake-friendly safe zones, death floors instead of soft-lock pits.
- Surfaces should telegraph bounce vs. stickiness; align TileMap normals to avoid unfair ricochets.

## Narrative Structure
- Episodic searches for the right body; each stage ends with the reveal it’s wrong.
- Dialogue resources (`dialogue/intro.dialogue`, `not_my_body.dialogue`) deliver flavor between levels. Expand with escalating absurdity.

## Enemies/Hazards
- Present: death zones, conveyors, moving platforms, pistons/obstacles (see `scenes/common/world_obstacles`).
- Philosophy: hazards should be telegraphed; avoid instant off-screen hits. Use sound cues and consistent visuals.

## Economy/Progression
- Currently none beyond coins/lives counters in HUD; no permanent meta-progression. Keep scores as optional flair unless expanded later.

## Known / Unknown
- **Known:** Body goal triggers event; checkpoints set respawn; level timer tracked in HUD.
- **Unknown:** Final world count and unique mechanics for world_2; narrative beats beyond existing dialogue files.
