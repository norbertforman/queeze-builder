class Questionnaire < ApplicationRecord
  belongs_to :user
  has_many :questionnaires_questions
  has_many :questions, through: :questionnaires_questions
  has_many :results
  
  validates_presence_of :title

  searchable do
    text :title
    integer :user_id
  end
end
