class PlaysController < ApplicationController
  def index

    dbScript = Script.where(user_id: 1)
    if (dbScript.empty?)
      @hasText = false
    else
    	
      @filename = File.join(Rails.root, "/public/uploads/" + dbScript[0].filename)
    	@projectName = dbScript[0].script_name
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
      @cues = Note.where(script_id: dbScript[0].id)
      
    end
  end

  def upload
    uploaded_io = params[:file]
    puts uploaded_io
    File.open(Rails.root.join('public', 'uploads', "1" + params[:q].delete(" ")), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    scriptLink = Script.new(script_name: params[:q], user_id: 1, filename: "1" + params[:q].delete(" "))
    if (scriptLink.save)
      redirect_to plays_index_path
    else
      puts "something went terribly, terribly, terribly wrong"
      redirect_to plays_index_path #need to change this later
    end
  end

  def cuesDB
    puts "something here so that we can see its actually doing something"
    dbScript = Script.where(user_id: 1)
    if (dbScript.empty?)
      render json: {"Failure" => "'You have no arms or legs!' 'Its just a flesh wound'"}
    else
      cuesLink = Note.new(
        user_id: 1, 
        script_id: dbScript[0].id,
        cueType: params[:cueType], 
        cueLabel: params[:cueLabel], 
        cueDescription: params[:cueDescription], 
        location: params[:location], 
        lineNum: params[:cueLineNum])
      
      if (cuesLink.save)
        render json: cuesLink
      else
        render json: {"Failure" => "Failure...JK! Success! wait...no....due to budget cuts you are indeed a....Success! No, FAILURE!!!"}
      end
    end
  end
end
