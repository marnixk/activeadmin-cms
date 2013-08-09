class AddMediaFields < ActiveRecord::Migration
  def up
  	add_attachment :media, :binary

  	change_table "media" do |t|
	  	t.string :title
  		t.string :description
  		t.integer :page_id
  	end
  end

  def down
  	remove_attachment :media, :binary

  	remove_column :media, :title
  	remove_column :media, :description
  	remove_column :media, :page_id
  end
end
