module Truth
  class VIP < Entity
    include Addressable

    context Configuration, :plural => :vips
  end
end
