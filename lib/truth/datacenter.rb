module Truth
  class Datacenter < Entity
    context Configuration, :plural => :datacenters

    includes :locatables do |dc, locatable|
      locatable.datacenter == dc.name
    end

    index :locatable, :name_key => :rack_slug, :plural => :locatables

    # -*- dsl methods -*-
    class DatacenterDsl < Dsl
      def switch(name, &blk)
        name = name.unchomp(".#{@target.name}")
        delegate :switch, name, &blk
      end
    end
  end
end
