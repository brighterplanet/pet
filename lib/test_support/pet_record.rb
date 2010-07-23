require 'pet'

class PetRecord < ActiveRecord::Base
  include Sniff::Emitter
  include BrighterPlanet::Pet
  
  belongs_to :species
  belongs_to :breed
  belongs_to :gender
  
  conversion_accessor :weight, :external => :pounds, :internal => :kilograms
  
  def scope_conditions_for(assoc)
    if assoc == :breeds and species
      { :species_id => species.id }
    else
      {}
    end
  end
  
  def weight_range
    species.minimum_weight..species.maximum_weight if species
  end
  
  class << self
    def fallback
      Species.fallback
    end
  end
end
