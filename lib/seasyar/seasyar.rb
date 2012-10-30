module Seasyar
  require 'seasy'

  def index index_name, *fields
    index = Seasy::Index.with_name index_name.to_s

    has_changed = fields.detect do |one_field|
      self.send "#{one_field}_changed?".to_sym
    end

    if has_changed
      value = aggregated_value fields

      source = "#{self.class}:#{self.id}"

      target = block_given? ? yield( self ) : self.id

      index.add value.to_s, target.to_s, :source => source
    end
  end

  def aggregated_value fields
    value = ''
    fields.each do |one_field|
      value << " #{self.send one_field }"
    end
    value
  end

  def search index_name, query
    index = Seasy::Index.with_name index_name.to_s
    index.search query
  end

  def unindex index_name
    index = Seasy::Index.with_name index_name.to_s
    index.remove "#{self.class}:#{self.id}"
  end

  module_function :index, :search, :unindex
end
