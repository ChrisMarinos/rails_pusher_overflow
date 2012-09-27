class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :voter
      t.string :voter_type
      t.references :question

      t.timestamps
    end
  end
end
