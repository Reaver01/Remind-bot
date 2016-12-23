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
					permission_level: 2,
			) do |event, days, hours, minutes, *text|
				
				remindertext = text.join(' ')

				d = days.to_i
				h = hours.to_i
				m = minutes.to_i
				t1 = Time.now
				t2 = t1 + m*60
				t3 = t2 + h*60*60
				t4 = t3 + d*24*60*60
				d1 = TimeDifference.between(t1, t4).in_days
				h1 = TimeDifference.between(t1, t4).in_hours
				m1 = TimeDifference.between(t1, t4).in_minutes
				d2 = d1.floor
				h1 = h1-24*d2
				h2 = h1.floor
				m1 = m1-60*h2-24*60*d2
				m2 = m1.floor
				
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
