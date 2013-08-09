class VisitableAndPublishedFieldsForPage < ActiveRecord::Migration
  def up
  	change_table "pages" do |t|
  		t.boolean :visitable, :default => true
  		t.boolean :published, :default => true
  	end
  end

  def down
  end
end
