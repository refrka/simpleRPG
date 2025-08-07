extends Node

enum TravelDir {
	WEST,
	NORTH,
	EAST,
	SOUTH
}

enum Events {
	NONE,
	COMBAT,
	NPC,
	TREASURE,
	OBSTACLE
}

enum Enemies {
    RAT,
    WOLF,
    BANDIT,
}

enum Items {
	NONE,
    BOOK_CAST_FIRE,
    BUFF_ATK,
    POTION_HEAL,
	FOOD_FRUIT,
	FOOD_NUTS,
}

enum ItemType {
    BOOK,
    BUFF,
    POTION,
	FOOD,
	NONE,
}

enum Scenes {
    NONE,
    HOME,
    EXPLORE,
    CRAFT,
    COMBAT,
	COMBAT_REWARDS,
	FORAGE,
	TRAVEL,
	WAIT
}

enum Weapons {
    BOW,
    SPEAR,
    SWORD,
}

enum WeaponType {
    RANGED,
    MELEE
}