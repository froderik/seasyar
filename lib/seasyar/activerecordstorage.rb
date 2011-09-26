require 'active_record'

module Seasyar
  
  class ActiveRecordStorage
    
    ## seasy storage implementation ##
    
    def save target, weights, options = {}
      source = target
      source = options[:source] unless options[:source].nil?
      
      old = SeasyData.find_all_by_source source
      old.each { |data| data.delete }
      
      weights.keys.each do |k|
        i = Seasyar::SeasyData.new
        i.key = k
        i.target = target
        i.source = source
        i.weight = weights[k]
        i.save!
      end
    end
    
    def search question
      # todo : count hits.....
      hits = Seasyar::SeasyData.find_all_by_key question
      result = {}
      hits.each do |one_hit|
        result[one_hit.target] = one_hit.weight
      end
      result
    end
    
    ## helper methods ##
    
  end
end