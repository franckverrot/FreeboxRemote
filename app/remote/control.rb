module Remote
  class Control
    attr_accessor :connection

    def initialize(connection)
      @last_command = nil
      @connection = connection
      @connection.delegate = self
    end

    def send_command(key, is_long = false)
      puts "Sending key #{key}..."
      @connection.transmit key, is_long
    end

    def key_transmitted(result)
      puts "\t[OK -- Success? #{result.success?}]"
    end

    def key_transmission_error(exception)
      puts "\t[KO -- #{exception}]"
    end

    def commands
      %w(red green blue yellow
      power list tv
      1 2 3 4 5 6 7 8 9  0
      back swap info epg mail media help options pip vol_inc vol_dec ok up
      right down left
      prgm_inc prgm_dec
      mute home rec
      bwd prev play fwd next)
    end
  end
end
