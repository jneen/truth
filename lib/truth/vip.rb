module Truth
  class VIP < Entity
    include Addressable

    context Configuration, :plural => :vips

    class VIPDsl < Dsl
    end
  end
end
