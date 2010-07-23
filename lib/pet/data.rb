require 'data_miner'

module BrighterPlanet
  module Pet
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            string   'name'
            string  'species_id'
            string  'breed_id'
            string  'gender_id'
            float    'weight'
            date     'acquisition'
            date     'retirement'
          end

          process "pull orphans" do
            BreedGender.run_data_miner!
          end

          process "pull dependencies" do
            run_data_miner_on_belongs_to_associations
          end
        end
      end
    end
  end
end
