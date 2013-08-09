
ActiveAdmin.register Media do
	menu :priority => 3, :label => "Media"

	filter :title
	filter :page
	filter :binary_file_name

	index do |i|
		i.column :title
		i.column :binary_file_name
		i.column :binary_file_size
		default_actions
	end

	show do |media|
		attributes_table do
			row :title
			row :description
			row :page

			row "Link to binary" do 
				tag(:input, :type => :text, :value => media.binary.url, :size => 80, :readonly => true)
			end

			if media.image? then
				row :binary do
					image_tag(media.binary.url, :class => "image-sample")
				end
			end
		end		
	end

	form :html => {:multipart => true} do |f|
		mapped_pages = Page.page_list

		f.inputs "File" do

			f.input :binary, :as => :file, :hint => raw((f.object.image? ? '<img class="image-sample" src="' + f.object.binary.url + '" />' : 'File to upload'))
			f.input :title, :hint => "File title"

			f.input :page, 
					:hint => "Allows you to couple this media to a certain page", 
					:collection => mapped_pages, 
					:as => :select, 
					:label => "Related to page"

			f.input :description, :hint => "Optional file description", :as => :text

		end
		f.buttons
	end
end