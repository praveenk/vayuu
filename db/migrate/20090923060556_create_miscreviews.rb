class CreateMiscreviews < ActiveRecord::Migration
  def self.up
    create_table :miscreviews do |t|
      t.string :airport_id
      t.string :pilotname
      t.string :reviewcontent

      t.timestamps
    end
  end

  def self.down
    drop_table :miscreviews
  end
end
