class CreateDotas < ActiveRecord::Migration
  def self.up
  	create_table :dota do |t|
  		t.string :title
  		t.string :language
  		t.string :author_name
  		t.string :author_first
  		t.string :description
  		t.string :tuto
  	end
  end
  def self.down
   drop_table :dota
  end
end
