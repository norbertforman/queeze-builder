class QuestionnairesQuestion < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :question
end
