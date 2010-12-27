module Truth
  class Switch < Entity
    include Locatable
    include Addressable

    context Datacenter, :plural => :switches

    alias datacenter context

    def datacenter_name
      datacenter.name
    end

    def on_create
      @name =~ /^u(\d+)r(\d+)/
      self.rack_unit = $1.to_i
      self.rack = $2.to_i
    end
  end
end
