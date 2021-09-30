class BulkDiscountService
  class << self

    def next_three_holidays
      holidays.first(3)
    end

    def holidays
     response = conn.get("/api/v3/NextPublicHolidays/US")
     JSON.parse(response.body, symbolize_names: true)
   end

   def conn
     conn = Faraday.new(url: "https://date.nager.at")
   end
 end
end
