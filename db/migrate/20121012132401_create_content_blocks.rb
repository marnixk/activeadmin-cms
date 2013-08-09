class CreateContentBlocks < ActiveRecord::Migration
  def change
    create_table :content_blocks do |t|
    	
      t.timestamps
    end
  end
end
