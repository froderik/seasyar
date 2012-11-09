module Seasyar
  require 'seasy'

  def index index_name, *fields, &target_block
    has_changed = fields.detect do |one_field|
      changed_method = "#{one_field}_changed?".to_sym
      if self.respond_to? changed_method
        self.send changed_method
      else
        true
      end
    end

    if has_changed
      reindex index_name, *fields, &target_block
    end
  end

  def reindex index_name, *fields, &target_block
    index = Seasy::Index.with_name index_name.to_s

    value = aggregated_value fields

    source = "#{self.class}:#{self.id}"

    target = target_block ? target_block.call( self ) : self.id

    index.add value.to_s, target.to_s, :source => source
  end

  private
  def aggregated_value fields
    value = ''
    fields.each do |one_field|
      value << " #{self.send one_field }"
    end
    value
  end

  public
  def unindex index_name
    index = Seasy::Index.with_name index_name.to_s
    index.remove "#{self.class}:#{self.id}"
  end


  module_function
  def search index_name, query
    index = Seasy::Index.with_name index_name.to_s
    index.search query
  end


end
