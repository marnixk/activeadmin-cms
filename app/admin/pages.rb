
ActiveAdmin.register_page "CMS" do
	menu :priority => 2, :label => "CMS"
	controller do
		def index
			
		end
	end

	#
	#  Create a content with table
	#
	content do

		render :partial => "admin/cms/index", :locals => {:mapped_pages => Page.page_list }

	end
end



ActiveAdmin.register Page do

	menu false


	#
	# Hide the index action by setting a redirect to the page defined above
	#
	controller do
		def index
			redirect_to "/admin/cms"
		end
	end

	show do |page|
		attributes_table do
			row :title

			if page.has_preview? then
				row :slug
				row :url
				row :preview do 
					tag(:iframe, :src => page.url + "?show_preview=1", :id => "page-preview")
				end
			else
				row :preview do
					p "There is no preview for this unvisitable page"
				end
			end
		end		
	end

	form :html => { :multipart => true } do |f|
		mapped_pages = Page.page_list

		f.inputs "Generic" do
			f.input :parent, :collection => Page.page_list
			f.input :template, :collection => f.object.parent.present? ? f.object.parent.template.child_templates : Template.all
			f.input :title
			f.input :published, :default => true, :label => "Page is publicly viewable"
			f.input :visitable, :default => true, :label => "Page can be accessed from URL"
			f.input :slug
		end

		f.inputs "Metadata" do
			f.input :meta_title
			f.input :meta_keywords
		end

		if not f.object.new_record? and not f.object.template.nil? then 
			f.has_many :property_settings do |nested|


				if not nested.object.new_record? then
					p_def = nested.object.property_definition

					case p_def.def_type 
					when "string"
						nested.input :string, :label => p_def.name
					when "text"
						nested.input :string, :label => p_def.name, :as => :text
					when "html"
						nested.input :string, :label => p_def.name, :as => :text, :input_html => {:class => "tinymce"}
					when "range"
						nested.input :number, :label => p_def.name, :as => :range
					when "url"
						nested.input :number, :label => p_def.name, 
									 :collection => mapped_pages, :as => :select, :selected => nested.object.number.to_i
					when "integer"
						nested.input :number, :label => p_def.name, :as => :number
					when "date"
						nested.input :string, :label => p_def.name, :as => :datepicker
					when "file"
						nested.input :number, :label => p_def.name, :as => :select, 
									 :collection => Media.all, :as => :select, :selected => nested.object.number.to_i,
									 :prompt => raw("&mdash; Select a file &mdash;"),
									 :input_html => {:size => 10, :class => "file-selection"}
					else
						nested.input :string, :hint => "Unknown input type: #{p_def.def_type}"
					end

				else
					# just return empty string when it's a new record
					# since we're hiding the add button in the CSS anyway
					""
				end

			end
		end

		f.buttons
	end


end