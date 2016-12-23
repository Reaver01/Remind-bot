def cronjobs_start
	scheduler = Rufus::Scheduler.new
	scheduler.cron '*/1 * * * *' do
		puts 'checking reminders'
	end
	scheduler.cron '5 */3 * * *' do
		$bot.stop
	end
	puts 'Cron jobs scheduled!'
end