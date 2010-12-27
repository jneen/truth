module Truth
  class Switch < Entity
    include Locatable
    include Addressable

    name_key :loc
    context Datacenter, :plural => :switches

    alias datacenter context
  end
end
