class RemoveBodyFromPage < ActiveRecord::Migration
  def up
  	change_table "pages" do |t|
  		t.remove :body
  	end
  end

  def down
  end
end
