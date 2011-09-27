module BrighterPlanet
  module Pet
    module Data
      def self.included(base)
        base.col :name
        base.col :species_id
        base.col :breed_id
        base.col :gender_id
        base.col :weight, :type => :float
        base.col :acquisition, :type => :date
        base.col :retirement, :type => :date

        base.data_miner do
          process "pull orphans" do
            BreedGender.run_data_miner!
          end
        end
      end
    end
  end
end