class Player
  def play_turn(warrior)
	# add your code here
	if @warrior.nil?
		@warrior = warrior
	end

	if @heal > 0 and not taking_damage?
		# Healing cycle
		warrior.rest!
		@heal = @heal - 1;
	else
		if not sufficient_health?
			# in case there is not sufficient health
			if warrior.feel.enemy?
				@heal = 5
				charge! :backward
			elsif warrior.feel.empty?
				if taking_damage?
					#dealing with an archer here. heal to full
					@heal = warrior.health - 20
					charge! :backward
				end
			end
		else
			charge! :forward
		end
	end
	@health = warrior.health
  end

  def initialize
  	@heal = 0
  end

  def charge! direction
  	felt = @warrior.feel(direction)
  	if felt.enemy?
  		@warrior.attack! direction 
  	elsif felt.empty?
  		@warrior.walk! direction
  	end
  end

  def taking_damage?
  	@warrior.health - @health < 0
  end

  def sufficient_health?
  	@warrior.health > 8
  end
end