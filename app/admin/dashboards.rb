ActiveAdmin.register_page "Dashboard" do
    menu false
    controller do
        def index
            redirect_to "/admin/cms"
        end
    end
    
end