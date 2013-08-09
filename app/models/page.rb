class Page < ActiveRecord::Base

	#
	#  Setup default values
	# 
	before_save :default_values

	#
	#  Add correct property settings
	#
	after_save :add_property_settings

	#
	#  Parent relation
	#
	belongs_to :parent, :class_name => "Page"

	#
	#  Children self-referencing relation
	#
	has_many :children, :class_name => "Page", :foreign_key => "parent_id"

	#
	#  Template definition
	#
	belongs_to :template

	#
	#  Has template properties
	#
	has_many :property_definitions, :through => :template, :order => :priority

	#
	#  Writable attributes
	#
	attr_accessible :title, :body, :parent_id, :template_id,
	 				:slug, :meta_keywords, :meta_title,
	 				:published, :visitable,
	 				:property_settings_attributes


	#
	#  Property settings
	#
	has_many :property_settings 

	#
	#  Should be able to set nested attributes
	#
	accepts_nested_attributes_for :property_settings, :update_only => true

	#
	#  Search pages with certain setting in string
	#
	def self.string_setting(name, condition, *args)
		setting_operation(name) do |x| 
			x.where("property_settings.string #{condition}", args) 
		end
	end

	#
	#  Search pages with certain setting in string
	#
	def self.orderby_setting(name, options = {})
		name = name.to_s
		options[:type] ||= "string"
		options[:order] ||= "asc"

		rel = joins(:property_definitions, :property_settings)
		rel = rel.where("property_definitions.id = property_settings.property_definition_id")
		rel = rel.where({ :property_definitions => { :label => name } })
		rel = rel.order("property_settings.#{options[:type]} #{options[:order]}")
	end


	#
	#  Search a propety definition for a certain value and returns page instances
	#
	def self.setting_operation(name, &block)
		rel = joins(:property_definitions, :property_settings)
		rel = yield rel
		rel = rel.where({ :property_definitions => { :label => name } })
		rel.group([:page_id, :property_definition_id])
	end


	#
	#  Can preview this page? only when none of the parents have visitable
	#
	def has_preview?
		not parents.map(&:visitable).include?(false)
	end

	def has_children?
		children.length > 0
	end

	#
	#  Determine the full slug for this url
	#
	def url
		"/" + parents.reverse.map(&:slug).join("/")
	end

	#
	#  Default values 
	#
	def default_values
		self.parent_id ||= 0
	end


	#
	#  get all parents
	#
	def parents
		current_page = self
		pages = []
		while true 
			pages << current_page
			if current_page.parent.nil?
				break
			else
				current_page = current_page.parent
			end
		end

		pages
	end

	#
	#  Add the correct property settings
	#
	def add_property_settings
		available_settings = property_settings.map(&:property_definition_id)
		property_definitions.each do |prop_def|
			if not available_settings.include? prop_def.id then
				setting = PropertySetting.new({:page => self, :property_definition => prop_def})
				setting.save
			end
		end
	end

	#
	#  Create a hash that contains all the settings
	#
	def settings

		if @settings.nil? then
			hash = {}
			property_settings.includes(:property_definition).each do |setting|
				p_def = setting.property_definition
				value = case p_def.def_type
							when "string"
								setting.string
							when "text"
								setting.string
							when "html"
								setting.string
							when "integer"
								setting.number.to_i
							when "file" 
								Media.find(setting.number.to_i) unless setting.number.nil?
							when "url"
								Page.find(setting.number.to_i) unless setting.number.nil?
							when "date"
								setting.string
							else
								:dontknowhowtointerpretthis
						end
				hash[setting.property_definition.label.to_sym] = value
			end
			@settings = OpenStruct.new(hash)
		end			

		@settings
	end

	#
	#  Return the mapped page list
	# 
	def self.mapped_page_list
		page_list = Page.page_list
		map = {}
		page_list.each do |page|
			map[page.id] = page
		end

		map
	end

	#
	#  Get root pages
	#
	def self.root_pages
		pages = Page.where("parent_id = 0").includes([:template, :children]).all
	end

	#
	#  Generate formatted page list
	#
	def self.page_list(base = 0, add_to = [], level = 1)

		pages = Page.where("parent_id = ?", base).all
		
		pages.each do |child|

			add_to << OpenStruct.new({
							:id => child.id, 
							:title => (["--"] * level).join + " " + child.title,
							:html_title => (["&mdash;"] * level).join + " " + child.title,
							:level => level,
							:model => child
						})

			# recurse
			page_list(child.id, add_to, level + 1)
		end

		add_to
	end

	#
	#  Find a page with a certain path
	#
	def self.find_with_path(path)
		parent = 0
		child = nil
		elements = path.split "/"

		elements.each do |path|
			child = Page.where("parent_id = ?", parent)
					.where("slug = ?", path)
					.first

			if child.nil? 
				return nil
			else
				parent = child.id
			end
		end

		child
	end
	
end

