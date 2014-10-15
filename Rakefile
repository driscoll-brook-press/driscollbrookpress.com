require 'rake/clean'
require 'yaml'

build_dir = 'build'
CLEAN.include build_dir

site = OpenStruct.new YAML::load_file(File.join('data', 'site.yaml'))
host = OpenStruct.new YAML::load_file(File.join('data', 'host.yaml'))

domain = site['domain']

task default: [:deploy]

desc "Deploy the site to #{site.domain}"
task :deploy do
  path = File.join(host.deploy_root, site.domain)
  dest = "#{host.user}@#{host.name}:#{path}"
  puts "rsync -az -e 'ssh -p 22' --out-format='%f' --delete #{build_dir} #{dest}"
end

