class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :message
      t.references :tweet
      t.timestamps
    end
  end
end
