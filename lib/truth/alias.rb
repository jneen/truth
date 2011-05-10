module Truth
  class CName < Entity
    context Domain, :plural => :cnames

    key :target
  end
end
