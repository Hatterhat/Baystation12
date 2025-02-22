/obj/item/reagent_containers/glass/bottle
	name = "bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = null
	item_state = "atoxinbottle"
	randpixel = 7
	center_of_mass = "x=15;y=10"
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = "5;10;15;25;30;60"
	w_class = ITEM_SIZE_SMALL
	item_flags = 0
	obj_flags = 0
	volume = 60


/obj/item/reagent_containers/glass/bottle/on_reagent_change()
	update_icon()


/obj/item/reagent_containers/glass/bottle/pickup(mob/user)
	..()
	update_icon()


/obj/item/reagent_containers/glass/bottle/dropped(mob/user)
	..()
	update_icon()


/obj/item/reagent_containers/glass/bottle/attack_hand()
	..()
	update_icon()


/obj/item/reagent_containers/glass/bottle/New()
	..()
	if (!icon_state)
		icon_state = "bottle-[rand(1,4)]"


/obj/item/reagent_containers/glass/bottle/on_update_icon()
	overlays.Cut()
	if (reagents.total_volume && (icon_state == "bottle-1" || icon_state == "bottle-2" || icon_state == "bottle-3" || icon_state == "bottle-4"))
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "[icon_state]10")
		var/percent = round((reagents.total_volume / volume) * 100)
		switch (percent)
			if (0 to 9)
				filling.icon_state = "[icon_state]--10"
			if (10 to 24)
				filling.icon_state = "[icon_state]-10"
			if (25 to 49)
				filling.icon_state = "[icon_state]-25"
			if (50 to 74)
				filling.icon_state = "[icon_state]-50"
			if (75 to 79)
				filling.icon_state = "[icon_state]-75"
			if (80 to 90)
				filling.icon_state = "[icon_state]-80"
			if (91 to INFINITY)
				filling.icon_state = "[icon_state]-100"
		filling.color = reagents.get_color()
		overlays += filling
	if (!is_open_container())
		var/image/lid = image(icon, src, "lid_bottle")
		overlays += lid


