require 'pry'
require 'nokogiri'
require 'open-uri'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    doc = Nokogiri::HTML(open(index_url))
    doc.css("div.roster-cards-container").each do |card|
      card.css("div.student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = student.attr("href")
        students << {:name => name, :location => location, :profile_url => profile_url}
    end
  end
  students
  end

  def self.scrape_profile_page(profile_url)
    hash = {}
    doc = Nokogiri::HTML(open(profile_url))
    hash[:profile_quote] = doc.css(".profile-quote").text
    hash[:bio] = doc.css(".bio-content .description-holder p").text
    doc.css(".social-icon-container a").each do |platform|
      if platform.attr("href").value.include?("twitter")
        hash[:twitter] = platform.attr("href").value
      elsif platform.attr("href").value.include?("linkedin")
        hash[:linkedin] = platform.attr("href").value
      elsif platform.attr("href").value.include?("github")
        hash[:github] = platform.attr("href").value
      elsif platform.attr("href").value.include?("blog")
        hash[:blog] = platform.attr("href").value
      end
    end
    hash
  end

end
