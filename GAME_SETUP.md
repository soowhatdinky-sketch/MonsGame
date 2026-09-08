# Quick start and notes for the Godot project

This repository contains assets and Godot scenes for "MonsGame". I added a minimal playable entry so you can walk through the capital ship and interiors that are already present in the repository.

What I added
- project.godot — minimal Godot project file, sets Main.tscn as the startup scene.
- Main.tscn — a 3D root scene that instances MassiveShip.tscn and ShipInterior.tscn and the Player scene.
- Player.tscn — KinematicBody player with Camera and Capsule collision.
- player.gd — simple first-person controller using raw key inputs (WASD) and mouse look.

How to run
1. Install Godot 3.x (3.2 - 3.5 recommended).
2. Open the project folder in Godot (the folder containing project.godot).
3. Press Play (F5). The Main scene will load and you can move using W/A/S/D and look with the mouse. Press Escape to release the mouse.

Notes and next steps
- I instanced the existing MassiveShip.tscn and ShipInterior.tscn from the repo as placeholders for the capital-class ship and interiors. You can replace or refine those scenes with the OBJ/MTL assets and the many tscn pieces present in the repo.
- If you want proper nav/collision with interiors, open the ShipInterior.tscn and ensure static bodies/meshes have CollisionShapes.
- The input uses raw key checks to avoid requiring editor InputMap edits. If you prefer to use InputMap actions, add them in Project Settings > Input Map and update player.gd accordingly.

If you'd like, next I can:
- Import the provided OBJ/MTL pair (I have obj.mtl content) and create a proper MeshInstance with materials extracted from the MTL.
- Build a walkable corridor layout by instancing the corridor tscn pieces (Light_Corridor_01.tscn, Wall_Console_01_Large.tscn, etc.) and ensuring collisions.
- Add a simple skybox/world with starfield and a planet you can fly to or dock with.

Tell me which of those you want next and I'll add it.
