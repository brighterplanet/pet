Feature: Pet Committee Calculations
  The pet model should generate correct committee calculations

  Scenario Outline: Diet Size Committee
    Given a pet has "species.name" of "<species>"
    And it has "breed.name" of "<breed>"
    And it has "gender.name" of "<gender>"
    When emissions are calculated
    Then the diet_size committee should be close to <diet_size>, +/-1
    Examples:
      | species | breed  | gender | diet_size |
      |     dog | Collie | female |    753.2 |
