require 'open-uri'
require 'nokogiri'

cities = ['newyork']
specialties = ['php']
languige = ['en']

cities.each do |city|
  specialties.each do |specialty|

    # url = "https://newyork.craigslist.org/search/cpg?lang=en&query=developer&is_paid=all"
    url = "https://#{city}.craigslist.org/search/cpg?lang=#{languige}&query=#{specialty}&is_paid=all"

    document = open(url)
    content = document.read
    parsed_content = Nokogiri::HTML(content)

    # puts parsed_content
    # puts parsed_content.css('.content').css('.result-info').first.css('.result-title')

    puts '==================================================================='
    puts '--                                                               --'
    puts "--            #{city} --- #{specialty}                           --"
    puts '--                                                               --'
    puts '==================================================================='

    parsed_content.css('.content').css('.result-info').each do |row|
      # title = row.css('.result-title').inner_text
      title = row.css('.result-title').first.inner_text
      posted_at = row.css('time').first.attributes["datetime"].value
      neighborhood = row.css('.result-hood').inner_text
      link = row.css('.result-title').first.attributes["href"].value


      puts "#{title}#{neighborhood}"
      puts "Link at #{link}"
      puts "Posted at #{posted_at}"
      puts '------------------------------------------------'

    end
  end
end
