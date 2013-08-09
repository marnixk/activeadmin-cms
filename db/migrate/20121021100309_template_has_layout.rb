class TemplateHasLayout < ActiveRecord::Migration
  def up
  	change_table "templates" do |t|
  		t.string :layoutname, :default => "application"
  	end
  end

  def down
  end
end
