class CreatePropertySettings < ActiveRecord::Migration
	def change
		create_table :property_settings do |t|
			
			t.integer :id
			t.integer :property_definition_id
			t.integer :page_id

			t.string :string
			t.decimal :number
			t.binary :binary
			
			t.timestamps
		end
	end
end
