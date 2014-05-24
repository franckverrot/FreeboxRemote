module Remote
  class Connection
    attr_accessor :delegate, :code

    def initialize(code)
      @code = code
    end

    def transmit key, long_press
      begin
        machine = "hd1"
        query = "http://#{machine}.freebox.fr/pub/remote_control?code=#{@code}&key=#{key}#{long_press ? '&long=true' : ''}"
        BW::HTTP.get(query) do |response|
          delegate.key_transmitted(response)
        end
      rescue Exception => e
        delegate.key_transmission_error(e)
      end
    end
  end
end
