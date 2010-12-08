module Truth
  class Network < Entity
    context Configuration, :plural => :networks do |network, config|
      # what to do when a new network is defined
      config.hosts.hook :after_add do |host|
        host.interfaces.hook :after_add do |interface|
          network.interfaces << interface
        end
      end
    end

    key :cidr do |cidr|
      CIDR(cidr)
    end
  end
end
