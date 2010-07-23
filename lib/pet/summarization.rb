require 'summary_judgement'

module BrighterPlanet
  module Pet
    module Summarization
      def self.included(base)
        base.extend SummaryJudgement
        base.summarize do |has|
          has.adjective lambda { |pet| "#{pet.weight_in_pounds.adaptive_round}-pound"}, :if => :weight
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
