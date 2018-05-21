OpenStreetMap::Application.config.after_initialize do

  if Rails.env.development? && ActiveRecord::Base.connection.table_exists?(:client_applications)

    webmaster = User.find_by_email("admin@gislene.com")
    
    if webmaster
      id = webmaster.client_applications.find_by_name("iD")
      website = webmaster.client_applications.find_by_name("Web Site")
      if id and website
        OAUTH_KEY = website.key
        ID_KEY = id.key
      end
    end
  end

end
