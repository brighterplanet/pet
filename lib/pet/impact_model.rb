# Copyright © 2010 Brighter Planet.
# See LICENSE for details.
# Contact Brighter Planet for dual-license arrangements.

require 'earth/pet/breed_gender'
require 'earth/pet/species'

require 'weighted_average'

module BrighterPlanet
  module Pet
    module ImpactModel
      def self.included(base)
        base.decide :impact, :with => :characteristics do
          committee :carbon do
            quorum 'from diet size', :needs => [:diet_size, :diet_emission_intensity, :active_subtimeframe] do |characteristics, timeframe|
              characteristics[:active_subtimeframe].days * characteristics[:diet_size] * characteristics[:diet_emission_intensity] + ANNUAL_VETERINARY_EMISSION * (characteristics[:active_subtimeframe] / timeframe.year)
            end
          end
          
          committee :diet_emission_intensity do # kg/joule
            quorum 'from species', :needs => :species do |characteristics|
              characteristics[:species].diet_emission_intensity
            end
            
            quorum 'default' do
              # sabshere 2/10/11 pulled from Species.fallback
              # kg CO2 / joule
              Species.weighted_average :diet_emission_intensity, :weighted_by => :population
            end
          end
          
          committee :diet_size do # joules
            quorum 'from weight', :needs => [:weight, :marginal_dietary_requirement, :fixed_dietary_requirement] do |characteristics|
              characteristics[:weight] * characteristics[:marginal_dietary_requirement] + characteristics[:fixed_dietary_requirement]
            end
          end
          
          committee :marginal_dietary_requirement do # joules/kg
            quorum 'from species', :needs => :species do |characteristics|
              characteristics[:species].marginal_dietary_requirement
            end
      
            quorum 'default' do
              # sabshere 2/10/11 pulled from Species.fallback
              Species.marginal_dietary_requirement_fallback
            end
          end
          
          committee :fixed_dietary_requirement do # joules
            quorum 'from species', :needs => :species do |characteristics|
              characteristics[:species].fixed_dietary_requirement
            end
      
            quorum 'default' do
              # sabshere 2/10/11 pulled from Species.fallback
              # force a zero intercept to be respectful of our tiny tiny animal friends
              0.0
            end
          end
          
          committee :weight do # kg
            quorum 'from breed and gender', :needs => [:breed, :gender] do |characteristics|
              if breed_gender = BreedGender.find_by_breed_name_and_gender_name(characteristics[:breed].name, characteristics[:gender].name)
                breed_gender.weight
              end
            end
            
            quorum 'from breed', :needs => :breed do |characteristics|
              characteristics[:breed].weight
            end
      
            quorum 'from species', :needs => :species do |characteristics|
              characteristics[:species].weight
            end
      
            quorum 'default' do
              # sabshere 2/10/11 pulled from Species.fallback
              # kg
              Species.weighted_average :weight, :weighted_by => :population
            end
          end
          
          committee :active_subtimeframe do
            quorum 'from acquisition and retirement', :needs => [:acquisition, :retirement] do |characteristics, timeframe|
              Timeframe.constrained_new characteristics[:acquisition].to_date, characteristics[:retirement].to_date, timeframe
            end
          end
          
          committee :acquisition do
            quorum 'from retirement', :appreciates => :retirement do |characteristics, timeframe|
              [ timeframe.from, characteristics[:retirement] ].compact.min
            end
          end
          
          committee :retirement do
            quorum 'from acquisition', :appreciates => :acquisition do |characteristics, timeframe|
              [ timeframe.to, characteristics[:acquisition] ].compact.max
            end
          end
        end
      end

      ANNUAL_VETERINARY_EMISSION = 0.00437.tons.to :kilograms # kg CO2e per https://brighterplanet.sifterapp.com/projects/30/issues/846/comments
    end
  end
end
