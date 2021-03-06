class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :questionnaires_questions
  has_many :questionnaires, through: :questionnaires_questions

  validates_presence_of :title, :body

  searchable do
    text :title
    text :body, boost: 5 # any keyword found here is 5X times more important
    integer :user_id
  end
end
