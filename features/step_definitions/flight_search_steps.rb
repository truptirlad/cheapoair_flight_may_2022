Given(/^user is on the Cheapoair homepage$/) do
  visit CheapoairFlightPage
end

And(/^user search for (.*) city and selects (.*) airport for departure$/) do |dep_city, dep_airport|
  on(CheapoairFlightPage).search_dep_airport dep_city, dep_airport
end

And(/^user search for (.*) city and selects (.*) airport for arrival$/) do |arr_city, arr_airport|
  on(CheapoairFlightPage).search_arr_airport arr_city, arr_airport
end

And(/^user selects future date for departure$/) do
  on(CheapoairFlightPage).choose_dep_date 2
end

And(/^user selects future date for arrival$/) do
  on(CheapoairFlightPage).choose_arr_date 3
end

And(/^user searches for available flights$/) do
  on(CheapoairFlightPage).search_flights_element.click
end

Then(/^verify user should see the available flights$/) do
  # on(CheapoairFlightResultsPage).verify_flights_displayed?
  actual_value = on(CheapoairFlightResultsPage).get_flight_results_header
  on(CheapoairFlightResultsPage).verify_expected_value_exists? actual_value, 'results found'

  # expect(actual_value).should include 'results found'
end

When(/^user searches for the available flights for the future date$/) do
  # on(CheapoairFlightPage).search_available_flights "Columbus", "CMH - Columbus, Ohio", "Cleveland", "Cleveland, Ohio"
  on(CheapoairFlightPage) do |page|
    page.search_dep_airport dep_city, dep_airport
    page.search_arr_airport arr_city, arr_airport
    page.choose_dep_date 3
    page.choose_arr_date 6
    page.search_flights_element.click
    page.verify_flights_displayed?

  end

  When(/^user leaves departure and arrival city fields blank$/) do
    on(CheapoairFlightPage) do |page|
      page.dep_suggestion_box_element.click if page.dep_suggestion_box_element.present?
      page.arr_suggestion_box_element.click if page.arr_suggestion_box_element.present?
    end
  end

  Then(/^user should see the following error messages$/) do |table|
    # table is a table.hashes.keys # => [:Please enter a From city or airport]
    all_error_messages = on(CheapoairFlightPage).get_all_error_messages
    table.hashes.each do |each_error|
      current_error = each_error['error_messages']
      fail "#{current_error} message is NOT found in all the Errors - #{all_error_messages}" unless all_error_messages.include? current_error
    end
  end

  And(/^flight search results are displayed with sort order of price$/) do
    on(CheapoairFlightResultsPage).cheapest_flights_element.click
    all_prices = on(CheapoairFlightResultsPage).get_all_flights_prices
    fail "#{all_prices} are not in the Sort Order" unless all_prices == all_prices.sort
  end

  When(/^user searches for the available flights for the future date with yml data$/) do
    @data = YAML.load_file 'features/support/test_data/test_data.yml'
    p @data['dep_city_name']
    on(CheapoairFlightPage) do |page|
      page.search_dep_airport @data['dep_city_name'], ['dep_airport_name']
      page.search_arr_airport @data['arr_city_name'], ['arr_airport_name']
      page.choose_dep_date 3
      page.choose_arr_date 6
      page.search_flights_element.click
      page.verify_flights_displayed?
    end
  end
end
