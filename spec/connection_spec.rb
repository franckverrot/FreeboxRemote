describe "Remote::Connection" do
  it "is built with a code that responds to #to_s" do
    Remote::Connection.new("foo")

    should.raise(ArgumentError) do
      Remote::Connection.new(Class.new do
        def to_s
          raise
        end
      end.new)
    end
  end
end
