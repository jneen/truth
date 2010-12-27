require_local 'dsl/*_dsl.rb'
require 'irb'

module Truth
  class Entity
    def console
      self.dsl_context.console
    end

    class Dsl
      include IRB::ExtendCommandBundle

      # ANSI codes
      ANSI_BLACK    = "\033[0;30m"
      ANSI_GRAY     = "\033[1;30m"
      ANSI_LGRAY    = "\033[0;37m"
      ANSI_WHITE    =  "\033[1;37m"
      ANSI_RED      ="\033[0;31m"
      ANSI_LRED     = "\033[1;31m"
      ANSI_GREEN    = "\033[0;32m"
      ANSI_LGREEN   = "\033[1;32m"
      ANSI_BROWN    = "\033[0;33m"
      ANSI_YELLOW   = "\033[1;33m"
      ANSI_BLUE     = "\033[0;34m"
      ANSI_LBLUE    = "\033[1;34m"
      ANSI_PURPLE   = "\033[0;35m"
      ANSI_LPURPLE  = "\033[1;35m"
      ANSI_CYAN     = "\033[0;36m"
      ANSI_LCYAN    = "\033[1;36m"

      ANSI_BACKBLACK  = "\033[40m"
      ANSI_BACKRED    = "\033[41m"
      ANSI_BACKGREEN  = "\033[42m"
      ANSI_BACKYELLOW = "\033[43m"
      ANSI_BACKBLUE   = "\033[44m"
      ANSI_BACKPURPLE = "\033[45m"
      ANSI_BACKCYAN   = "\033[46m"
      ANSI_BACKGRAY   = "\033[47m"

      ANSI_RESET      = "\033[0m"
      ANSI_BOLD       = "\033[1m"
      ANSI_UNDERSCORE = "\033[4m"
      ANSI_BLINK      = "\033[5m"
      ANSI_REVERSE    = "\033[7m"
      ANSI_CONCEALED  = "\033[8m"

      XTERM_SET_TITLE   = "\033]2;"
      XTERM_END         = "\007"
      ITERM_SET_TAB     = "\033]1;"
      ITERM_END         = "\007"
      SCREEN_SET_STATUS = "\033]0;"
      SCREEN_END        = "\007"

      def context_line
        p = @target.context.dsl_context.context_line
        m = @target.class.name.demodulize.underscore
        n = @target.name.inspect
        "#{p}.#{m}(#{n})"
      end

      def console
        @console = true
        old_prompt_mode = IRB.conf[:PROMPT_MODE]
        IRB.conf[:PROMPT][self] = {
          :PROMPT_I => "#{context_line}>> ",
          :PROMPT_S => "#{context_line}%l> ",
          :PROMPT_C => "#{context_line} > ",
          :PROMPT_N => "#{context_line} > ",
          :RETURN   => "#{ANSI_BOLD}=> %s#{ANSI_RESET}\n\n",
          :AUTO_INDENT => true
        }
        IRB.conf[:PROMPT_MODE] = self
        r = irb(self)
        IRB.conf[:PROMPT_MODE] = old_prompt_mode
        @console = false
        puts "^D"

        r.is_a?(IRB::Irb) ? @target : r
      end

      def initialize(target, options={})
        @target = target
        @console = !!options[:console]
      end

      def delegate(meth, name, &blk)
        @target.send(meth, name) do |obj|
          if blk
            obj.dsl_eval(&blk)
          elsif @console
            obj.console
          end
        end
      end
    end
  end
end
