class Task < ApplicationRecord
  belongs_to :creator, class_name: "User"
  attr_accessor :user_answer
  validates :title, presence: true, length: { minimum: 5 }
  validates :answer, presence: true, length: { minimum: 1 }
end
