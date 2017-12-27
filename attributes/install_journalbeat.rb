
beat_name = "journalbeat"

default['elastic_beats'][beat_name]['version'] = "5.6.0"
default['elastic_beats'][beat_name]['download_url'] = "https://github.com/mheese/journalbeat/releases/download/v#{node['elastic_beats'][beat_name]['version']}/journalbeat-centos"

default['elastic_beats'][beat_name]['path']['home'] = "/usr/share/#{beat_name}"
default['elastic_beats'][beat_name]['path']['bin'] = "#{node['elastic_beats'][beat_name]['path']['home']}/bin"
default['elastic_beats'][beat_name]['path']['log'] = "/var/log/#{beat_name}"
default['elastic_beats'][beat_name]['path']['config'] = "/etc/#{beat_name}"
default['elastic_beats'][beat_name]['path']['data'] = "/var/lib/#{beat_name}"
default['elastic_beats'][beat_name]['path']['service'] = "/lib/systemd/system/"
default['elastic_beats'][beat_name]['path']['download'] = "/usr/share/beat_downloads"

default['elastic_beats'][beat_name]['service_name'] = "#{beat_name}.service"
default['elastic_beats'][beat_name]['owner'] = beat_name
default['elastic_beats'][beat_name]['group'] = beat_name