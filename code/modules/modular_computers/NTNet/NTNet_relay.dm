// Relays don't handle any actual communication. Global NTNet datum does that, relays only tell the datum if it should or shouldn't work.
/obj/machinery/ntnet_relay
	name = "\improper NTNet quantum relay"
	desc = "A very complex router and transmitter capable of connecting electronic devices together. Looks fragile."
	icon = 'icons/obj/machines/telecomms.dmi'
	icon_state = "relay"
	use_power = POWER_USE_ACTIVE
	active_power_usage = 20000 //20kW, apropriate for machine that keeps massive cross-Zlevel wireless network operational.
	idle_power_usage = 100
	icon_state = "relay"
	anchored = TRUE
	density = TRUE
	construct_state = /singleton/machine_construction/default/panel_closed
	uncreated_component_parts = null
	stat_immune = 0
	machine_name = "\improper NTNet quantum relay"
	machine_desc = "Maintains a copy of proprietary software used to provide NTNet service to all valid devices in the region. Essentially a huge router."
	/// Reference to NTNet. This is mostly for backwards reference and to allow varedit modifications from ingame.
	var/datum/ntnet/NTNet = null
	/// Set to FALSE if the relay was turned off
	var/enabled = TRUE
	/// Set to TRUE if the relay failed due to (D)DoS attack
	var/dos_failure = FALSE
	/// List of backwards reference for qdel() stuff
	var/list/dos_sources = list()

	/// Amount of DoS "packets" in this relay's buffer.
	var/dos_overload = 0
	/// Amount of DoS "packets" in buffer required to crash the relay.
	var/dos_capacity = 500
	/// Amount of DoS "packets" dissipated over time.
	var/dos_dissipate = 1

// TODO: Implement more logic here. For now it's only a placeholder.
/obj/machinery/ntnet_relay/operable()
	if(!..(MACHINE_STAT_EMPED))
		return FALSE
	if(dos_failure)
		return FALSE
	if(!enabled)
		return FALSE
	return TRUE

/obj/machinery/ntnet_relay/on_update_icon()
	overlays.Cut()
	if(panel_open)
		overlays += "[icon_state]_panel"
	if(operable())
		overlays += "[icon_state]_lights_working"
		overlays += emissive_appearance(icon, "[icon_state]_lights_working")

/obj/machinery/ntnet_relay/Process()
	if(operable())
		update_use_power(POWER_USE_ACTIVE)
	else
		update_use_power(POWER_USE_IDLE)

	if(dos_overload)
		dos_overload = max(0, dos_overload - dos_dissipate)

	// If DoS traffic exceeded capacity, crash.
	if((dos_overload > dos_capacity) && !dos_failure)
		dos_failure = TRUE
		update_icon()
		ntnet_global.add_log("Quantum relay ([uid]) switched from normal operation mode to overload recovery mode.")
	// If the DoS buffer reaches 0 again, restart.
	if((dos_overload == 0) && dos_failure)
		dos_failure = FALSE
		update_icon()
		ntnet_global.add_log("Quantum relay ([uid]) switched from overload recovery mode to normal operation mode.")

/obj/machinery/ntnet_relay/ui_interact(mob/user, ui_key = "main", datum/nanoui/ui = null, force_open = 1, datum/topic_state/state = GLOB.default_state)
	var/list/data = list()
	data["enabled"] = enabled
	data["dos_capacity"] = dos_capacity
	data["dos_overload"] = dos_overload
	data["dos_crashed"] = dos_failure
	data["portable_drive"] = !!get_component_of_type(/obj/item/stock_parts/computer/hard_drive/portable)

	ui = SSnano.try_update_ui(user, src, ui_key, ui, data, force_open)
	if (!ui)
		ui = new(user, src, ui_key, "ntnet_relay.tmpl", "NTNet Quantum Relay", 500, 300, state = state)
		ui.set_initial_data(data)
		ui.open()
		ui.set_auto_update(1)

/obj/machinery/ntnet_relay/interface_interact(mob/living/user)
	ui_interact(user)
	return TRUE

/obj/machinery/ntnet_relay/Topic(href, href_list)
	if(..())
		return TOPIC_HANDLED
	if(href_list["restart"])
		dos_overload = 0
		dos_failure = FALSE
		update_icon()
		ntnet_global.add_log("Quantum relay ([uid]) manually restarted from overload recovery mode to normal operation mode.")
		return TOPIC_HANDLED
	else if(href_list["toggle"])
		enabled = !enabled
		ntnet_global.add_log("Quantum relay ([uid]) manually [enabled ? "enabled" : "disabled"].")
		update_icon()
		return TOPIC_HANDLED
	else if(href_list["purge"])
		ntnet_global.banned_nids.Cut()
		ntnet_global.add_log("Override: Network blacklist manually cleared from Quantum relay ([uid]).")
		return TOPIC_HANDLED
	else if(href_list["eject_drive"] && uninstall_component(/obj/item/stock_parts/computer/hard_drive/portable))
		visible_message("[icon2html(src, viewers(get_turf(src)))] [src] beeps and ejects its portable disk.")

/obj/machinery/ntnet_relay/New()
	uid = gl_uid
	gl_uid++
	if(ntnet_global)
		ntnet_global.relays.Add(src)
		NTNet = ntnet_global
		ntnet_global.add_log("New Quantum Relay ([uid]) activated. Current amount of linked relays: [length(NTNet.relays)]")
	..()

/obj/machinery/ntnet_relay/Destroy()
	if(ntnet_global)
		ntnet_global.relays.Remove(src)
		ntnet_global.add_log("Quantum Relay ([uid]) connection severed. Current amount of linked relays: [length(NTNet.relays)]")
		NTNet = null
	for(var/datum/computer_file/program/ntnet_dos/D in dos_sources)
		D.target = null
		D.error = "Connection to quantum relay severed"
	..()
