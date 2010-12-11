module Truth
  class Host < Entity
    key :loc

    key :rack_unit
    key :rack
    key :datacenter
    index :interface, :plural => :interfaces do
      Interface.new(self)
    end
  end
end
