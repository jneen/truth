module Truth
  class Interface < Entity
    include Addressable

    context Host, :plural => :interfaces

    key :mac
  end
end
