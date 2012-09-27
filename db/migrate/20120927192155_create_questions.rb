class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :id
      t.string :content
      t.string :author

      t.timestamps
    end
  end
end
