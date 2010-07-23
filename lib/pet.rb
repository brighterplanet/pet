module BrighterPlanet
  module Pet
    extend self

    def included(base)
      require 'cohort_scope'
      require 'falls_back_on'
      require 'falls_back_on/active_record_ext'

      require 'pet/carbon_model'
      require 'pet/characterization'
      require 'pet/data'
      require 'pet/summarization'

      base.send :include, BrighterPlanet::Pet::CarbonModel
      base.send :include, BrighterPlanet::Pet::Characterization
      base.send :include, BrighterPlanet::Pet::Data
      base.send :include, BrighterPlanet::Pet::Summarization
    end
    def pet_model
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
