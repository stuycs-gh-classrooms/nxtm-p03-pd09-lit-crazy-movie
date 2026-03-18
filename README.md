[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/OwTRjgv_)
## Project 00
### NeXTCS
### Period: 9
## Thinker0: Avery Brosnick
## Thinker1: Ruby Vaca
## Thinker2: Joshua Tang
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: Frictional Force

### Custom Force Formula
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

FF = N * FC

N = normal force

FC = frictional constant

### Custom Force Breakdown
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - mass and acceleration

- Does this force require any new constants, if so what are they and what values will you try initially?
  - it requires the frictional constant which will be different for different materials.

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - no

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - it is applied based on the environment

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - yes, we need to calculate normal force.

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

Fixed orb in the center, applying gravity to all other orbs. Possibly spawn orbs to see them orbiting.
--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

Moving orbs with springs connecting them, red when extended, green when not. Maybe have user controlling one of the orbs.

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

Drag force applied on orbs, they will move slower.

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

Split screen with two surfaces, one with lower frictional constant one with higher, show how friction works.

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

Fixed orb exerting gravity on many other orbs connected by springs, drag making them move slower, and an area with friction to also make them slow down until they are pulled by gravity again.

