module LocationService
  def self.find(location_text)
    # Geocoder gem maintains its own cache which it will use if possible.
    results = Geocoder.search(location_text.to_s)

    # Geocoder will map certain zip codes, e.g. 90210 to foreign locations,
    # so for now, limit to just United States.
    results.select! { |result| result.country == "United States" }

    if results.any?
      # The first location will be the most specific and in the common case
      # is probably what the caller wants.
      results.first
    end
  end
end
