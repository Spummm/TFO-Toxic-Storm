/mob/living/simple_animal/pet/roro
	name = "Roro"
	desc = "Its a Rorobot, strange meshes of biotechnology and robotics engineering."
	icon = 'modular_skyrat/icons/mob/roro.dmi'
	gender = PLURAL
	mob_biotypes = MOB_ROBOTIC
	blood_volume = 0
	icon_living = "roro"
	icon_dead = "roro-dead"
	speak_emote = list("beeps")
	emote_hear = list("beeps happily.","lets out a cute chime.","boops and bloops.")
	emote_see = list("bops up and down.","looks around.","spins slowly.")
	turns_per_move = 10
	response_help = "pets"
	response_disarm = "moves aside"
	response_harm = "squishes"
	attacktext = "bites"
	attack_sound = 'sound/weapons/bite.ogg'
	pass_flags = PASSMOB
	ventcrawler = VENTCRAWLER_ALWAYS
	verb_say = "beeps"
	verb_ask = "beeps inquisitively"
	verb_exclaim = "buzzes"
	verb_yell = "loud-speaks"
	initial_language_holder = /datum/language_holder/synthetic
	bubble_icon = "machine"
	speech_span = SPAN_ROBOT
	deathmessage = "suddenly grows still, their eyes falling dark as their form deflates..."
	gold_core_spawnable = FRIENDLY_SPAWN

/mob/living/simple_animal/pet/roro/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/wuv, "beeps happily!", EMOTE_AUDIBLE, /datum/mood_event/pet_animal, "buzzes!", EMOTE_AUDIBLE)

/mob/living/simple_animal/pet/roro/proc/emp_act()
	playsound(src.loc, 'modular_skyrat/sound/voice/roro_rogue.ogg', 60, 1, 10)

/mob/living/simple_animal/pet/roro/roboticsroro
	name = "Roomba"
	desc = "Its Roomba! A lovable pet Rorobot from Robotics."
	gender = FEMALE
	icon_living = "roro-robotics"
	icon_dead = "roro-dead"
	gold_core_spawnable = NO_SPAWN
