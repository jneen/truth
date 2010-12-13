module Truth
  class Host < Entity
    context Configuration, :plural => :hosts
    include Locatable
  end
end
