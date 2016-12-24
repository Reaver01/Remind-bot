module MainBot
	require_relative 'bot/extras/cron'

	Dotenv.load
	puts "Credentials initialized!"

	#sets bot prefix
	$prefix = '!'

	#Loads and establishes $bot object
	$bot = Discordrb::Commands::CommandBot.new token: ENV['TOKEN'], client_id: ENV['CLIENT'], prefix: $prefix, advanced_functionality: false
	puts "$bot Loaded!"

	#Loads permissions from array
	permarray = [150278590494277632,999,"reaver01"]
	pos = 0
	begin
		$bot.set_user_permission(permarray[pos],permarray[pos+1])
		pos += 3
	end while pos < permarray.length
	puts "Permission Loaded!"

	#Commands
	$bot.include! Commands::Ping
	$bot.include! Commands::Invite
	$bot.include! Commands::Game
	$bot.include! Commands::Kill
	$bot.include! Commands::Remindme
	$bot.include! Commands::Reminders
	puts "Commands Loaded"
	
	#Turn off debugging and run async
	$bot.debug = false
	$bot.run :async
		
	#Set game status from file
	if File.file?("botfiles/game")
		$bot.game = getline("botfiles/game",1)
	else
		$bot.game = 0
	end
	puts "Game set!"	
	
	#start cron
	cronjobs_start

	puts 'Sync Confirmed!'
	puts 'SKYNET ONLINE'
	$bot.sync
end
