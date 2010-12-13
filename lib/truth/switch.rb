module Truth
  class Switch < Entity
    include Locatable
    include Addressable

    context Datacenter, :plural => :switches

    def rack
      name.to_i
    end
  end
end
