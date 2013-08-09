ActiveAdmin.register Template do

	menu :label => "Templates", :parent => "Tools"

	index do
		column :name do |c|
			a link_to c.name, edit_admin_template_path(c)
		end
		column :renderpath
		column :layoutname
		default_actions
	end


	form do |f|
		f.inputs "Template" do
			f.input :name, :hint => "The human-readable name of the template"
			f.input :renderpath, :hint => "The base directory in which all render activities take place"
			f.input :layoutname, :hint => "The name of template layout these pages are rendered with"
			f.input :template_ids, 
					:hint => "Which subpage templates can be created for this template?", 
					:collection => Template.all_child_templates, 
					:checked => f.object.template_ids,
					:as => :check_boxes
		end

		f.has_many :property_definitions do |pd|

			pd.input :def_type, 
					:label => "Type", 
					:collection => ['string', 'text', 'html', 'range', 'url', 'integer', 'file', 'date'],
					:hint => "What type of field is it?"

			pd.input :label, :hint => "Record-name"
			pd.input :name, :hint => "Human-readable name"

			pd.input :priority, :hint => "Lower number means higher up on edit form"

			# add a delete button when the id is known
			if pd.object.id then
				pd.input :_destroy, :as => :boolean, :label => "Delete record"
			end
			pd.form_buffers.last
		end

		f.buttons
	end

end