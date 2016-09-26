module VagrantPlugins
  module GuestGaia
    module Cap
      class ConfigureNetworks
        def self.configure_networks(machine, networks)
          networks.each do |network|
            devnum = network[:interface]
            device = "eth#{devnum}"

            machine.communicate.execute("/bin/clish -s -c 'set interface #{device} link-speed 1000M/full state on'")

            if network[:type].to_sym == :static
              machine.communicate.execute("/bin/clish -s -c 'set interface #{device} ipv4-address #{network[:ip]} subnet-mask #{network[:netmask]}'")
            elsif network[:type].to_sym == :dhcp
              machine.communicate.execute("/bin/clish -s -c 'add dhcp client interface #{device}'")
            end
          end
        end
      end
    end
  end
end
