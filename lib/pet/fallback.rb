module BrighterPlanet
  module Pet
    module Fallback
      def self.included(base)
        base.class_eval do
          def self.fallback
            Species.fallback
          end
        end
      end
    end
  end
end
