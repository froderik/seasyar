require 'seasyar'


class Dummy
  include Seasyar

  def initialize id, static
    @id = id
    @static = static
  end

  INDEX_NAME = "test_index_name"

  def save
    index INDEX_NAME, :static
  end

  def save_with_block
    index( INDEX_NAME, :static ) { 666 }
  end

  def removal
    unindex INDEX_NAME
  end

  def id
    @id
  end

  def static
    @static
  end
end

describe Seasyar do
  before :all do
    ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
    ActiveRecord::Base.establish_connection('development')

    Seasy.configure do |config|
      config.storage = Seasyar::ActiveRecordStorage
    end
  end

  before :each do
    Seasyar::SeasyData.all.each { |data| data.delete }
  end

  it "should save to index" do
    d = Dummy.new 42, 'static'
    d.save
    Seasyar.search( Dummy::INDEX_NAME, 'static' ).should == {42.to_s => 1}
  end

  it "should save source" do
    d = Dummy.new 144, 'diff'
    d.save_with_block
    Seasyar.search( Dummy::INDEX_NAME, 'diff' ).should == {666.to_s => 1}

    d.save # the 666 entry should be removed and 42 be there instead
    Seasyar.search( Dummy::INDEX_NAME, 'diff' ).should == {144.to_s => 1}
  end

  it "should remove from index" do
    d = Dummy.new 43, 'static'
    d.save
    d.removal
    Seasyar.search( Dummy::INDEX_NAME, 'static' ).should be_empty
  end
end