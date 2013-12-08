require 'Spec_helper'

describe RatingParser do

  let(:rp) { RatingParser.new }

  it "should create a user" do
    rp.parse 'data/sample1.dat'
    rp.users.size.should eq(1)
    rp.users[0].films.size.should eq(1)
    rp.users[0].films[1192].should eq(5)
  end

  it "should create a list of user and films" do
    rp.parse 'data/sample10.dat'
    rp.users.size.should eq(1)
    rp.users[0].films.size.should eq(10)
  end

  it "should connect users and films" do
    rp.parse 'data/sample20000.dat'
    rp.users.size.should eq(149)
    rp.users[0].films[1192].should eq(5)
    rp.users[70].films[3716].should eq(4)
    rp.users[0].films[1196].should eq(3)
  end

  it "should be connected to the same movie" do
    rp.parse 'data/sample20000.dat'
    rp.users[0].films[1192].should eq(rp.users[1].films[1192])
  end

  it "should combine to one hash" do
    h1 = {[1,2]=>[1], [2,4]=>[2], [1,4]=>[3]}
    h2 = {[1,2]=>[2], [2,4]=>[2], [1,4]=>[1]}

    rp.connections = h1
    rp.connect h2

    rp.connections.should eq({[1,2]=>[1,2], [2,4]=>[2,2], [1,4]=>[3,1]})
  end

  it "should create a hash of connections" do
    h = {[1,2]=>[1,2], [2,4]=>[2,3], [1,4]=>[3,1]}
    rp.connections = h
    rp.uncontract 
    rp.connections.should eq({[1,2]=>1.5,[2,4]=>2.5,[1,4]=>2})
  end

  ## functional tests
  it "should create a graph", :focus do
    g = rp.parse 'data/sample20000.dat'
    lk = LinKerlin.new g
    lk.N = 3
    lk.calculate
    puts g
  end

end
