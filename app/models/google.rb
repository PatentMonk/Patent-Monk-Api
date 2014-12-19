class Google < ActiveRecord::Base
  def self.scrape(href,patent_id)
    begin
      doc = Nokogiri::HTML(open(href))
      if doc.css('heading').length > 0
        tag = ''
        fb_description = ''
        description = doc.css('heading').map do |f|
          paragraphs = []
          f.css('~ *').each_with_index do |x,i|
            if ((x.name == "heading" && i != 0 && tag != 'header') || (x.name == 'description-of-drawings'))
              tag = 'header'
              break
            elsif x.name == 'p'
              tag = 'p'
              if x.attributes["num"]
                paragraphs << {text: x.to_html.strip, id: x.attributes["num"].value}
                fb_description += " #{x.text}"
              else
                paragraphs << {text: x.to_html.strip, id: "pm-#{i}"}
                fb_description += " #{x.text}"
              end
            elsif tag == 'header' #if two headers are one right after another
                break
            end
          end
          paragraphs = [] if paragraphs.nil?
          { title: f.text.strip, title_slug: f.text.strip.underscore.split(' ').join('_'), paragraphs: paragraphs}
        end
        fb_description = fb_description[0..255] + '...'
      else
        description = [{title: "Description", title_slug: 'descripBlock', paragraphs: [{text: doc.css('.patent-description-section').to_html, id: 'old'}]}]
        fb_description = doc.css('.patent-description-section').text[0..255] + '...'
      end
    rescue 
      description = [{title: "Description Not Found", title_slug: 'description_not_found', paragraphs: [{text: "This patent was not found.\n Please check the number and try again", id: 'lifeBoat'}]}]
      fb_description = "This patent was not found.\n Please check the number and try again"
    end
    abstract = doc.css('abstract').to_html rescue "Not Found"
    abstract = nil if abstract == ''
    if doc && doc.css('#classifications')
      classification = doc.css('#classifications').css('~ table.patent-data-table').to_html
    else
      classification = nil
    end
    drawing_description = doc.css('description-of-drawings').to_html rescue ""
    title = doc.css(".patent-title").text.strip rescue "Not Found"
    number = doc.css(".patent-number").text.strip rescue "N/A"
    begin
      table = doc.css(".patent-bibdata tr:not(.patent-bibdata-group-spacer):not(.alternate-patent-number):not(.patent-internal-links)")
      replace = table.css('td[colspan="2"]:not(.patent-bibdata-external-link-spacer-top)').css('span:not(.patent-bibdata-value):not(.patent-bibdata-heading)')
      replace[0].name = 'td'
      table.css('td[colspan="2"]:not(.patent-bibdata-external-link-spacer-top)').css('span:not(.patent-bibdata-value):not(.patent-bibdata-heading)').remove
      table.css('td[colspan="2"]:not(.patent-bibdata-external-link-spacer-top)')[0].parent.add_child(replace)
      table.css('td[colspan="2"]:not(.patent-bibdata-external-link-spacer-top)').xpath('.//@colspan').remove
      application = table.css('td.single-patent-bibdata')[1].text == 'Application' ? true : false
      table = table.to_s
    rescue 
      table = nil
    end
    images = doc.css(".patent-thumbnail-image").map{|f| t = f[:src].split("thumbnails/"); t.length > 0 ? t[0] + t[1] : t[0]} rescue []
    if doc && doc.css('#forward-citations')
      referenced = doc.css('#forward-citations').css("~ .patent-data-table").to_html rescue nil
      referenced += doc.css('#forward-citations').css("~ .patent-section-footer").to_html
    else
      referenced = nil
    end
    if doc && doc.css('#backward-citations')
      citations = doc.css('#backward-citations').css("~ .patent-data-table").to_html rescue nil
      citations += doc.css('#backward-citations').css("~ .patent-section-footer").to_html
    else
      citations = nil
    end
    if doc && doc.css('.patent-claims-section')
      claims = doc.css('.patent-claims-section').css(".claims").to_html rescue nil
    else
      claims = nil
    end
    if doc && doc.css('#legal-events')
      legal_events = doc.css('#legal-events').css("~ .patent-data-table").to_html
    else
      legal_events = nil
    end
    
    return {application: application, fb_description: fb_description, abstract: abstract, claims: claims, legal_events: legal_events, title: title, number: number, table: table, images: images,description: description, referenced: referenced, citations: citations, classification: classification}
  end

  def self.simple_scrape(href)

    begin
      doc = Nokogiri::HTML(open(href))
      if doc.css('heading').length > 0
        tag = ''
        description = ''
        doc.css('heading').map do |f|
          f.css('~ *').each_with_index do |x,i|
            if ((x.name == "heading" && i != 0 && tag != 'header') || (x.name == 'description-of-drawings'))
              tag = 'header'
              break
            elsif x.name == 'p'
              tag = 'p'
              if x.attributes["num"]
                description += " #{x.text}"
              else
                description += " #{x.text}"
              end
            elsif tag == 'header' #if two headers are one right after another
                break
            end
          end
        end
        description = description[0..255] + '...'
      else
        description = doc.css('.patent-description-section').text[0..150] + '...'
      end
    rescue
      description = "This patent was not found.\n Please check the number and try again"
    end
    title = doc.css(".patent-title").text.strip rescue "Not Found"
    title = title[0..50] + '...'  if title.length > 50
    image = doc.css(".patent-thumbnail-image").map{|f| t = f[:src].split("thumbnails/"); t.length > 0 ? t[0] + t[1] : t[0]}[0] rescue ''
    {title: title, description: description, image: image}
  end
end