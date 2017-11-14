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
    doc = Nokogiri::HTML(open(profile_url))
    twitter = doc.css(".social_icon_container").attr("href")
    linkedin = doc.css(".social_icon_container").attr("href")
    github = doc.css(".social_icon_container").attr("href")
    blog = doc.css(".social_icon_container").attr("href")
    profile_quote = doc.css(".profile_quote").text
    bio = doc.css(".bio-content content-holder .description-holder").text
    hash = {:twitter => twitter, :linkedin => linkedin, :github => github, :blog => blog, :profile_quote => profile_quote,
    :bio => bio}
    hash
  end

end
