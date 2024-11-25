# Changelog

## [1.1.0] - 2024-11-24

### Added

- Added a state machine that handles adding, setting, and getting states, along with performing actions and checking events. [src/server_script_service/state_machine.lua]
- Added an entity factory to return an "entity" with it's own state machine, name, and properties. [src/server_script_service/factories/entity_factory.lua]
- Added an entity manager to store, get and remove entities from an entity list. [src/server_script_service/managers/entity_manager.lua]
- Added a script handle players joining and leaving the game. [src/server_script_service/player_handler.server.lua]

## [1.0.3] - 2024-11-20

### [1.0.3] Fixed

- Updated punctuation within CHANGELOG.md.

## [1.0.2] - 2024-11-20

### [1.0.2] Fixed

- Fixed mispellings inside of CHANGELOG.md.
- Fixed duplicate headings.
- Fixed CHANGELOG.md format.

## [1.0.1] - 2024-11-20

### [1.0.1] Fixed

- Updated README.md to better suit the project.
- Updated CHANGELOG.md to include notation.

## [1.0.0] - 2024-11-20

### [1.0.0] Initial Release

- Project structure set up with Rojo.

## Notation

- MAJOR (*.0.0): Increment for breaking changes.
- MINOR (0.*.0): Increment for new features.
- PATCH (0.0.*): Increment for bug fixes.
