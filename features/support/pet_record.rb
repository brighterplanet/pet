require 'pet'

class PetRecord < ActiveRecord::Base
  include BrighterPlanet::Emitter
  include BrighterPlanet::Pet
end
