# frozen_string_literal: true

# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'factory_bot_rails'
include FactoryBot::Syntax::Methods

FactoryBot.create(:user)
