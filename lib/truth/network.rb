module Truth
  class Network < Entity
    context Configuration, :plural => :networks do |network, config|
      # what to do when a new network is defined
      config.hosts.always do |host|
        network.addressables.track(host.interfaces) do |int|
          network.cidr.include? int.address
        end
      end
    end

    def cidr
      CIDR(name)
    end

    index(:addressable,
      :plural => :addressables,
      :name_key => :address_str
    )

    index :name_server, :plural => :name_servers
  end
end
