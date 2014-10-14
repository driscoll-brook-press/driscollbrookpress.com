$middleman = self
#$debug = true

# Delegate to diddleman's middleman-config.rb file
load File.join('diddleman', 'middleman-config.rb')

activate :directory_indexes

set :haml, { ugly: true }

helpers
