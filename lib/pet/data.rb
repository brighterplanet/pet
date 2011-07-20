module BrighterPlanet
  module Pet
    module Data
      def self.included(base)
        base.force_schema do
          string   'name'
          string  'species_id'
          string  'breed_id'
          string  'gender_id'
          float    'weight'
          date     'acquisition'
          date     'retirement'
        end

        base.data_miner do
          process "pull orphans" do
            BreedGender.run_data_miner!
          end
        end
      end
    end
  end
end
