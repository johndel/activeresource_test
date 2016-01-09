class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.string :name
      t.text :comments
      t.integer :rating
      t.integer :severity
      t.decimal :distance
      t.boolean :is_active

      t.timestamps null: false
    end
  end
end
