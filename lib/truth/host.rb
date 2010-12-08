module Truth
  class Host < Entity
    key :loc

    index :interface, :plural => :interfaces do
      Interface.new(self)
    end
  end
end
