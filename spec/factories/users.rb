# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::TvShows::TheITCrowd.character }
    email { Faker::TvShows::TheITCrowd.email }
  end
end
