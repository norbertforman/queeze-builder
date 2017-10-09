class CreateQuestionnaires < ActiveRecord::Migration[5.0]
  def change
    create_table :questionnaires do |t|
      t.integer :user_id
      t.string :title

      t.timestamps
    end
  end
end
