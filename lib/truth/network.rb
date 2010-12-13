module Truth
  class Network < Entity
    context Configuration, :plural => :networks

    def on_create
      addressables.import(configuration.addressables) do |addr|
        cidr.include? addr.address
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
