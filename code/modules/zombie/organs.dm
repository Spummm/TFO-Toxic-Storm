/obj/item/organ/zombie_infection
	name = "festering ooze"
	desc = "A black web of pus and viscera."
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_ZOMBIE
	icon_state = "blacktumor"
	var/causes_damage = TRUE
	var/datum/species/old_species = /datum/species/human
	var/living_transformation_time = 30
	var/converts_living = FALSE

	var/revive_time_min = 450
	var/revive_time_max = 700
	var/timer_id

/obj/item/organ/zombie_infection/Initialize()
	. = ..()
	if(iscarbon(loc))
		Insert(loc)
	GLOB.zombie_infection_list += src

/obj/item/organ/zombie_infection/Destroy()
	GLOB.zombie_infection_list -= src
	. = ..()

/obj/item/organ/zombie_infection/Insert(var/mob/living/carbon/M, special = 0, drop_if_replaced = TRUE)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/organ/zombie_infection/Remove(special = FALSE)
	if(owner)
		if(iszombie(owner) && old_species)
			owner.set_species(old_species)
		if(timer_id)
			deltimer(timer_id)
	. = ..()
	STOP_PROCESSING(SSobj, src) //Required to be done after the parent call to avoid conflicts with organ decay.

/obj/item/organ/zombie_infection/on_find(mob/living/finder)
	to_chat(finder, "<span class='warning'>Inside the head is a tiny worm, wriggling about the brain as it secretes some kind of connecting fiber.")

/obj/item/organ/zombie_infection/process()
	if(!owner)
		return
	if(!(src in owner.internal_organs))
		Remove(owner)
	if(owner.mob_biotypes & MOB_MINERAL)//does not process in inorganic things
		return
	if (causes_damage && !iszombie(owner) && owner.stat != DEAD)
		owner.adjustToxLoss(3)
		if (prob(10))
			to_chat(owner, "<span class='danger'>You feel sick...</span>")
		if (prob(5))
			to_chat(owner, "<span class='danger'>You feel a sharp pain in your head!</span>")
			owner.adjustToxLoss(10)
	if(timer_id)
		return
	if(owner.suiciding)
		return
	if(owner.stat != DEAD && !converts_living)
		return
	if(!owner.getorgan(/obj/item/organ/brain))
		return
	if(!iszombie(owner))
		to_chat(owner, "<span class='cultlarge'>You can feel a sharp pain within your head that numbs all other sensation. Something bites down on your thoughts, and refuses to let go. Hunger. You hunger. Hosts. You must spread more. The hosts are here. Spread it.</span>")
	var/revive_time = rand(revive_time_min, revive_time_max)
	var/flags = TIMER_STOPPABLE
	timer_id = addtimer(CALLBACK(src, .proc/zombify), revive_time, flags)

/obj/item/organ/zombie_infection/proc/zombify()
	timer_id = null

	if(!converts_living && owner.stat != DEAD)
		return

	if(!iszombie(owner))
		old_species = owner.dna.species.type
		owner.set_species(/datum/species/zombie/infectious)

	var/stand_up = (owner.stat == DEAD) || (owner.stat == UNCONSCIOUS)

	//Fully heal the zombie's damage the first time they rise
	owner.setToxLoss(0, 0)
	owner.setOxyLoss(0, 0)
	owner.heal_overall_damage(INFINITY, INFINITY, INFINITY, FALSE, FALSE, TRUE)

	if(!owner.revive())
		return

	owner.grab_ghost()
	owner.visible_message("<span class='danger'>[owner] suddenly convulses, as [owner.p_they()][stand_up ? " stagger to [owner.p_their()] feet and" : ""] gain a ravenous hunger in [owner.p_their()] eyes!</span>", "<span class='alien'>Spread the infestation.</span>")
	playsound(owner.loc, 'sound/parasites/mockery_screech.ogg', 50, 1)
	owner.do_jitter_animation(living_transformation_time)
	owner.Stun(living_transformation_time)
	to_chat(owner, "<span class='alertalien'>You are now an Infected Human. You claw, bite, and spread the infestation as far and wide as possible.</span>")
	to_chat(owner, "<span class='alertwarning'>You are infected and are expected to act like it. Trying to get yourself killed or the parasite removed without a fight will not be tolerated.</span>")

/obj/item/organ/zombie_infection/nodamage
	causes_damage = FALSE
