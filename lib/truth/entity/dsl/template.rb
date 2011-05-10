module Truth
  class Entity
    class Dsl
      module Template
        class TemplateDefinition
          def initialize(dsl)
            @templates = dsl.template_blocks
          end

          def method_missing(meth, name, &blk)
            @templates[:"#{meth}"] ||= {}
            @templates[:"#{meth}"][name] = blk
          end
        end

        def template_blocks
          @target.configuration.dsl_context.template_blocks
        end

        def templates(&blk)
          TemplateDefinition.new(self).instance_eval(&blk)
          template_blocks
        end

        def template(name)
          type = @target.class.name.demodulize.underscore.to_sym
          tpl = template_blocks[type]
          tpl &&= tpl[name.to_sym]

          instance_eval(&tpl) if tpl
        end
      end
    end
  end
end

__END__

template {
  host(:default) {
  }

  network(:default) {
  }
}
