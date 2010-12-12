module Truth
  class Datacenter < Entity
    context Configuration, :plural => :datacenters do |dc, config|
      dc.hosts.track(config.objects(Host)) do |host|
        host.datacenter.to_s == dc.name.to_s
      end
    end

    index :hosts, :name_key => :loc

    key :name
  end
end
