# Known Issues

- BUG-001: Rotation reset uses `move_up` input instead of dedicated `reset_rotation`; may conflict with upward aiming expectations. Re-map and update UI.
- ISSUE-001: SaveManager autoload present but not confirmed in menu/world flows; risk of nonfunctional save/load.
- ISSUE-002: Linux export preset lacks path/output configuration in `export_presets.cfg`.
- ISSUE-003: Trajectory gravity value not explicitly documented; potential mismatch with runtime gravity if settings change.
- ISSUE-004: Camera framing per level unverified; possible off-screen landings or excessive shake.
