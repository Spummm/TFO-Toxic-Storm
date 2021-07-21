/obj/item/projectile/parasite_vomit
	name = "vile refuse"
	icon_state = "neurotoxin"
	pass_flags = PASSTABLE
	damage = 15
	damage_type = TOX
	hitsound = 'sound/effects/watersplash.ogg'
	eyeblur = 2
	ricochet_chance = 0
	is_reflectable = FALSE
	var/stagger_duration = 3

/obj/item/projectile/parasite_vomit/on_hit(atom/target, blocked = FALSE)
	if(iscarbon(target) && prob(50))
		var/mob/living/L = target
		L.KnockToFloor(TRUE)
		L.Stagger(stagger_duration)
	if(ishuman(target))
		try_to_vomitinfect(target)
	return ..()

/proc/try_to_vomitinfect(mob/living/carbon/human/target)
	CHECK_DNA_AND_SPECIES(target)

	if(NOZOMBIE in target.dna.species.species_traits)
		// cannot infect any NOZOMBIE subspecies
		return

	var/obj/item/organ/zombie_infection/infection
	infection = target.getorganslot(ORGAN_SLOT_ZOMBIE)
	if(!infection && prob(30))
		infection = new()
		infection.Insert(target)

/obj/item/projectile/parasite_vomit/greater
	damage = 20
	stagger_duration = 8