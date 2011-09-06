require 'active_record'
require 'seasydata'

module Seasyar
  
  class ActiveRecordStorage
    
    ## seasy storage implementation ##
    
    def save target, weights
      weights.keys.each do |k|
        i = Seasyar::SeasyData.new
        i.key = k
        i.target = target
        i.weight = weights[k]
        i.save!
      end
    end
    
    def query question
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