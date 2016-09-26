module VagrantPlugins
  module GuestGaia
    module Cap
      class Halt
        def self.halt(machine)
          begin
            machine.communicate.execute("/sbin/poweroff")
          rescue IOError, Vagrant::Errors::SSHDisconnected
            # Ignore, this probably means connection closed because it
            # shut down.
          end
        end
      end
    end
  end
end
