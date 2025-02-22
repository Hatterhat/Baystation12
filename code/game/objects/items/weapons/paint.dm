//NEVER USE THIS IT SUX	-PETETHEGOAT
//THE GOAT WAS RIGHT - RKF

var/global/list/cached_icons = list()

/obj/item/reagent_containers/glass/paint
	desc = "It's a paint bucket."
	name = "paint bucket"
	icon = 'icons/obj/tools/paint_bucket.dmi'
	icon_state = "paintbucket"
	item_state = "paintcan"
	matter = list(MATERIAL_ALUMINIUM = 200)
	w_class = ITEM_SIZE_NORMAL
	amount_per_transfer_from_this = 10
	possible_transfer_amounts = "10;20;30;60"
	volume = 60
	unacidable = FALSE
	atom_flags = ATOM_FLAG_OPEN_CONTAINER
	var/paint_hex = "#fe191a"

/obj/item/reagent_containers/glass/paint/afterattack(turf/simulated/target, mob/user, proximity)
	if(!proximity) return
	if(istype(target) && reagents.total_volume > 5)
		if (reagents.should_admin_log())
			var/contained = reagentlist()
			if (istype(target, /mob))
				admin_attack_log(user, target, "Used \the [name] containing [contained] to splash the victim.", "Was splashed by \the [name] containing [contained].", "used \the [name] containing [contained] to splash")
			else
				admin_attacker_log(user, "Used \the [name] containing [contained] to splash \the [target]")
		user.visible_message(SPAN_WARNING("\The [target] has been splashed with something by [user]!"))
		reagents.trans_to_turf(target, 5)
	else
		return ..()

/obj/item/reagent_containers/glass/paint/Initialize()
	. = ..()
	if(paint_hex && length(paint_hex) > 0)
		reagents.add_reagent(/datum/reagent/paint, volume, paint_hex)
		update_icon()

/obj/item/reagent_containers/glass/paint/on_update_icon()
	overlays.Cut()
	if(reagents.total_volume)
		var/image/filling = image('icons/obj/reagentfillings.dmi', src, "paintbucket")
		filling.color = reagents.get_color()
		overlays += filling

/obj/item/reagent_containers/glass/paint/red
	name = "red paint bucket"
	paint_hex = "#fe191a"

/obj/item/reagent_containers/glass/paint/yellow
	name = "yellow paint bucket"
	paint_hex = "#fdfe7d"

/obj/item/reagent_containers/glass/paint/green
	name = "green paint bucket"
	paint_hex = "#18a31a"

/obj/item/reagent_containers/glass/paint/blue
	name = "blue paint bucket"
	paint_hex = "#247cff"

/obj/item/reagent_containers/glass/paint/purple
	name = "purple paint bucket"
	paint_hex = "#cc0099"

/obj/item/reagent_containers/glass/paint/black
	name = "black paint bucket"
	paint_hex = "#333333"

/obj/item/reagent_containers/glass/paint/white
	name = "white paint bucket"
	paint_hex = "#f0f8ff"

/obj/item/reagent_containers/glass/paint/random
	name = "odd paint bucket"

/obj/item/reagent_containers/glass/paint/random/New()
	paint_hex = rgb(rand(1,255),rand(1,255),rand(1,255))
	..()
