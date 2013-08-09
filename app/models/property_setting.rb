class PropertySetting < ActiveRecord::Base
 
	# set_primary_keys :page_id, :property_definition_id

 	has_one :template, :through => [:property_definition]
 	
	belongs_to :property_definition
	belongs_to :page

	# depending on the property definition type, there will be a value in here
	attr_accessible :string, :number, :binary, :page, :property_definition


end
