module BrighterPlanet
  module Pet
    module Relationships
      def self.included(target)
        target.belongs_to :species
        target.belongs_to :breed
        target.belongs_to :gender
      end
    end
  end
end
