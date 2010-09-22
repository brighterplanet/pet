Feature: Pet Committee Calculations
  The pet model should generate correct committee calculations

  Scenario Outline: Diet Size Committee
    Given a pet emitter
    And characteristic "species.name" of "<species>"
    And characteristic "breed.name" of "<breed>"
    And characteristic "gender.name" of "<gender>"
    When the "weight" committee is calculated
    And the "marginal_dietary_requirement" committee is calculated
    And the "fixed_dietary_requirement" committee is calculated
    And the "diet_size" committee is calculated
    Then the conclusion of the committee should be "<diet_size>"
    Examples:
      | species | breed  | gender |    diet_size |
      |     dog | Collie | female | 5296105.0368 |
