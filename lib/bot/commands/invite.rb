module MainBot
	module Commands
		module Invite
			extend Discordrb::Commands::CommandContainer
			command(
					:invite,
					description: "Invites bot to your server",
					useage: "invite"
			) do |event|
				event.respond  "Invite Link: <https://discordapp.com/oauth2/authorize?client_id=261815705811288064&scope=bot&permissions=0>"
				puts "#{event.timestamp}: #{event.user.name}: CMD: invite"
				nil
			end
		end
	end
end
