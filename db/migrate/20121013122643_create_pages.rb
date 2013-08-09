class CreatePages < ActiveRecord::Migration
  def change
    create_table "pages" do |t|
    	t.integer :parent_id
    	t.string :title
    	t.string :slug
    	t.string :meta_title
    	t.string :meta_keywords
    	t.string :body
        t.integer :template_id
        
		t.timestamps
    end
  end
end
