class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :tags
      t.string :url

      t.timestamps
    end
  end
end
