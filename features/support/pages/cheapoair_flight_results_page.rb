class CheapoairFlightResultsPage
  require_relative '../modules/utilities_module'

  include PageObject
  include UtilitiesModule

  div(:flight_results_header, class: 'filters--content col-12 p-0')
  # list_item(:cheapest_flights, class: /col p-0 sort-tab__item is--tab-cheapest/)
  list_item(:cheapest_flights, class: "col p-0 sort-tab__item is--tab-cheapest")
  divs(:all_flights, class: 'fare-details__fare')

  def get_flight_results_header
    flight_results_header_element.when_present(90).text
  end

  def verify_flights_displayed?
    fail "Flight Search results NOT found" unless flight_results_header_element.when_present(90).text.include? 'results found'
  end

  def get_all_flights_prices
    sleep 3
    all_prices = []
    all_flights_elements.each do |each_price|
      all_prices << each_price.text.gsub('$', '').to_i
    end

    all_prices

  end

end