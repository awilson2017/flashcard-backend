# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'csv'
require 'awesome_print'

USER_FILE = Rails.root.join('db', 'seed_data', 'users.csv')
puts "Loading raw user data from #{USER_FILE}"

user_failures = []
CSV.foreach(USER_FILE, :headers => true) do |row|
  user = User.new
  user.id = row['id']
  user.username = row['username']
  user.password = row['password']
  user.name = row['name']
  puts "Created user: #{user.inspect}"
  successful = user.save
  if !successful
    user_failures << user
  end
end

puts "Added #{User.count} user records"
puts "#{user_failures.length} users failed to save"


# FLASHCARD_FILE = Rails.root.join('db', 'seed_data', 'flashcards.csv')
# puts "Loading raw flashcard data from #{FLASHCARD_FILE}"
#
# flashcard_failures = []
# CSV.foreach(FLASHCARD_FILE, :headers => true) do |row|
#   flashcard = Flashcard.new
#   flashcard.id = row['id']
#   flashcard.user_id = row['user_id']
#   flashcard.question = row['question']
#
#   puts "Created flashcard: #{flashcard.inspect}"
#   successful = flashcard.save
#   if !successful
#     puts flashcard.errors.messages
#     flashcard_failures << flashcard
#   end
# end
#
# puts "Added #{Flashcard.count} flashcard records"
# puts "#{flashcard_failures.length} flashcards failed to save"




#
#
# TRIP_FILE = Rails.root.join('db', 'seed_data', 'trips.csv')
# puts "Loading raw trip data from #{TRIP_FILE}"
#
# trip_failures = []
# CSV.foreach(TRIP_FILE, :headers => true) do |row|
#   trip = Trip.new
#   trip.id = row['id']
#   trip.driver_id = row['driver_id']
#   trip.passenger_id = row['passenger_id']
#   trip.date = Date.strptime(row['date'], '%Y-%m-%d')
#   trip.rating = row['rating']
#   trip.cost = row['cost']
#   puts "Created trip: #{trip.inspect}"
#   successful = trip.save
#   if !successful
#     trip_failures << trip
#   end
# end
#
# puts "Added #{Trip.count} trip records"
# puts "#{trip_failures.length} trips failed to save"


# Since we set the primary key (the ID) manually on each of the
# tables, we've got to tell postgres to reload the latest ID
# values. Otherwise when we create a new record it will try
# to start at ID 1, which will be a conflict.
puts "Manually resetting PK sequence on each table"
ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

puts "done"
