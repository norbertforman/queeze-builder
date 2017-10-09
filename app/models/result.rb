class Result < ApplicationRecord
  belongs_to :questionnaire

    validates_presence_of :email, :name, :score
end
