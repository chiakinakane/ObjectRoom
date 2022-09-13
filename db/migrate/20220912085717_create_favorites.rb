class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :user, null: false
      t.integer :idea, null: false
      t.timestamps
    end
  end
end
