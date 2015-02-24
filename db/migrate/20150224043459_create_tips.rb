class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :language
      t.string :topic
      t.text :text

      t.timestamps null: false
    end
  end
end