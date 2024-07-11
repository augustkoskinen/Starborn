inventoryopen = false;

grounded = 0;
moving = 0;
jumpvel = 0;
held_space = 0;

movespeed = 0;

SLOPE_ANGLE = 45;
MOVE_SPEED = 100;
RUN_SPEED = 175;
JUMP_SPEED = 350;

image_speed = 0

state = playerstate.walking;

enum playerstate {
	walking,
	running,
	holding,
	attacking
}