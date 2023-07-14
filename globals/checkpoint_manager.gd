extends Node

## This is a global object that handles checkpoints. When we load or save a checkpoint,
## there are data that need to get saved across several different things in the scene tree.
## Doing this by getting children etc. would be hell, so we make this a global script that
## anything anywhere can subscribe to.

## This signal is emitted when a checkpoint is activated by a player.
signal checkpoint_activated

## This signal is emitted when the player wants to revert to the last checkpoint.
signal load_checkpoint
