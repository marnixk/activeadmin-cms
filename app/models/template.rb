class Template < ActiveRecord::Base
	
	#
	#  before save, make list of template_ids into string
	# 
	before_save :separate_template_ids

	#
	#  after load make list of template_ids into array
	#
	after_initialize :make_template_ids_list

	#
	#  should always have a name
	#
	validates_presence_of :name

	#
	#  Pages that use this template
	#
	has_many :pages
	
	#
	#  Property definitions
	#
	has_many :property_definitions

	#
	#  able to use these attributes
	#
	attr_accessible :name, :renderpath, :property_definitions_attributes, :layoutname, :template_ids

	#
	# For active admin to accept information for property definitions
	#
	accepts_nested_attributes_for :property_definitions, :allow_destroy => true
	
	#
	#  before save, make list of template_ids into string
	# 
	def separate_template_ids
		self.template_ids = self.template_ids.delete_if { |x| x.blank? }.join(",") unless self.template_ids.blank?
	end
	
	#
	#  after load make list of template_ids into array
	#
	def make_template_ids_list
		self.template_ids = self.template_ids.split(",") unless self.template_ids.blank?
	end

	#
	#  get a list of all child template options
	#
	def self.all_child_templates
		templates = Template.all.map {|x| { :name => x.name, :id => x.id.to_s } }
		all_option = [{ :name => "All templates", :id => "all" }] 

		# convert to open struct
		(all_option + templates).map {|x| OpenStruct.new(x) }
	end

	#
	#  Get child templates for this template instance
	#
	def child_templates
		if template_ids == "all" then
			return Template.all
		else
			Template.where(:id => template_ids.split(",")).all
		end
	end

end

