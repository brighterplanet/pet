require 'characterizable'

module BrighterPlanet
  module Pet
    module Characterization
      def self.included(base)
        base.send :include, Characterizable
        base.characterize do
          has :species do |species|
            species.reveals :breed
          end
          has :gender
          has :weight, :range => :weight_range.to_proc, :measures => :mass
          has :acquisition # TODO andy test start year
          has :retirement
        end
        base.add_implicit_characteristics
      end
    end
  end
end
