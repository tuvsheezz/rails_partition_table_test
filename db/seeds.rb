# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'securerandom'
require 'parallel'

clicks = []

240000.times {
  d = {
    status: 1,
    uuid: SecureRandom.hex(10),
    click_timestamp: "#{2020 + rand(0..19)}-#{rand(1..12)}-#{rand(1..28)} 00:00:00"
  }
  clicks << d
}

Parallel.map(clicks, in_processes: 6, progress: "Seeding ... ") { |click|
  Click.create(click)
}
