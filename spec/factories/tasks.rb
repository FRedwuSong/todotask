# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Quote.famous_last_words  }
    content { Faker::Quote.yoda }
    end_time { DateTime.now + 1.year }
    :state
  end
end
