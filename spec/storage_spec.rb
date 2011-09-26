$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'seasyar'
require 'seasy'
require 'active_record'

describe Seasyar::ActiveRecordStorage do
  before :all do
#    ActiveRecord::Base.logger = Logger.new('log/debug.log')
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
end