module MainBot
	module Commands
		module Remindme
			extend Discordrb::Commands::CommandContainer
			command(
					:remindme,
					description: "Sets a reminder for the user.",
					usage: "remindme <days> <hours> <mins> <text>",
					help_available: true,
					min_args: 4,
			) do |event, days, hours, minutes, *text|
				
				remindertext = text.join(' ')

				d = days.to_i
				h = hours.to_i
				m = minutes.to_i
				t1 = Time.now
				t2 = t1 + m*60
				t3 = t2 + h*60*60
				t4 = t3 + d*24*60*60
				
				if File.file?("botfiles/reminders/#{event.user.id}")
					userreminders = loadArr(userreminders,"botfiles/reminders/#{event.user.id}")
					userreminders.push(t4.to_s, remindertext.to_s)
					remindernum = userreminders.length.to_i / 2
					event << "Reminder set! You have #{remindernum} reminders set" 
				else
					userreminders = [t4.to_s, remindertext.to_s]
					event << "Reminder set! This is your only reminder. You can set as many as you like!"
				end

				File.write("botfiles/reminders/#{event.user.id}", userreminders)

				puts "#{event.timestamp}: #{event.user.name}: CMD: remindme"
				nil
			end
		end
	end
end
