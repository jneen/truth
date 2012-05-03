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
    extend Faker::ModuleUtils
    extend self

    def mac_address
      (1..6).map { '%02X' % rand(256) }.join(':')
    end

    def loc
      "u#{10+rand(30)}r#{1+rand(10)}.#{datacenter}"
    end

    def datacenter
      letters = ('a'..'z').to_a
      (1..3).map { letters.rand }.join
    end

    def hostname
      Lorem.words(1).first + ("%02d" % rand(100))
    end

    def alias
      Lorem.words(2).join('-')
    end
  end
end
