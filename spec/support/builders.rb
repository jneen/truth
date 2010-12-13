module Builders
  def configuration
    @configuration ||= Truth::Configuration.new(1)
  end

  def new_host(*args)
    name, params = extract_args(args)
    conf = params[:conf] || configuration

    name ||= Faker::Computer.hostname
    params[:loc] ||= Faker::Computer.loc

    Truth::Host.new(conf, name, params)
  end

  def new_configuration(ver=nil)
    Truth::Configuration.new(ver || rand(10))
  end

private
  def extract_args(args)
    if args.size == 2
      args
    else
      if args.first.is_a? Hash
        [nil, args.first]
      else
        [args.first, {}]
      end
    end
  end
end
