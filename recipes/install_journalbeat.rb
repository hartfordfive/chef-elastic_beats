beat 'journalbeat' do
  version "5.6.0"
  source_type "binary"
  binary_url "https://github.com/mheese/journalbeat/releases/download/v5.6.0/journalbeat-centos"
  config({
    'journalbeat' => {
        'seek_position' => 'tail',
        'cursor_seek_fallback' => 'tail',
        'write_cursor_state' => true,
        'cursor_state_file' => '.journalbeat-cursor-state',
        'cursor_flush_period' => '5s',
        'pending_queue' => {
            'file' => '.journalbeat-pending-queue',
            'flush_period' => '5s',
            'completed_queue_size' => 8192
        }
        'clean_field_names' => true,
        'convert_to_numbers' => false,
        'move_metadata_to_field' => 'journal',
        'default_type' => 'journal',
    },
    'name' => 'journalbeat',
    'tags' => ['test'],
    'fields' => {
        'server' => node['hostname'],
        'data_center' => 'yul'
    },
    'fields_under_root' => true,
    'queue_size' => 1000,
    'output' => {
        'kafka' => {
            'enabled' => false
        },
        'console' => {
            'enabled' => true
        }
    },
    'logging' => {
        'level' => 'info',
        'to_syslog' => false,
        'metrics' => {
            'enabled' => true,
            'period' => '30s'
        }
    }
  })
  directories ['elastic_beats']['journalbeat']['path']
  user 'journalbeat'
  group 'journalbeat'
  package_dependiences ['systemd-devel']
  action :setup
end
