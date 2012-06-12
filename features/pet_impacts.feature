Feature: Pet Emissions Calculations
  The pet model should generate correct emission calculations

  Background:
    Given a pet

  Scenario Outline: Standard Calculations for pet
    Given it has "species.name" of "<species>"
    And it has "breed.name" of "<breed>"
    And it has "gender.name" of "<gender>"
    And it is the year "2010"
    When impacts are calculated
    Then the amount of "carbon" should be within "0.1" of "<emission>"
    Examples:
      | species | breed  | gender | emission |
      |     dog | Collie | female |   2272.4 |
