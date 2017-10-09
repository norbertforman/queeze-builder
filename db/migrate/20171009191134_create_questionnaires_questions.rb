class CreateQuestionnairesQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaires_questions do |t|
      t.integer :questionnaire_id
      t.integer :question_id

      t.timestamps
    end
  end
end
