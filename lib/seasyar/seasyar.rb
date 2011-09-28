module Seasyar
  require 'seasy'
  
  def index index_name, *fields
    index = Seasy::Index.with_name index_name.to_s
    
    value = ''
    fields.each do |one_field|
      value << " #{self.send one_field }"
    end
    
    target = self.id
    source = "#{self.class}:#{target}"

    if block_given?
      target = yield self
    end
    index.add value.to_s, target.to_s, :source => source
  end  
  
  def search index_name, query
    index = Seasy::Index.with_name index_name.to_s
    index.search query
  end
  
  def remove index_name
    index = Seasy::Index.with_name index_name.to_s
    index.remove "#{self.class}:#{self.id}"
  end
  
  module_function :index, :search, :remove
end
