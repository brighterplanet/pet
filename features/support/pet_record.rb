require 'pet'

class PetRecord < ActiveRecord::Base
  include Sniff::Emitter
  include BrighterPlanet::Pet
end
