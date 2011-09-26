module Seasyar
  require 'seasy'
  
  def index index_name, *fields
    index = Seasy::Index.with_name index_name.to_s
    fields.each do |one_field|
      value = self.send one_field
      target = self.id
      if block_given?
        target = yield self
      end
      index.add value.to_s, target.to_s  
    end
  end  
  
  def search index_name, query
    index = Seasy::Index.with_name index_name.to_s
    index.search query
  end
  
  module_function :index, :search
end
