class AddContentBlockFields < ActiveRecord::Migration
	
	def up
		change_table "content_blocks" do |t|
			t.string :identifier
			t.string :label
			t.string :content
		end
	end

  def down
  end
end
