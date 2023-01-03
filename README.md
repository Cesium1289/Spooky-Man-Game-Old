# Spooky-Man-Game

## What is this project?
This project is a game called Spooky Man that is inspired by the original Slender Man game created using the Unity game engine. The goal of Spooky Man is to find 8 pages that are scattered around points of interest in a dark errie forest. While the player tries to gather all 8 pages, Spooky Man will attempt to stop the player and they must hit him with throwable objects or outrun him to stop his relentless pursuit. The player wins the game when they successfully gather all 8 pages and avoid getting caught by Spooky Man.


# How does the Spooky Man ai work?
Spooky Man ai is composed of 6 different states: respawn, stalk, watch, chase, flee, and attack.

## Respawn
- Spooky Man will spawn around the player. Not too close, but not too far.

## Stalk
- When Spooky Man is not close to the player, he will stalk them and try to get to their position.
- If Spooky Man gets close to the player, he will enter into his chase state.
- When Spooky Man is looked at by the player from afar, he will stop and enter into his watch state.

## Watch
- Spooky Man will stop and stare at the player. 
- If the player looks at him for too long or gets too close, he will change to his chase state.
- Looking away will cause him to enter his stalk state.

## Chase
- When the player gets close to Spooky Man, he will purpuse the player at a greater speed in an attempt to catch them.
- If the player manages to out run his pursuit time, he will enter into his respawn state.
- If the player is looking at Spooky Man when his pursuit timer expires, he will enter his flee state.
- If Spooky Man gets close to the player, this is when he will enter his attack state.

## Flee
 - Spooky Man runs away back to the last point he spawned.
 - Spooky Man will enter into the respawn state when he reaches the point he spawned or when the runback timer expires.
 - Throwing objects at The Spooky Man will cause him to flee.
 
 ## Attack
 - When the player gets too close to Spooky Man, this is when he attacks. After attacking the player, the scene will be reset and the player will lose all page progress and will need to recollect any pages they got.

