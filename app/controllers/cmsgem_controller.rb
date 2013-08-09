class CmsgemController < ActionController::Base
	
	protect_from_forgery

	#
	#  This action tries to route an application path
	#
	def route
		@page = Page.find_with_path(params['path'] || "home") 
		if @page.nil? then 
			not_found
		else
			if (@page.published? or params[:show_preview].present?) and @page.visitable? then
				render "#{@page.template.renderpath}/view", :layout => @page.template.layoutname
			else
				not_found
			end		
		end
	end

	#
	#  404
	#
	def not_found
		raise ActionController::RoutingError.new('Not Found')
	end
end
