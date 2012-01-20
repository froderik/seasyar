require 'active_record'

module Seasyar
  
  class ActiveRecordStorage
    
    ## seasy storage implementation ##
    
    def name= name
      @name = name
    end
    
    def save target, weights, options = {}
      raise "source is not set" if options[:source].nil?
      source = options[:source] 
      
      old = SeasyData.find_all_by_source source
      old.each { |data| data.delete }
      
      weights.keys.each do |k|
        i = Seasyar::SeasyData.new
        i.key = k
        i.target = target
        i.source = source
        i.weight = weights[k]
        i.index_name = @name
        i.save!
      end
    end
    
    def search question
      # todo : count hits.....
      query_parts = question.split ' ' # TODO : split on other white spaces?
      result = {}
      query_parts.each do |query_part|
        hits = Seasyar::SeasyData.find_all_by_key_and_index_name query_part, @name
        hits.each do |one_hit|
          result[one_hit.target] = one_hit.weight
        end
      end
      result
    end
    
    def remove deletee
      Seasyar::SeasyData.find_all_by_source( deletee ).each {|data| data.delete}
    end
    
    ## helper methods ##
    
  end
end