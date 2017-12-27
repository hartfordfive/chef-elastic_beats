module BeatUtils
    module Helper

      def service_provider

        case node['platform_family']
          when "debian"
            return Chef::Provider::Service::Systemd
          when "fedora", "rhel", "amazon"
            return Chef::Provider::Service::Systemd
        end

      end
      
    end
  end