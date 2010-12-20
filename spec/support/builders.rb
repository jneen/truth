module Builders
  def config_version
    @config_version ||= 0
    @config_version += 1
  end

  def new_configuration
    Truth(config_version)
  end

  def new_host(*args)
    name, params = extract_args(args)
    conf = params[:conf] || configuration

    name ||= Faker::Computer.hostname
    params[:loc] ||= Faker::Computer.loc

    Truth::Host.new(conf, name, params)
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
