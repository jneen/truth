module Builders
  def configuration
    @configuration ||= Configuration.new
  end

  def new_host(context, *args)
    name, params = extract_args(args)

    name ||= Faker::Computer.hostname
    params[:loc] ||= Faker::Computer.loc

    Truth::Host.new(name, params)
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
