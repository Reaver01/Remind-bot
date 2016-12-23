module MainBot
	module Commands
		module Blank
			extend Discordrb::Commands::CommandContainer
			command(:blank, description: '') do |event|
				#put stuff here
				nil
			end
		end
	end
end