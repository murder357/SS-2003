turf
   floor
      icon = 'IronFloor.dmi'
      layer = 1
   start
      icon = 'startimage.dmi'
      layer = 3
   wall
      icon = 'ironwall.dmi'
      density = 1
      layer = 2
      opacity = 1
   space
      icon = 'Space.dmi'
      layer = 0
      density = 0
   window
   	  icon = 'Window.dmi'
   	  layer = 2
   	  density = 1
   	  opacity = 0
   airlock
   	  icon = 'Airlock.dmi'
   	  layer = 2
   	  density = 1
   	  icon_state = "Close"
   shuttle_floor
   			icon = 'ShuttleFloor.dmi'
   			layer = 1
   			density = 0
   shuttle_wall
   			icon = 'ShuttleWall.dmi'
   			layer = 2
   			opacity = 1
   			density = 1
mob
   icon = 'FunnyStick.dmi'
   icon_state = "Alive"
   layer = 4
   var.health = 100
   density = 1

   Login()
      loc = locate(/turf/start)

world fps = 60

mob.proc.Death()
	icon_state = "Dead"
	invisibility = 1
	sight = SEEINVIS
	density = 0
	usr << "You Died!"


mob.verb.say(msg as text) world << "[usr] says: [msg]"

mob.verb.SayHealth()
	if (health > 0)
		usr << "[health] Health"
	else
		usr << "You are dead!"

mob.proc.TakeDamage(D)
	if (health > 0)
		health -= D
		usr << "You took [D] damage!"
		if (health == 0)
			Death()
	else
		usr << "Theres no more life force in you, you're dead!"

mob
    var
        last_move = 0
        move_delay = 1
    Move(newloc,dir,step_x,step_y)
        if(!last_move||world.time>=last_move+move_delay)
            . = ..(newloc,dir,step_x,step_y)
            last_move = world.time
        else
            return 0

client/Click(mob/O)
	if (O == mob)
		O.TakeDamage(10)

turf/airlock/Enter(O)
	..()
	if (icon_state == "Close")
		icon_state = "Open"
		if (icon_state == "Open")
			spawn(30)
			icon_state = "Close"
			return(1)
	else
		return(1)