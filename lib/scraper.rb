require 'open-uri'
require 'pry'

class Scraper
  
   
  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    
    students = []
    
    index_page.css("div.student-card").each do |student|
      students << {
        :name => student.css('.student-name').text,
        :location => student.css('.student-location').text,
        :profile_url => student.css("a").attribute("href").value
      }
 
    end
    students
  end


      



   
  


  def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    student = {}

    profile_page.css("div.social-icon-container").children.css("a").each do |link|
     
      if link.attribute("href").value.include?("twitter")
        student[:twitter] = link.attribute("href").value
      elsif link.attribute("href").value.include?("linkedin")
        student[:linkedin] = link.attribute("href").value
      elsif link.attribute("href").value.include?("github")
        student[:github] = link.attribute("href").value
      else  
        student[:blog] = link.attribute("href").value
      end
    end
        
      
    student[:profile_quote] = profile_page.css(".profile-quote").text
    student[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text
  
    student
  end

end

