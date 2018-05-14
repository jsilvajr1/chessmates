class Game < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 140, minimum: 3 }
end
