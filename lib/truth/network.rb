module Truth
  class Network < Entity
    context Configuration, :plural => :networks do |network, config|
      # what to do when a new network is defined
      config.hosts.each do |host|
        network.interfaces.track(host.interfaces) do |int|
          network.cidr.include? int.address
        end
      end

      config.hosts.hook :add do |host|
        network.interfaces.track(host.interfaces) do |int|
          network.cidr.include? int.address
        end
      end
    end

    key :cidr do |cidr|
      CIDR(cidr)
    end
  end
end
