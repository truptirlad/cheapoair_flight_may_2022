Feature: Cheapoair Flight search functionality

#  Imperative Style of Gherkin
  Scenario: verify user is able to search for the available flights for a future date
    Given user is on the Cheapoair homepage
    And user search for Columbus city and selects CMH - Columbus, Ohio airport for departure
    And user search for Cleveland city and selects CLE - Cleveland, Ohio airport for arrival
    And user selects future date for departure
    And user selects future date for arrival
    And user searches for available flights
    Then verify user should see the available flights

# Declarative style
  Scenario: verify user is able to search for the available flights for a future dates in Declarative style
    Given user is on the Cheapoair homepage
    When user searches for the available flights for the future date
    Then verify user should see the available flights

# Negative case:
  Scenario: Verify user is able to validate the mandatory search fields for ALL the fields for flight search
    Given user is on the Cheapoair homepage
    When user leaves departure and arrival city fields blank
    And user searches for available flights
    Then user should see the following error messages
      | error_messages                       |
      | Please enter a To city or airport.   |
      | Please enter a From city or airport. |
      | Please enter a Depart date.          |
      | Please enter a Return date.          |

  Scenario Outline: verify user is able to search for the available flights for a future dates for different locations
    Given user is on the Cheapoair homepage
    And user search for <dep_city_name> city and selects <dep_airport_name> airport for departure
    And user search for <arr_city_name> city and selects <arr_airport_name> airport for arrival
    And user selects future date for departure
    And user selects future date for arrival
    And user searches for available flights
    Then verify user should see the available flights
    Examples:
      | dep_city_name | dep_airport_name     | arr_city_name | arr_airport_name |
      | Columbus      | CMH - Columbus, Ohio | Cleveland     | Cleveland, Ohio  |
      | Milwaukee     | MKE                  | Los Angeles   | LAX              |

  Scenario: validate the flight search results are displayed with sort order of price
    Given user is on the Cheapoair homepage
    When user searches for the available flights for the future date
    Then verify user should see the available flights
    And flight search results are displayed with sort order of price