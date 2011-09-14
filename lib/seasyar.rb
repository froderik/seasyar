require 'activerecordstorage'
require 'seasydata'

module Seasyar
  require 'seasy'
  
  def index index_name, *fields
    index = Seasy::Index.with_name index_name.to_s
    fields.each do |one_field|
      value = self.send one_field
      index.add value.to_s, self.id.to_s  
    end
  end  
  
  def search index_name, query
    index = Seasy::Index.with_name index_name.to_s
    index.search query
  end
  
  module_function :index, :search
end
