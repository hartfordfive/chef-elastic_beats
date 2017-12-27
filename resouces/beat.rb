resource_name "beat"


property :name, String, name_property: true
property :version, Integer, required: true
property :source_type, String # either binary or source
property :binary_url, String
property :git_url, String
property :config, Hash, :default {}
property :directories, Hash, :default {}
property :user, String
property :group, String
property :package_dependencies, Array, :default []
property :service_name, String

action :setup do

  new_resource.directories.each do |dir|
      directory dir do
        owner new_resource.user
        group new_resource.group
        recursive true
        mode '0775'
        action :create
      end
  end

  service_name =  if new_resource.service_name.empty? then "#{new_resource.name}.service" else new_resource.service_name end

  # ----------------- Create necessary user -----------------

  user new_resource.user do
      comment "#{new_resource.name} user"
      home new_resource.directories['home']
      shell '/bin/bash'
      action :create
  end
    
  group new_resource.group do
    members new_resource.user
    action :create
  end


  # ----------------- Install dependencies, if any ------------------
  if new_resource.package_dependencies.length >= 1
    new_resource.package_dependencies.each do |p|
      package p do
        action :install
      end
    end
  end


  # ----------------- Download binary -----------------
  remote_file "#{new_resource.directories['beat_downloads']}/#{new_resource.name}-#{new_resource.version}" do
    source new_resource.binary_url
    owner new_resource.user
    group new_resource.group
    mode '0750'
    action :create
  end

  # ----------------- Create the config file -----------------

  template "#{new_resource.directories['config']}/#{new_resource.name}.yml" do
    source 'beat-config.erb'
    owner new_resource.user
    group new_resource.group
    variables(new_resource.config)
    mode '0755'
    action :create
  end


  # ----------------- Create SystemD service -----------------
  template "#{new_resource.directories['service']}/#{service_name}" do
    source 'beat.service.erb'
    owner new_resource.user
    group new_resource.group
    mode '0775'
    action :create
  end

  service service_name do
    provider Chef::Provider::Service::Systemd
    action [ :enable, :start ]
    retries 3
  end

end


action :remove do

end


action :disable do
  
end


action_class do
    include BeatUtils::Helper
end