module VagrantPlugins
  module GuestGaia
    module Cap
      class ChangeHostName
        def self.change_host_name(machine, name)
          if !machine.communicate.test("/bin/clish -c 'show hostname' | grep '#{name}'")
            machine.communicate.execute("/bin/clish -s -c 'set hostname #{name}'")
          end
        end
      end
    end
  end
end
