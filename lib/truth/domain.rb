module Truth
  class Domain < Entity
    context Configuration, :plural => :domains

    includes :nameables do |dom, nb|
      nb.domain == self
    end

    index :nameable, :plural => :nameable

    class DomainDsl < Dsl
      def a(name, ip)
      end

      def cname(name, target)
        @target.cname(name.to_sym, target.to_sym) 
      end
    end
  end
end
