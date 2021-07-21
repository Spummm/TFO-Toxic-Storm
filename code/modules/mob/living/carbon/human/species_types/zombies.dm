#define REGENERATION_DELAY 60  // After taking damage, how long it takes for automatic regeneration to begin

/datum/species/zombie
	// 1spooky
	name = "High-Functioning Zombie"
	id = "zombie"
	say_mod = "moans"
	sexes = 0
	blacklisted = 1
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	species_traits = list(NOBLOOD,NOZOMBIE,NOTRANSSTING,CAN_SCAR,HAS_SKIN,HAS_FLESH,HAS_BONE)
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_FAKEDEATH)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	mutanttongue = /obj/item/organ/tongue/zombie
	var/static/list/spooks = list('sound/hallucinations/growl1.ogg','sound/hallucinations/growl2.ogg','sound/hallucinations/growl3.ogg','sound/hallucinations/veryfar_noise.ogg','sound/hallucinations/wail.ogg')
	disliked_food = NONE
	liked_food = GROSS | MEAT | RAW
	//Skyrat change - blood
	bloodtypes = list("A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-")
	exotic_bloodtype = "BHZ"
	exotic_blood_color = BLOOD_COLOR_BIOHAZARD
	//

/datum/species/zombie/notspaceproof
	id = "notspaceproofzombie"
	limbs_id = "zombie"
	blacklisted = 0
	inherent_traits = list(TRAIT_RESISTCOLD,TRAIT_RADIMMUNE,TRAIT_EASYDISMEMBER,TRAIT_LIMBATTACHMENT,TRAIT_NOBREATH,TRAIT_NODEATH,TRAIT_FAKEDEATH)

/datum/species/zombie/notspaceproof/check_roundstart_eligible()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		return TRUE
	return ..()

/datum/species/zombie/infectious
	name = "Infected Human"
	id = "memezombies"
	limbs_id = "zombie"
	icon_limbs = 'icons/mob/parasites/zombie_parts.dmi'
	exotic_blood = /datum/reagent/romerol
	mutanthands = /obj/item/zombie_hand
	armor = 20 // 120 damage to KO a zombie, which kills it
	//speedmod = 1.6      SKYRAT CHANGE - Fast Zombies
	inherent_traits = list(TRAIT_NOLIMBDISABLE,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE,TRAIT_UNINTELLIGIBLE_SPEECH)
	mutanteyes = /obj/item/organ/eyes/night_vision/zombie
	var/heal_rate = 1
	var/regen_cooldown = 0

//PRIMITIVE MUTATIONS
//After a certain point, Infected Humans can evolve into one of three mutation pathways. There are two stages to these pathways, PRIMITIVE and ADVANCED.
//Fleshbeasts are bruisers that focus on hitting hard while being slow, Ghouls are quick but weaker, and Wombs focus mainly on spreading infestation through indirect means such as projectiles.
/datum/species/zombie/infectious/brusier
	name = "Primitive Fleshbeast"
	id = "primbeast"
	limbs_id = "fleshbeast"
	mutanthands = /obj/item/zombie_hand/fleshbeast
	armor = 0
	speedmod = 1.6
	inherent_traits = list(TRAIT_NOLIMBDISABLE,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE,TRAIT_NODEATH,TRAIT_RADIMMUNE,TRAIT_RESISTHIGHPRESSURE,TRAIT_RESISTLOWPRESSURE,TRAIT_UNINTELLIGIBLE_SPEECH)

/datum/species/zombie/infectious/ghoul
	name = "Primitive Ghoul"
	id = "primghoul"
	limbs_id = "ghoul"
	armor = 10
	speedmod = 0.95
	inherent_traits = list(TRAIT_NOLIMBDISABLE,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE,TRAIT_NODEATH,TRAIT_RADIMMUNE,TRAIT_UNINTELLIGIBLE_SPEECH,TRAIT_FREESPRINT,TRAIT_EASYDISMEMBER)

/datum/species/zombie/infectious/womb
	name = "Primitive Womb"
	id = "primwomb"
	limbs_id = "womb"
	armor = 15
	inherent_traits = list(TRAIT_NOLIMBDISABLE,TRAIT_TASED_RESISTANCE,TRAIT_STUNIMMUNE,TRAIT_NODEATH,TRAIT_RADIMMUNE,TRAIT_UNINTELLIGIBLE_SPEECH)

/datum/species/zombie/infectious/check_roundstart_eligible()
	return FALSE


/datum/species/zombie/infectious/spec_stun(mob/living/carbon/human/H,amount)
	. = min(20, amount)

/datum/species/zombie/infectious/apply_damage(damage = 0,damagetype = BRUTE, def_zone = null, blocked = FALSE, forced = FALSE, spread_damage = FALSE, wound_bonus = 0, bare_wound_bonus = 0, sharpness = SHARP_NONE) //skyrat edit
	. = ..()
	if(.)
		regen_cooldown = world.time + REGENERATION_DELAY

/datum/species/zombie/infectious/spec_life(mob/living/carbon/C)
	. = ..()
	C.a_intent = INTENT_HARM // THE SUFFERING MUST FLOW

	//Zombies never actually die, they just fall down until they regenerate enough to rise back up.    <---------- THIS IS OUTDATED INFO. Keeping for the sake of archival.
	//They must be restrained, beheaded or gibbed to stop being a threat.                               <--------- Zombies CAN DIE now with the removal of NODEATH trait. PRIMITIVE Infestation forms will not die.
	if(regen_cooldown < world.time)
		var/heal_amt = heal_rate
		if(C.InCritical())
			heal_amt *= 2
		C.heal_overall_damage(heal_amt,heal_amt)
		C.adjustToxLoss(-heal_amt)
	if(!C.InCritical() && prob(4))
		playsound(C, pick(spooks), 50, TRUE, 10)

//Congrats you somehow died so hard you stopped being a zombie
/datum/species/zombie/infectious/spec_death(gibbed, mob/living/carbon/C)
	. = ..()
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(infection)
		qdel(infection)

/datum/species/zombie/infectious/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	. = ..()

	// Deal with the source of this zombie corruption
	//  Infection organ needs to be handled separately from mutant_organs
	//  because it persists through species transitions
	var/obj/item/organ/zombie_infection/infection
	infection = C.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(!infection)
		infection = new()
		infection.Insert(C)


// Your skin falls off
/datum/species/krokodil_addict
	name = "Human"
	id = "goofzombies"
	limbs_id = "zombie" //They look like zombies
	sexes = 0
	meat = /obj/item/reagent_containers/food/snacks/meat/slab/human/mutant/zombie
	mutanttongue = /obj/item/organ/tongue/zombie

#undef REGENERATION_DELAY
