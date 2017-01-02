module MainBot
	require 'active_support'
	require 'date'
	require 'discordrb'
	require 'discordrb/data'
	require 'dotenv'
	require 'json'
	require 'rubygems'
	require 'rufus-scheduler'
	require 'sys/uptime'
	require 'time'
	require 'time_difference'
	require 'yaml'
	include Sys
	Dir["lib/bot/class/*.rb"].each {|file| require_relative file }
	Dir["bot/extras/*.rb"].each {|file| require_relative file }
	Dir["lib/bot/commands/*.rb"].each {|file| require_relative file }

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

	#Load all commands
	Commands.constants.each do |x|
		$bot.include! Commands.const_get x
	end
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
