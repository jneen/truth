module Truth
  class Datacenter < Entity
    context Configuration, :plural => :datacenters

    includes :locatables do |dc, locatable|
      locatable.datacenter == dc.name
    end

    index :locatable, :name_key => :loc, :plural => :locatables

    # -*- dsl methods -*-
    class DatacenterDsl < Dsl
      def switch(name, &blk)
        delegate :switch, name.to_i, &blk
      end
    end
  end
end
