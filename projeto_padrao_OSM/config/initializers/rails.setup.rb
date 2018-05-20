OpenStreetMap::Application.config.after_initialize do

  if Rails.env.development? && ActiveRecord::Base.connection.table_exists?(:client_applications)

    unless webmaster = User.find_by_email("admin@gislene.com")
      return
    end

    unless id = webmaster.client_applications.find_by_name("iD")
      return
    end


    unless website = webmaster.client_applications.find_by_name("Web Site")
      return
    end

    OAUTH_KEY = website.key
    ID_KEY = id.key
  end

end
