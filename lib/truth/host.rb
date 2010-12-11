module Truth
  class Host < Entity
    context Configuration, :plural => :hosts

    key :loc

    key :rack_unit
    key :rack
    key :datacenter
  end
end
