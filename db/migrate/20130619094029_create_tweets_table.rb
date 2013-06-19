class CreateTweetsTable < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.references :user
    end
  end
end
