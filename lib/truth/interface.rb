module Truth
  class Interface < Entity
    context Host, :plural => :interfaces

    def on_change_address(old, new)
      configuration.networks.each do |net|
        if net.cidr.include? new
          net.interfaces << self
        else
          net.interfaces.delete(self)
        end
      end
    end

    key :mac
    key :address
  end
end
