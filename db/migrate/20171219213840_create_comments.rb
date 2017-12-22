class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, index: true
      t.string :title
      t.text :body
      t.timestamps
    end
  end
end
