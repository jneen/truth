module Truth
  class Network < Entity
    context Configuration, :plural => :networks

    includes :addressables do |net, addr|
      net.cidr.include? addr.address
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
