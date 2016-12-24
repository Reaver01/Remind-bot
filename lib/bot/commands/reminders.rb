module MainBot
	module Commands
		module Reminders
			extend Discordrb::Commands::CommandContainer
			command(
					:reminders,
					description: "Manage set reminders.",
					usage: "reminders <list|delete> <number>",
					help_available: true
			) do |event, option, number|
				if File.file?("botfiles/reminders/#{event.user.id}")
					userreminders = loadArr(userreminders,"botfiles/reminders/#{event.user.id}")
					if option == "list"
						output = "```\n"
						x = 0
						y = 1
						begin
							output += "Reminder #{y}: #{userreminders[x+1]} @ #{userreminders[x]}\n"
							x += 2
							y += 1
						end while x < userreminders.length
						output += "```"
						event << output
					elsif option == "delete"
						if number == "all"
							File.delete("botfiles/reminders/#{userid}")
						else
							userreminders.delete_at((number.to_i-1)*2+1)
							userreminders.delete_at((number.to_i-1)*2)
							File.write("botfiles/reminders/#{event.user.id}", userreminders)
							event << "Reminder was deleted"
						end
					else
						remindernum = userreminders.length.to_i / 2
						event << "You have #{remindernum} reminders set! Use the list option to list them or the delete option to delete one"
					end

				else
					event << "You do not have any reminders set right now. Set some with `!remindme`"
				end

				File.write("botfiles/reminders/#{event.user.id}", userreminders)

				puts "#{event.timestamp}: #{event.user.name}: CMD: reminders"
				nil
			end
		end
	end
end
