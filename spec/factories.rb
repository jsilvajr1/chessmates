FactoryBot.define do
  factory :user do
    sequence :username do |u|
      "username#{u}"
    end
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :game do
    sequence :name do |a|
      "Game#{a}"
    end
    association :user
  end
end