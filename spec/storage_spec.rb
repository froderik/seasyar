$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'seasyar'
require 'seasy'
require 'active_record'

describe Seasyar::ActiveRecordStorage do
  before :all do
    ActiveRecord::Base.configurations = YAML::load(IO.read('db/config.yml'))
    ActiveRecord::Base.establish_connection('development')
  end
  
  it "should save entries and make them searchable" do
    target = 1
    weights = Fragmentizer.new.fragmentize 'test'
    subject.save target, weights
    subject.search( 'es' ).should == {"1" => 1}
  end
  
  it "should remove entries when saving new ones" do
    target = 1
    weights = Fragmentizer.new.fragmentize 'test'
    subject.save target, weights
    
    weights = Fragmentizer.new.fragmentize 'different'
    subject.save target, weights
    
    subject.search( 'es' ).should == {}    
  end
  
  it "should accept a source as basis for what to delete in between adding" do 
    Seasy.configure do |config|
      config.storage = Seasyar::ActiveRecordStorage
    end
    i = Seasy::Index.new 
    i.add 'ruben', 'landsnora', :source => 'veddesta'
    i.search( 'ruben' ).should == {'landsnora' => 1}
    
    i.add 'ruben', 'edsberg'
    i.search( 'ruben' ).should == {'landsnora' => 1, 'edsberg' => 1}
    
    i.add 'sten', 'landsnora', :source => 'veddesta'
    i.search( 'ruben' ).should == {'edsberg' => 1}
    
    i.add 'sten', 'edsberg' 
    i.search( 'ruben' ).should == {}
  end
end