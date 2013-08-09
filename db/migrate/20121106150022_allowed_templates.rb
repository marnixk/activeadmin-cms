class AllowedTemplates < ActiveRecord::Migration
  def up
  	change_table "templates" do |t|
  		t.string :template_ids, :default => "all"
  	end
  end

  def down
  end
end
