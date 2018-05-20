
unless webmaster = User.find_by_email("admin@gislene.com")
webmaster = User.new
webmaster.display_name = "admin"
webmaster.email = "admin@gislene.com"
webmaster.pass_crypt = SecureRandom.hex
webmaster.status = "active"
webmaster.save!
end

unless id = webmaster.client_applications.find_by_name("iD")
id = webmaster.client_applications.new
id.name = "iD"
id.url = "http://localhost:3000"
ClientApplication.all_permissions.each { |p| id[p] = true }
id.save!
end

unless website = webmaster.client_applications.find_by_name("Web Site")
website = webmaster.client_applications.new
website.name = "Web Site"
website.url = "http://localhost:3000"
ClientApplication.all_permissions.each { |p| website[p] = true }
website.save!
end

puts "admin (admin@gislene.com) criado com sucesso!"

if id
  puts "Temos a configuração correta!"
end
