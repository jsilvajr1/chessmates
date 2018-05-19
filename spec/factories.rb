FactoryBot.define do
  factory :white_player, class: User do
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
    sequence :game_name do |a|
      "Game#{a}"
    end
    association :white_player
  end
end