class CreateUserreviews < ActiveRecord::Migration
  def self.up
    create_table :userreviews do |t|
      t.string :username
      t.string :airport_code
      t.text :review_content

      t.timestamps
    end
  end

  def self.down
    drop_table :userreviews
  end
end
