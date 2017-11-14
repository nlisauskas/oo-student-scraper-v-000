require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css(".roster-cards-container")
    cards.each do |card|
      card.css(".student-card a").each do |student|
        name = cards.css(".student-name").text
        city = cards.css(".student-location").text
        profile_url = student.attr("href")
        students << {:name => name, :location => city, :profile_url => profile_url}
    end
  end
  students
  end

  def self.scrape_profile_page(profile_url)

  end

end
