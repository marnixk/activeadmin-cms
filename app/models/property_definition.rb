
class PropertyDefinition < ActiveRecord::Base
	
	validates_presence_of :name, :label, :def_type, :template_id

	#
	#  Keep definition and settings consistent
	#
	after_save :add_settings_to_pages

	#
	#  Belongs to a template
	# 
	belongs_to :template

	#
	#  Has many pages that implement these settings
	#
	has_many :property_settings, :dependent => :destroy

	#
	#  Can get/set these fields
	# 
	attr_accessible :name, 
					:label, 
					:def_type, 
					:template_id,
					:priority

	def title
		self.name
	end

	def for_page(page)
		PropertySetting.where(:page => page, :property_definition => self)
	end

	#
	#  When a definition changes or is created, all pages that belong to a certain template should get updated
	#
	def add_settings_to_pages
		template.pages.each do |page|

			# get property definition ids that have been inserted already
			set_ids = page.property_settings.map(&:property_definition_id)

			# is this definition part of that? if not, add it.
			if not set_ids.include? self.id then
				new_setting = PropertySetting.new({:page => page, :property_definition => self})
				new_setting.save
			end
		end
	end

end

