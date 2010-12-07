module BrighterPlanet
  module Pet
    module Summarization
      def self.included(base)
        base.summarize do |has|
          has.adjective lambda { |pet| "#{pet.weight.convert(:kilograms, :pounds).round(1)}-pound"}, :if => :weight
          has.adjective [:gender, :name], :if => :gender
          has.adjective [:breed, :name], :if => :breed
          has.identity [:species, :name], :if => :species
          has.identity
          has.verb :own
        end
      end
    end
  end
end
