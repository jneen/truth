module Faker
  module Lorem
    def word
      words(1).pop
    end
  end

  module Internet
    def ip(cidr=CIDR.all)
      cidr = CIDR(cidr)
      IP(cidr.min + rand(cidr.size))
    end

    def cidr
      CIDR(ip, 15 + rand(10))
    end
  end

  module Computer
    extend ModuleUtils
    extend self

    def mac_address
      (1..6).map { '%02X' % rand(256) }.join(':')
    end

    def loc
      city_abbr = Address.city.split.map(&:first).first(3).join.downcase
      "u#{1+rand(40)}r#{1+rand(10)}.#{city_abbr}"
    end

    def hostname
      Lorem.words(1).first + ("%02d" % rand(100))
    end

    def alias
      Lorem.words(2).join('-')
    end
  end
end
