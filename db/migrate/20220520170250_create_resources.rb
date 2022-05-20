class CreateResources < ActiveRecord::Migration[7.0]
  def change
    create_table :resources do |t|
      t.references :tweet, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.string :url
      t.string :image

      t.timestamps
    end
  end
end
