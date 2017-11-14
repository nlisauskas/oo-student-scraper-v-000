require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    cards = doc.css("div.roster-cards-container")
    cards.each do |card|
      card.css("div.student-card a").each do |student|
        name = cards.css(".student-name").text
        location = cards.css(".student-location").text
        profile_url = student.attr("href")
        students << {:name => name, :location => location, :profile_url => profile_url}
    end
  end
  students
  end

  def self.scrape_profile_page(profile_url)

  end

end
