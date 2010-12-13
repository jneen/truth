module Truth
  class Datacenter < Entity
    context Configuration, :plural => :datacenters

    includes :locatables do |dc, locatable|
      locatable.datacenter == dc.name
    end

    index :locatable, :name_key => :loc, :plural => :locatables
  end
end
