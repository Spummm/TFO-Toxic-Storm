/obj/item/organ/zombie_infection
	desc = "A small, wriggling worm. Creatures such as this are responsible for the basic infestation of creatures."
	icon = 'icons/mob/parasites/misc_infectionitems.dmi'
	icon_state = "parasite_larvae_small"

/obj/item/organ/zombie_infection/mature
	desc = "A moderately sized worm. Creatures such as these are responsible for advanced stages of infestation, or for infecting creatures with more robust immune systems."
	icon = 'icons/mob/parasites/misc_infectionitems.dmi'
	icon_state = "parasite_larvae_mature"
	living_transformation_time = 60
	converts_living = TRUE

