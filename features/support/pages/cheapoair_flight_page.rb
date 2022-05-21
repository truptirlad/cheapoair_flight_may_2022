class CheapoairFlightPage
  include PageObject

  page_url "www.cheapoair.com"
  #page_url = $url


  link(:dep_suggestion_box, class: 'suggestion-box__clear icon', index: 0)
  link(:arr_suggestion_box, class: 'suggestion-box__clear icon', index: 1)
  text_field(:dep_airport_field, id: 'from0')
  text_field(:arr_airport_field, id: 'to0')
  unordered_list(:all_dep_suggested_airports, class: 'suggestion-box__list autoSuggest__list')
  unordered_list(:all_arr_suggested_airports, class: 'suggestion-box__list autoSuggest__list', index: 1)
  div(:dep_date, class: 'col-6 calendarDepart')
  div(:arr_date, class: 'col-6 calendarReturn')
  button(:search_flights, id: 'searchNow')
  list_items(:all_error_messages, class: 'alerts__item')

  def get_all_error_messages
    all_error_messages_elements.map(&:text)
  end

  def search_dep_airport dep_city, dep_airport
    dep_suggestion_box_element.click if dep_suggestion_box_element.present?
    #dep_airport_field_element.set dep_city
    self.dep_airport_field = dep_city
    sleep 1
    all_dep_suggested_airports_element.lis.each do |all_airports|
      p all_airports.text
      if all_airports.text.include? dep_airport
        all_airports.click
        break
      end
    end
  end

  def search_arr_airport arr_city, arr_airport
    arr_suggestion_box_element.click if arr_suggestion_box_element.present?
    # arr_airport_field_element.set arr_city
    self.arr_airport_field = arr_city
    sleep 1
    all_arr_suggested_airports_element.lis.each do |all_airports|
      p all_airports.text
      if all_airports.text.include? arr_airport
        all_airports.click
        break
      end
    end
  end

  def cal_date(no_of_days)
    (Time.now + 24 * 60 * 60 * no_of_days).strftime("%-d %B %Y")
  end

  def choose_dep_date(no_of_days)
    exact_date = cal_date no_of_days
    dep_date_element.click
    @browser.link(aria_label: exact_date).click
  end

  def choose_arr_date(no_of_days)
    exact_date = cal_date no_of_days
    arr_date_element.click
    @browser.link(aria_label: exact_date).click
  end

  def search_available_flights dep_city, dep_airport, arr_city, arr_airport
    search_dep_airport dep_city, dep_airport
    search_arr_airport arr_city, arr_airport
    choose_dep_date 2
    choose_arr_date 3
    search_flights_element.click
  end

end