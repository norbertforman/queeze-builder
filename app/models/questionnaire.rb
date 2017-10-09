class Questionnaire < ApplicationRecord
  belongs_to :user
  validates_presence_of :title

  searchable do
    text :title
    integer :user_id
  end
end
