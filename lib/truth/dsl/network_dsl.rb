module Truth
  class Dsl
    class NetworkDsl < Dsl
      def name_server(host)
        orig_host = host
        host = case host
        when Host
          host
        else
          @target.configuration.host(host.to_sym)
        end

#p :name_servers => @target.name_servers
#  :hooks => @target.name_servers.hooks

        @target.name_servers << host
      end
    end
  end
end
