module BrighterPlanet
  module Pet
    def self.included(base)
      base.extend ::Leap::Subject
      base.decide :emission, :with => :characteristics do
        committee :emission do
          quorum 'from diet size', :needs => [:diet_size, :diet_emission_intensity, :active_subtimeframe] do |characteristics, timeframe|
            characteristics[:active_subtimeframe].days * characteristics[:diet_size] * characteristics[:diet_emission_intensity] + ANNUAL_VETERINARY_EMISSION * (characteristics[:active_subtimeframe] / timeframe.year)
          end
        end
        
        committee :diet_emission_intensity do # kg/joule
          quorum 'from species', :needs => :species do |characteristics|
            characteristics[:species].diet_emission_intensity
          end
          
          quorum 'default' do
            ::Pet.fallback.diet_emission_intensity
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
            ::Pet.fallback.marginal_dietary_requirement
          end
        end
        
        committee :fixed_dietary_requirement do # joules
          quorum 'from species', :needs => :species do |characteristics|
            characteristics[:species].fixed_dietary_requirement
          end
    
          quorum 'default' do
            ::Pet.fallback.fixed_dietary_requirement
          end
        end
        
        committee :weight do # kg
          quorum 'from breed and gender', :needs => [:breed, :gender] do |characteristics|
            if breed_gender = BreedGender.find_by_breed_id_and_gender_id(characteristics[:breed], characteristics[:gender])
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
            ::Pet.fallback.weight
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
  end
end