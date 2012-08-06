require 'emitter'

require 'pet/impact_model'
require 'pet/characterization'
require 'pet/data'
require 'pet/relationships'
require 'pet/summarization'

module BrighterPlanet
  module Pet
    extend BrighterPlanet::Emitter
    def weight_range
      species.minimum_weight..species.maximum_weight if species
    end
  end
end
