require 'CSV'
require 'net/http'
require 'json'
require 'jsonpath'


$base_url = "http://foxtel-api.local"

$grades=Hash.new("Genre")




class Person
  def person_function
  puts "in genre_function"
 
  $grades = {:programeIds=>["1442992948", "1442992950"], "1442992948"=>{:start_date=>"2006-01-01T00:00:00.000Z", 
  :end_date=>"2021-01-01T00:00:00.000Z", :offerType=>"PPV-Promotion-699", 
  :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone"],  
  :title => "Test Asset for API_51_Automation1",  :providerId=>"Studio", 
  :Title=>"E2EAutomationAssetMovie", 
  :VideoFormat=>["SD", "HD"], 
    :genre=>"Entertainment:Bollywood", :ParentalRating=>"M", :Subtitled=>"false", :Year=>"2005", 
    :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"US", :Director=>"Genndy Tartakovsky",
    :Writer=>"testwriter",:Actor=>"Candi Milo", :SeasonNumber=>"634", :EpisodeNumber=>"10", 
     :EpisodeTitle=>"episode_bpm_fpe_of_tv_eps_", :assetId=>"1442992950", :Duration=>"P0Y0M0DT0H0M0.000S", 
     :AspectRatio=>"4x3", :Sound=>"Stereo", :trailerId=>"1442992950_T", 
     :title=>"Test Asset for API_51_Automation",:field_is_series_closed_captioned_en_0_value=>"0",
     :field_is_series_subtitled_en_0_value=>"0",:field_series_audience_rating_en_0_value=>"Spilled", 
     :field_series_audience_score_en_0_value=>"12", :field_series_critics_rating_en_0_value=>"Rotten",
     :field_series_critics_score_en_0_value=>"98",
     :field_series_presto_editorial_en_0_value=>"test",:field_series_presto_editorial_en_0_format=>"null",
     :field_total_number_of_programmes_en_0_value=>"1",:field_total_number_of_seasons_en_0_value=>"1",
     :series_id=>"111234",:actors_0_name=>"test",:maturity_rating=>"MA15+",:offers_0_id=>"121",
     :offers_0_window_start=>"2001-01-01T11:00:00",:offers_0_window_end=>"2021-01-01T11:00:00",
     :offers_0_window_status=>"now", :critics_score =>"98", :audience_score=>"12", :rating=>3,
     :bigpond_score=>3, :id=>"111234", :series_role=>"writer" ,
     :type=>"Genre",
    
   }
 }

    $i=0
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/person_csv_file.csv", :headers => true) do |col|
      puts "in do loop after reading csv"
      puts ""
    @test_id = col[0]
    partial_relative_path="#{$grades[$grades[:programeIds][0]][:Writer]}"
    #puts "partial_relative_path is #{partial_relative_path}"
    #puts "read partial_relative_path"
    relative_path="/person/#{partial_relative_path}"
    #puts "read relative_path is #{relative_path}"
    @request_url=$base_url + relative_path
    #puts "request_url is #{@request_url}"
    @path = col[2]
    @hash_key= col[1]
    @validation=col[3]
    response = Net::HTTP.get_response(URI.parse(@request_url))
    $element = JsonPath.new(@path).on(JSON.parse(response.body))
    #puts "value of actual response is:=>#{element[0]}"
    p2 = $grades[@hash_key]
    #puts "value of hash key is :=> #{p2}"
    
    def validate_200
        puts "in function validate_200"
        $element.each do |url|
           puts "url is #{url}"
              if url.include?"?"
                 puts "1st Type Bad URI"
                 urlStr=url.gsub(/\{\w*[?]\}/, '')
                 url = URI.parse(urlStr)
                 puts "1st type of URI is #{url}"
                 res = Net::HTTP.get_response(URI.parse(url))

          
          #res.code == "200"
          #puts res.code
              elsif(!url.include?"http://foxtel-api.local")
                 puts "2nd Type Bad URI"
                 res = Net::HTTP.get_response(URI.parse(url))
          
                 url = URI.parse("http://foxtel-api.local"+url)

              else 
                 puts "good url" 
                 res = Net::HTTP.get_response(URI.parse(url))
              end
            #puts "url is #{url}"
            #puts res.code
              if res.code == "200"
                 puts "yes"
              else
                 puts "the value of incorrect res code is #{res.code}"
                 $i=$i+1

              end
          
        end
    end

    def validate_value
        puts "in function validate_value"

        if $grades[$grades[:programeIds][0]][:"#{@hash_key}"].is_a?(Array)
        	if $grades[$grades[:programeIds][0]][:"#{@hash_key}"][0]==$element[0]|| $grades[$grades[:programeIds][0]][:"#{@hash_key}"][0]=="null"
        	  elsif $grades[$grades[:programeIds][0]][:"#{@hash_key}"][0]!=$element[0]
        		  puts "value not matched for the key :=> #{@hash_key} "
              puts "value of json key is #{$element[0]}"
              puts "value of hash key is #{$grades[$grades[:programeIds][0]][:"#{@hash_key}"][0]}"
        		  $i=$i+1
        	end
        else
        	if $grades[$grades[:programeIds][0]][:"#{@hash_key}"]==$element[0]|| $grades[$grades[:programeIds][0]][:"#{@hash_key}"]=="null"
        	  elsif $grades[$grades[:programeIds][0]][:"#{@hash_key}"]!=$element[0]
        		  puts "value not matched for the key :=> #{@hash_key}"
              puts "value of json key is #{$element[0]}"
              puts "value of hash key is #{$grades[$grades[:programeIds][0]][:"#{@hash_key}"]}"
        		  $i=$i+1
        	end

        			

         end

     end

    if @validation=="200"
       validate_200
    end

    if @validation=="value"
       validate_value
    end

  end
    if $i>0
       puts "API call fails"
    end


  end
end
 
 person=Person.new
 person.person_function
