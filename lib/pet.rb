require 'emitter'

module BrighterPlanet
  module Pet
    extend BrighterPlanet::Emitter

    def self.pet_model
      if Object.const_defined? 'Pet'
        ::Pet
      elsif Object.const_defined? 'PetRecord'
        PetRecord
      else
        raise 'There is no pet model'
      end
    end
  end
end
