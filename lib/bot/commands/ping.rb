module MainBot
	module Commands
		module Ping
			extend Discordrb::Commands::CommandContainer
			command(
					:ping,
					description: "Responds with response time",
					useage: "ping"
			) do |event|
				event.respond  "Pong! : #{((Time.now - event.timestamp) * 1000).to_i}ms"
				puts "#{event.timestamp}: #{event.user.name}: CMD: ping"
				nil
			end
		end
	end
end
