require 'seasyar'


class Dummy 
  include Seasyar

  INDEX_NAME = "test_index_name" 

  def save
    index INDEX_NAME, :static
  end
  
  def save_with_block
    index( INDEX_NAME, :static ) {|unused| 666}
  end
  
  def id
    42
  end
  
  def static 
    'static'
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
  
  it "should save to index" do
    d = Dummy.new
    d.save
    Seasyar.search( Dummy::INDEX_NAME, 'static' ).should == {42.to_s => 1}
  end
  
  it "should save source" do
    d = Dummy.new
    d.save_with_block
    Seasyar.search( Dummy::INDEX_NAME, 'static' ).should == {666.to_s => 1}
    
    d.save # the 666 entry should be removed and 42 be there instead
    Seasyar.search( Dummy::INDEX_NAME, 'static' ).should == {42.to_s => 1}
  end
end