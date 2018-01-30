class User < ApplicationRecord
  has_many :flashcards

  # validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  # validates :password, presence: true
end
