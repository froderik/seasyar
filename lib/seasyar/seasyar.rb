module Seasyar
  require 'seasy'

  def index index_name, *fields
    index = Seasy::Index.with_name index_name.to_s

    has_changed = fields.detect do |one_field|
      self.send "#{one_field}_changed?".to_sym
    end

    if has_changed
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
