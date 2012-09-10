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
      
      hash_for_create = weights.keys.map do |k|
        { :key => k, 
          :target => target, 
          :source => source, 
          :weight => weights[k], 
          :index_name => @name }
      end
      Seasyar::SeasyData.create hash_for_create
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