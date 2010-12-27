module Truth
  Configuration.cache(:locatables) do
    Index.new(:name_key => :rack_slug)
  end

  module Locatable
    class << self
      def included(klass)
        klass.class_eval do
          key :rack_unit
          key :rack
          key :datacenter_name
          key :datacenter
        end

        klass.dsl_class.class_eval do
          def loc(l)
            @target.loc = l.to_s
          end
        end
      end
    end

    def rack_slug
      "u#{rack_unit}r#{rack}"
    end

    def on_change_loc(old, new)
      new =~ /^u(\d+)r(\d+)\.(\w+)$/
      self.rack_unit = $1.to_i
      self.rack = $2.to_i
      self.datacenter_name = $3.to_sym
      self.datacenter = configuration.datacenter(self.datacenter_name)

      configuration.locatables.update_membership(self)

      configuration.datacenters.each do |dc|
        dc.locatables.update_membership(self) do
          dc.name == self.datacenter_name
        end
      end
    end

  end
end
