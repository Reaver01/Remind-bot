puts 'starting bot!'
print 'loading required...'
require 'json'
require 'discordrb'
require 'discordrb/data'
require 'rubygems'
require 'sys/uptime'
require 'active_support'
require 'yaml'
include Sys
require 'time'
require 'time_difference'
require 'open-uri'
require 'rufus-scheduler'
require 'dotenv'
require 'date'
require 'narray'

#require command files
require_relative 'lib/bot/class/loader'
Dir["lib/bot/commands/*.rb"].each {|file| require_relative file }

clock=Time.new

puts "Starting at: "+clock.inspect

#Create the bot object
require_relative 'lib/bot'
