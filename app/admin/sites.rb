ActiveAdmin.register Site do
  controller.authorize_resource

  menu :if => lambda{|tabs_renderer|
    # controller.current_ability.can?(:manage, Site)
    current_user.admin
  }

  index do
    column :name do |site|
      link_to site.name, admin_site_path(site)
    end
    default_actions
  end

  form :html => {:multipart => true} do |f|
    f.inputs do
      f.input :name, :as => :string
      f.input :host, :as => :string
      f.input :port, :as => :string
      f.input :auth_gateway
      f.input :twitter, :as => :string
      f.input :image, :as => :file
    end
    f.buttons do
      f.submit
    end
  end

end
