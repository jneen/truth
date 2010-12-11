module Truth
  class Interface < Entity
    context Host, :plural => :interfaces

    key :mac
    key :address
  end
end