/obj/item/reagent_containers/glass/bottle/inaprovaline
	name = "inaprovaline bottle"
	desc = "A small bottle. Contains inaprovaline - used to stabilize patients."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/inaprovaline/New()
	..()
	reagents.add_reagent(/datum/reagent/inaprovaline, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/kelotane
	name = "kelotane bottle"
	desc = "A small bottle. Contains kelotane - used to treat burns."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/kelotane/New()
	..()
	reagents.add_reagent(/datum/reagent/kelotane, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/dexalin
	name = "dexalin bottle"
	desc = "A small bottle. Contains dexalin - used to treat oxygen deprivation."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/dexalin/New()
	..()
	reagents.add_reagent(/datum/reagent/dexalin, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/toxin
	name = "toxin bottle"
	desc = "A small bottle of toxins. Do not drink, it is poisonous."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-3"


/obj/item/reagent_containers/glass/bottle/toxin/New()
	..()
	reagents.add_reagent(/datum/reagent/toxin, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/cyanide
	name = "cyanide bottle"
	desc = "A small bottle of cyanide. Bitter almonds?"
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-3"


/obj/item/reagent_containers/glass/bottle/cyanide/New()
	..()
	reagents.add_reagent(/datum/reagent/toxin/cyanide, 30) //volume changed to match chloral
	update_icon()


/obj/item/reagent_containers/glass/bottle/stoxin
	name = "soporific bottle"
	desc = "A small bottle of soporific. Just the fumes make you sleepy."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-3"


/obj/item/reagent_containers/glass/bottle/stoxin/New()
	..()
	reagents.add_reagent(/datum/reagent/soporific, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/chloralhydrate
	name = "Chloral Hydrate Bottle"
	desc = "A small bottle of Choral Hydrate. Mickey's Favorite!"
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-3"


/obj/item/reagent_containers/glass/bottle/chloralhydrate/New()
	..()
	reagents.add_reagent(/datum/reagent/chloralhydrate, 30)		//Intentionally low since it is so strong. Still enough to knock someone out.
	update_icon()


/obj/item/reagent_containers/glass/bottle/antitoxin
	name = "dylovene bottle"
	desc = "A small bottle of dylovene. Counters poisons, and repairs damage. A wonder drug."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/antitoxin/New()
	..()
	reagents.add_reagent(/datum/reagent/dylovene, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/mutagen
	name = "unstable mutagen bottle"
	desc = "A small bottle of unstable mutagen. Randomly changes the DNA structure of whoever comes in contact."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-1"


/obj/item/reagent_containers/glass/bottle/mutagen/New()
	..()
	reagents.add_reagent(/datum/reagent/mutagen, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/ammonia
	name = "ammonia bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-1"


/obj/item/reagent_containers/glass/bottle/ammonia/New()
	..()
	reagents.add_reagent(/datum/reagent/ammonia, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/eznutrient
	name = "\improper EZ NUtrient bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/eznutrient/New()
	..()
	reagents.add_reagent(/datum/reagent/toxin/fertilizer/eznutrient, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/left4zed
	name = "\improper Left-4-Zed bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/left4zed/New()
	..()
	reagents.add_reagent(/datum/reagent/toxin/fertilizer/left4zed, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/robustharvest
	name = "\improper Robust Harvest"
	desc = "A small bottle."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/robustharvest/New()
	..()
	reagents.add_reagent(/datum/reagent/toxin/fertilizer/robustharvest, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/diethylamine
	name = "diethylamine bottle"
	desc = "A small bottle."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/diethylamine/New()
	..()
	reagents.add_reagent(/datum/reagent/diethylamine, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/pacid
	name = "Polytrinic Acid Bottle"
	desc = "A small bottle. Contains a small amount of Polytrinic Acid."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/pacid/New()
	..()
	reagents.add_reagent(/datum/reagent/acid/polyacid, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/adminordrazine
	name = "Adminordrazine Bottle"
	desc = "A small bottle. Contains the liquid essence of the gods."
	icon = 'icons/obj/food/drinks.dmi'
	icon_state = "holyflask"


/obj/item/reagent_containers/glass/bottle/adminordrazine/New()
	..()
	reagents.add_reagent(/datum/reagent/adminordrazine, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/capsaicin
	name = "Capsaicin Bottle"
	desc = "A small bottle. Contains hot sauce."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/capsaicin/New()
	..()
	reagents.add_reagent(/datum/reagent/capsaicin, 60)
	update_icon()


/obj/item/reagent_containers/glass/bottle/frostoil
	name = "Chilly Oil Bottle"
	desc = "A small bottle. Contains cold sauce."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-4"


/obj/item/reagent_containers/glass/bottle/frostoil/New()
	..()
	reagents.add_reagent(/datum/reagent/frostoil, 60)
	update_icon()

/obj/item/reagent_containers/glass/bottle/dye
	name = "dye bottle"
	desc = "A little bottle used to hold dye or food coloring, with a narrow bottleneck for handling small amounts."
	icon = 'icons/obj/chemical_storage.dmi'
	icon_state = "bottle-1"
	amount_per_transfer_from_this = 1
	possible_transfer_amounts = "1;2;5;10;15;25;30;60"
	var/datum/reagent/starting_reagent = /datum/reagent/dye
	var/starting_vol = 60


/obj/item/reagent_containers/glass/bottle/dye/Initialize()
	. = ..()
	reagents.add_reagent(starting_reagent, starting_vol)
	update_icon()


/obj/item/reagent_containers/glass/bottle/dye/polychromic
	name = "polychromic dye bottle"
	desc = "A little bottle used to hold dye or food coloring, with a narrow bottleneck for handling small amounts. \
			Outfitted with a tiny mechanism that can change the color of its contained dye, opening up infinite possibilities."


/obj/item/reagent_containers/glass/bottle/dye/polychromic/attack_self(mob/living/user)
	var/datum/reagent/heldDye = reagents.get_reagent(starting_reagent)
	if (!heldDye)
		to_chat(user, SPAN_WARNING("\The [src] isn't holding any dye!"))
		return
	var/new_color = input(user, "Choose the dye's new color.", "[name]") as color|null
	if (!new_color || !Adjacent(user))
		return
	to_chat(user, SPAN_NOTICE("The dye in \the [src] swirls and takes on a new color."))
	heldDye.color = new_color
	update_icon()


/obj/item/reagent_containers/glass/bottle/dye/polychromic/strong
	starting_reagent = /datum/reagent/dye/strong
	starting_vol = 15
