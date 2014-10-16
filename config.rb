site = OpenStruct.new(YAML::load_file(File.join('data', 'site.yaml')))

Time.zone = site['timezone']

set :layout, :book
activate :directory_indexes
set :haml, {ugly: true}
helpers

