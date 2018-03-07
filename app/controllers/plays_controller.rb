class PlaysController < ApplicationController
  def index
  	@filename = File.join(Rails.root, "/public/sample1.pdf")
  	#send_file(filename, :filname => "sample.pdf", :type => "application/pdf", disposition: "inline")
  	reader = PDF::Reader.new(@filename)
  	puts reader.pdf_version
    puts reader.info
    puts reader.metadata
    puts reader.page_count
    @text = ""
    reader.pages.each do |page|
      # puts page.fonts
      # puts page.text
      @text += page.text
      # puts page.raw_content
  	end
  	@hasText = true
  	
  end

  def upload
  	
  end

end
