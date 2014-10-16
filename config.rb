site = OpenStruct.new(YAML::load_file(File.join('data', 'site.yaml')))

Time.zone = site['timezone']

set :layout, :book
set :haml, {ugly: true}

activate :deploy do |deploy|
  deploy.method = :rsync
  deploy.host   = 'dhemery.com'
  deploy.user   = 'dhemery'
  deploy.path   = '/srv/sites/driscollbrookpress.com'
  deploy.flags  = '-avz -e ssh --delete'
end

activate :directory_indexes

helpers
