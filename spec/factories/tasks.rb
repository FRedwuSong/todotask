# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::TvShows::BigBangTheory.character }
    content { Faker::TvShows::BigBangTheory.quote }
    end_time { DateTime.now + 1.year }
    priority { [0, 1, 2].sample }
    :state
  end
end
