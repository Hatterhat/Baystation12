/obj/item/grenade/supermatter
	name = "supermatter grenade"
	icon_state = "banana"
	item_state = "emergency_engi"
	origin_tech = list(TECH_BLUESPACE = 5, TECH_MAGNET = 4, TECH_ENGINEERING = 5)
	arm_sound = 'sound/effects/3.wav'
	var/implode_at

/obj/item/grenade/supermatter/Destroy()
	if(implode_at)
		STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/grenade/supermatter/detonate(mob/living/user)
	..()
	START_PROCESSING(SSobj, src)
	implode_at = world.time + 10 SECONDS
	update_icon()
	playsound(src, 'sound/weapons/wave.ogg', 100)

/obj/item/grenade/supermatter/on_update_icon()
	overlays.Cut()
	if(implode_at)
		overlays += image(icon = 'icons/obj/machines/power/fusion_field.dmi', icon_state = "emfield_s1")

/obj/item/grenade/supermatter/Process()
	if(!isturf(loc))
		if(ismob(loc))
			var/mob/M = loc
			M.drop_from_inventory(src)
		forceMove(get_turf(src))
	playsound(src, 'sound/effects/supermatter.ogg', 100)
	supermatter_pull(src, world.view, STAGE_THREE)
	if(world.time > implode_at)
		explosion(loc, 4, EX_ACT_HEAVY)
		qdel(src)
