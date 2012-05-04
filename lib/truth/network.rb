module Truth
  class Network < Entity
    context Configuration, :plural => :networks

    includes :addressables do |net, addr|
      net.cidr.include? addr.address
    end

    def cidr
      CIDR[name]
    end

    index(:addressable,
      :plural => :addressables,
      :name_key => :address_str
    )

    index :name_server, :plural => :name_servers

    class NetworkDsl < Dsl
      def name_server(host)
        orig_host = host
        host = case host
        when Host
          host
        else
          @target.configuration.host(host.to_sym)
        end

        @target.name_servers << host
      end
    end

  end
end
