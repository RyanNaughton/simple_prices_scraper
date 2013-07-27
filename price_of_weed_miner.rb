require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'csv'

base_url = "http://www.priceofweed.com/data/all?pg="

#csv = CSV.new([])
CSV.open("weed_prices.csv", "wb") do |csv|
  
  csv << ["Location", "Price", "Quantity", "Quality","Date"]
  #10922
  (1..1000).each do |i|
    begin
      p i
      url = base_url + i.to_s
      doc = Nokogiri::HTML(open(url))
      doc.css('tr').each do |row|
        csv << row.css('td').map{|x| x.text}
      end
    rescue Exception => e
      p "Page #{i} failed at #{Time.now.utc} because of #{e.message}"
    end
  end
end
