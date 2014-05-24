describe "Remote::Control" do
  it "takes a connection that can delegate" do
    conn = Class.new do
      attr_writer :delegate
    end.new
    Remote::Control.new(conn)

    conn = Class.new do
      attr_writer :delegate
    end.new
    should.raise(Exception) { Remote::Control.new(Object.new) }
  end
end
