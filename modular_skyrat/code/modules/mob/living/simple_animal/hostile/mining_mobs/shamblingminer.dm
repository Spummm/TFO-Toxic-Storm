//A slow, melee, crazy miner.
/mob/living/simple_animal/hostile/asteroid/miner
	name = "shambling paramedic"
	desc = "Once a Search and Rescue worker, clad in the standard protective armor. The suit broken and their body consumed by the parasite, this paramedic is now doomed to wander, attacking those they once wanted to help."
	icon = 'icons/mob/parasites/infestation_mobs.dmi'
	icon_state = "the_broken"
	icon_living = "the_broken"
	icon_aggro = "the_broken"
	icon_dead = "the_broken_dead"
	icon_gib = "syndicate_gib"
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	mouse_opacity = MOUSE_OPACITY_OPAQUE
	ranged = 0
	friendly_verb_continuous = "hugs"
	friendly_verb_simple = "hug"
	speak_emote = list("moans")
	speed = 1
	move_to_delay = 3
	maxHealth = 400
	health = 400
	obj_damage = 100
	melee_damage_lower = 20
	melee_damage_upper = 20
	attack_verb_continuous = "smashes"
	attack_verb_simple = "smash"
	attack_sound = 'sound/weapons/bladeslice.ogg'
	death_sound = 'sound/parasites/brokensuit_death.ogg'
	throw_message = "barely affects the"
	vision_range = 3
	aggro_vision_range = 7
	move_force = MOVE_FORCE_VERY_STRONG
	move_resist = MOVE_FORCE_VERY_STRONG
	pull_force = MOVE_FORCE_VERY_STRONG
	loot = list()
	crusher_loot = list()
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/slab/human = 2, /obj/item/stack/sheet/animalhide/human = 1, /obj/item/stack/sheet/bone = 1)
	robust_searching = FALSE
	footstep_type = FOOTSTEP_MOB_SHOE
	minimum_distance = 1
	glorymessageshand = list("grabs the miner's eyes and rips them out, shoving the bloody miner aside!", "grabs and crushes the miner's skull apart with their bare hands!", "rips the miner's head clean off with their bare hands!")
	glorymessagespka = list("sticks their PKA into the miner's mouth and shoots it, showering everything in gore!", "bashes the miner's head into their chest with their PKA!", "shoots off both legs of the miner with their PKA!")
	glorymessagespkabayonet = list("slices the imp's head off by the neck with the PKA's bayonet!", "repeatedly stabs the miner in their gut with the PKA's bayonet!")
	glorymessagescrusher = list("chops the miner horizontally in half with their crusher in one swift move!", "chops off the miner's legs with their crusher and kicks their face hard, exploding it while they're in the air!", "slashes each of the miner's arms off by the shoulder with their crusher!")

/mob/living/simple_animal/hostile/asteroid/miner/death(gibbed)
	. = ..()
	if(prob(15))
		new /obj/item/kinetic_crusher(src.loc)
