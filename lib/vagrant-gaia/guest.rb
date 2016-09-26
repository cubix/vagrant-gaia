require "vagrant"

module VagrantPlugins
  module GuestGaia
    class Guest < Vagrant.plugin("2", :guest)
      def detect?(machine)
        machine.communicate.test("/bin/clish -c 'show version product' | grep 'Gaia'")
      end
    end
  end
end
