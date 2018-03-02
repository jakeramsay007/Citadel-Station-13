/obj/machinery/computer/upload
	var/locked = TRUE
	var/incorrectkey = "<span class='warning'>ALERT: Incorrect access key!</span>"

/obj/machinery/computer/upload/attack_hand(mob/user)
	if(locked)
		var/dkey = trim(input(usr, "Please enter the access key.") as text|null)
		if(dkey && dkey != "")
			if(GLOB.aiuploadkey == dkey)
				locked = FALSE
				return
			else
				to_chat(user, incorrectkey)
				return
		else
			return
	if(!locked)
		var/option = input("Choose option.", "AI Upload") in list("Select AI", "Lock console")
		if(option == "Lock console")
			locked = TRUE
			return
	. = .. ()

/obj/machinery/computer/upload/attackby(obj/item/O, mob/user, params)
	if(locked)
		return
	.=..()

/obj/item/paper/uploadaccesskey
	name = "AI upload access key"

/obj/item/paper/uploadaccesskey/Initialize()
	..()
	print()

/obj/item/paper/uploadaccesskey/proc/print()
	info = "<center><h2>Daily Key Reset</h2></center><br>The new AI upload access key is '[GLOB.aiuploadkey]'.<br>Please keep this a secret and away from the clown.<br>"
	info_links = info
	add_overlay("paper_words")