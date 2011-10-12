Feature: Pet Committee Calculations
  The pet model should generate correct committee calculations

  Background:
    Given a pet

  Scenario Outline: Diet Size Committee
    Given characteristic "species.name" of "<species>"
    And characteristic "breed.name" of "<breed>"
    And characteristic "gender.name" of "<gender>"
    When the "weight" committee reports
    And the "marginal_dietary_requirement" committee reports
    And the "fixed_dietary_requirement" committee reports
    And the "diet_size" committee reports
    Then the conclusion of the committee should be "<diet_size>"
    Examples:
      | species | breed  | gender |    diet_size |
      |     dog | Collie | female | 5296105.0368 |
