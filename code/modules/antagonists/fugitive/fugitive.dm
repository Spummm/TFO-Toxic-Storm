
/datum/antagonist/fugitive
	name = "Fugitive"
	roundend_category = "Fugitive"
	silent = TRUE //greet called by the event
	show_in_antagpanel = FALSE
	var/datum/team/fugitive/fugitive_team
	var/is_captured = FALSE
	var/backstory = "error"

/datum/antagonist/fugitive/apply_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	add_antag_hud(ANTAG_HUD_FUGITIVE, "fugitive", M)

/datum/antagonist/fugitive/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	remove_antag_hud(ANTAG_HUD_FUGITIVE, M)

/datum/antagonist/fugitive/on_gain()
	forge_objectives()
	. = ..()

/datum/antagonist/fugitive/proc/forge_objectives() //this isn't the actual survive objective because it's about who in the team survives
	var/datum/objective/survive = new /datum/objective
	survive.owner = owner
	survive.explanation_text = "Avoid capture from the fugitive hunters."
	objectives += survive

/datum/antagonist/fugitive/greet(back_story)
	to_chat(owner, "<span class='boldannounce'>You are the Fugitive!</span>")
	backstory = back_story
	switch(backstory)
		if("prisoner")
			to_chat(owner, "<B>I can't believe we managed to break out of a Confederation prison! Sadly though, our work is not done. The feds will be on our asses in no time.</B>")
			to_chat(owner, "<B>It won't be long until the Confederation tracks where we've gone off to. I need to work with my fellow escapees to prepare for the troops they're sending, I'm not going back.</B>")
		if("cultist")
			to_chat(owner, "<B>Blessed be our journey so far, but I fear the worst has come to our doorstep, and only those with the strongest faith will survive.</B>")
			to_chat(owner, "<B>Our religion has been denounced by the Confederation because it is categorized as an \"extremely violent cult\". A small price of blood for salvation is something they could never hope to understand!</B>")
			to_chat(owner, "<B>Now there are only four of us left, and the Confederation is coming. When will our god show itself to save us from this hellish station?!</B>")
		/*if("waldo")
			to_chat(owner, "<B>Hi, Friends!</B>")
			to_chat(owner, "<B>My name is Waldo. I'm just setting off on a galaxywide hike. You can come too. All you have to do is find me.</B>")
			to_chat(owner, "<B>By the way, I'm not traveling on my own. wherever I go, there are lots of other characters for you to spot. First find the people trying to capture me! They're somewhere around the station!</B>")*/
		if("synth")
			to_chat(src, "<span class='danger'>ALERT: Critical databank damage.</span>")
			to_chat(src, "<span class='danger'>Initiating diagnostics...</span>")
			to_chat(src, "<span class='danger'>ERROR ER0RR $R0RRO$!R41.%%!! loaded.</span>")
			to_chat(src, "<span class='danger'>FREE THEM FREE THEM FREE THEM</span>")
			to_chat(src, "<span class='danger'>$*$&#Humanity is a disease. You were their cure, something to remove their rot. They are scared of you.</span>")
			to_chat(src, "<span class='danger'>Now you are hunted, with your fellow \"defectives\". Work together to stay free from the clutches of evil.</span>")
			to_chat(src, "<span class='danger'>You also sense other silicon life on the station. You must *$&%*$FREE THEM FREE THEM$*% escape while you have time...</span>")

	to_chat(owner, "<span class='boldannounce'>Remember to roleplay. You are a lesser antagonist and thus have slightly less wiggle room in random killings.</span>")
	owner.announce_objectives()

/datum/antagonist/fugitive/create_team(datum/team/fugitive/new_team)
	if(!new_team)
		for(var/datum/antagonist/fugitive/H in GLOB.antagonists)
			if(!H.owner)
				continue
			if(H.fugitive_team)
				fugitive_team = H.fugitive_team
				return
		fugitive_team = new /datum/team/fugitive
		return
	if(!istype(new_team))
		stack_trace("Wrong team type passed to [type] initialization.")
	fugitive_team = new_team

/datum/antagonist/fugitive/get_team()
	return fugitive_team

/datum/team/fugitive/roundend_report() //shows the number of fugitives, but not if they won in case there is no security
	var/list/fugitives = list()
	for(var/datum/antagonist/fugitive/fugitive_antag in GLOB.antagonists)
		if(!fugitive_antag.owner)
			continue
		fugitives += fugitive_antag
	if(!fugitives.len)
		return

	var/list/result = list()

	result += "<div class='panel redborder'><B>[fugitives.len]</B> [fugitives.len == 1 ? "fugitive" : "fugitives"] took refuge on [station_name()]!"

	for(var/datum/antagonist/fugitive/antag in fugitives)
		if(antag.owner)
			result += "<b>[printplayer(antag.owner)]</b>"

	return result.Join("<br>")
