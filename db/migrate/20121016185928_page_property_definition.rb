class PagePropertyDefinition < ActiveRecord::Migration
  def up

  	create_table "property_definitions" do |t|

  		t.integer :priority
  		t.integer :template_id

  		t.string :name
  		t.string :label
  		t.string :def_type

  		t.timestamps
  	end
  end

  def down
  	drop_table "property_definitions"
  end
end
