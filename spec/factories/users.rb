# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "john@doeexample.com" }
    password { "password" }
  end
end
