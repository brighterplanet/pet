require 'emitter'

module BrighterPlanet
  module Pet
    extend BrighterPlanet::Emitter
    def weight_range
      species.minimum_weight..species.maximum_weight if species
    end
  end
end
