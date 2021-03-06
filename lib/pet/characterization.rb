module BrighterPlanet
  module Pet
    module Characterization
      def self.included(base)
        base.characterize do
          has :species
          has :breed
          has :gender
          has :weight, :range => :weight_range.to_proc, :measures => :mass
          has :acquisition # TODO andy test start year
          has :retirement
        end
      end
    end
  end
end
