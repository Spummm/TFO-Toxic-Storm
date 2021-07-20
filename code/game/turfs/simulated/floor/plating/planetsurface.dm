/turf/open/floor/plating/asteroid/wasteland
	name = "wasteland"
	desc = "Ravaged by the omniparasite, the surface of this planet is anemic and sickly."
	baseturfs = /turf/open/floor/plating/asteroid/wasteland
	icon = 'icons/turf/planet_turf.dmi'
	icon_state = "wasteland"
	icon_plating = "wasteland"
	environment_type = "wasteland"
	floor_variance = 15
	digResult = /obj/item/stack/ore/glass/basalt

/turf/open/floor/plating/asteroid/wasteland/acidpus
	baseturfs = /turf/open/acidpus/smooth

/turf/open/floor/plating/asteroid/wasteland/airless
	baseturfs = /turf/open/floor/plating/asteroid/wasteland/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/plating/asteroid/wasteland/parasite_baseturf
	baseturfs = /turf/open/floor/plating/asteroid/wasteland/lava_land_surface

///////Surface. The surface is warm, but survivable without a suit. Internals are required. The floors break to chasms, which drop you into the underground.

/turf/open/floor/plating/asteroid/wasteland/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	planetary_atmos = TRUE
	baseturfs = /turf/open/acidpus/smooth/planet_surface 