require 'CSV'
require 'net/http'
require 'json'
require 'jsonpath'


$base_url = "http://foxtel-api.local"

$grades=Hash.new("Offer")




class Offer
  def offer_function
    puts "in offer_function"

      def validate_200
          puts "in function validate_200"
          $element.each do |url|
           puts "url is #{url}"
           if url.include?"?"
             puts "1st Type Bad URI"
             urlStr=url.gsub(/\{\w*[?]\}/, '')
             url = URI.parse(urlStr)
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
         #puts "#{$grades[value][:start_date]}"
         
         if $grades[$value][:"#{@hash_key}"].is_a?(Array)
          puts "in the array type key value"
           if $grades[$value][:"#{@hash_key}"][0]==$element[0]|| $grades[$value][:"#{@hash_key}"]=="null"
           elsif $grades[$value][:"#{@hash_key}"][0]!=$element[0]
            puts "value not matched for the key :=> #{@hash_key} "
            puts "value of json key is #{$element[0]}"
            puts "value of hash key is #{$grades[$value][:"#{@hash_key}"][0]}"
            $i=$i+1
          end
        else
          if $grades[$value][:"#{@hash_key}"]==$element[0]|| $grades[$value][:"#{@hash_key}"]=="null"
          elsif $grades[$value][:"#{@hash_key}"]!=$element[0]
            puts "value not matched for the key :=> #{@hash_key}"
            puts "value of json key is #{$element[0]}"
            puts "value of hash key is #{$grades[$value][:"#{@hash_key}"]}"
            $i=$i+1
          end



        end

      end

    $grades = {:assetIds=>{":1446531542_T_SD"=>"5zMTZseDpA9-zfIDhEf3ILx8CQ8xp746", 
      ":1446531540_SD"=>"p3MTZseDqRCoI9d3eZcxwBEyNn3EGEfb", ":1446531540_T_SD"=>"NxMTZseDo1XBDhTXb0pF_mhIM2NBqMv-", 
      ":1446531542_SD"=>"83MjZseDqulcjpnHIaXZlTIpZhSJFJPQ", ":1446531544_HD"=>"ZuMjZseDo7RCAaTVAteAbpwPa3LFBFsS", 
      ":1446531540_HD"=>"oxMjZseDrVDJjyilugKRR4VW_r3qKtuW", ":1446531544_T_SD"=>"9qMjZseDr2zTpuHPlvdJSUxUlzyJjbjG", 
      ":1446531544_SD"=>"ZsMjZseDrQBKcoA26YIQYHq4YXvfS3Vr", ":1446531542_HD"=>"81MjZseDo-0OHi5WmNMZAydl3bdvqLVU"}, 
      :programeIds=>["1446531540", "1446531542", "1446531544"], 
      "1446531540"=>{:window_start=>"78788",:start_date=>"2001-01-01T11:00:00", :end_date=>"2021-01-01T11:00:00.000Z", 
        :offerType=>"PPV-Promotion-699", :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", 
          "tablet", "phone", "pc_mac", "pc_mac_play", "connTV"], :showID=>"1446531541", :category=>"TV_EPS", 
          :programmeId=>"1446531540", :providerId=>"SON", :groupId=>"1446531542", 
          :Title=>"E2EAutomationAssetTvEps_1446531540", :VideoFormat=>["SD", "HD"], 
          :genre=>"Entertainment:Bollywood", :MaturityRating=>"G", :Subtitled=>"false", :Year=>"2003", 
          :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"JP", ":Director"=>"Dadasaheb Phalake", 
          ":Actor"=>"Prasad Oak", ":Writer"=>"Subodh Bhave", :SeasonNumber=>"653", :EpisodeNumber=>"10", 
          :EpisodeTitle=>"E2EAutomationEpisode_1446531540", 
          :ShortSynopsis=>"An experiment in advanced weather technology has turned farmland ", 
          :LongSynopsis=>"An experiment in advanced weather technology has turned a desert 
          canyon into fertile farmland ", :assetId=>"1446531540", :Duration=>"P0Y0M0DT0H0M0.000S", 
          :AspectRatio=>"4x3", :Sound=>"Stereo", :trailerId=>"1446531540_T",:offer_node_HD=>"6811"}, 

          "1446531542"=>{:start_date=>"2006-01-01T00:00:00", :end_date=>"2025-01-01T00:00:00", 
            :offerType=>"Subscription", 
            :deviceId=>["0e567a24f3d2f576b055604b07938e056a2cb9d1", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone", "pc_mac",
             "pc_mac_play", "connTV"], :category=>"MOVIE", :programmeId=>"1446531542", :providerId=>"Studio", 
             :Title=>"E2EAutomationAssetMovie_1446531542", :VideoFormat=>["SD", "HD"], :MaturityRating=>"M", 
             :Subtitled=>"0", :Year=>"2005", :Colour=>"BlackAndWhite", :field_color_format=>"null", 
             :Languages=>"en", :Country=>"US", :Asset_title_Trailer=>"1446531542_T_SD", 
             :Asset_title_SD=>"1446531542_SD", :Asset_title_HD=>"1446531542_HD",
             :Director=>"Mrinalini Singh", :Actor=>"Anupama Bhise", :Writer=>"Manisha Lawate", 
             :ShortSynopsis=>"An experiment in advanced weather technology has turned farmland ", 
             :LongSynopsis=>"An experiment in advanced weather technology has turned a desert canyon into 
             fertile farmland ", :assetId=>"1446531542", :Duration=>"PT0H0M40.04S",:field_duration_format=>"null", 
             :AspectRatio=>"4x3",:window_status=>"now", :global_offset=>"3H",
             #:offer_filters["Studio_MOVIE_Subscription_SD_7:a86cbede467900d110b7e6b31fb3f9f503ec86ae:now","Studio_MOVIE_Subscription_SD_7:a86cbede467900d110b7e6b31fb3f9f503ec86ae","Studio_MOVIE_Subscription_SD_7:now"],
             :field_asset_aspect_ratio_format=>"null", :embeddcode=>"5zMTZseDpA9-zfIDhEf3ILx8CQ8xp746",
             :Sound=>"Stereo",:field_asset_aspect_ratio_format=>"null" ,:field_asset_sound_format=>"null",
             :trailerId=>"1446531542_T",:field_colour_format=>"null",  
             :field_asset_status_value=>"uploadingOoyalaCompleted", :field_asset_status_format=>"null" ,
             :asset_class=>"feature",
             :asset_class_trailer=>"trailer",:field_closed_captions=>"0",:offer_node_HD=>"6811", 
             :offer_node_SD=>"6810",:offer_id_SD=>"1446531542_SD",:offer_id_format=>"null",:offer_price=>"7000",
             :offer_id_format=>"null",:target_id=>"18", :viewing_period=>"7",
             :offer_Title=>"2006-01-01T00:00:00.000Z--2021-01-01T00:00:00.000Z--Subscription", 
             :embeddcode_SD_asset=>"83MjZseDqulcjpnHIaXZlTIpZhSJFJPQ",
             :embeddcode_HD_asset=>"81MjZseDo-0OHi5WmNMZAydl3bdvqLVU", 
             :embeddcode_T_asset=>"5zMTZseDpA9-zfIDhEf3ILx8CQ8xp746"}, 

             "1446531544"=>{:start_date=>"2006-01-01T11:00:00.000Z", 
              :end_date=>"2021-01-01T11:00:00.000Z", :offerType=>"PPV-Promotion-DoublePack", 
              :deviceId=>["0e567a24f3d2f576b055604b07938e056a2cb9d1", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone", "pc_mac", 
                "pc_mac_play", "connTV"], :showID=>"1446531545", :category=>"TV_NO_EPS", :programmeId=>"1446531544", 
                :providerId=>"SON1", :groupId=>"1446531546", :Title=>"E2EAutomationAssetTvNoEps_1446531544", 
                :VideoFormat=>["SD", "HD"], :MaturityRating=>"PG", :Subtitled=>"false", :Year=>"2006", 
                :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"IN", ":Director"=>"Yash chopra", 
                :Actor=>"Sidharth Jadhav", :Writer=>"Kanitkar Sir", :SeasonNumber=>"909", 
                :ShortSynopsis=>"An experiment in advanced weather technology has turned farmland ", 
                :LongSynopsis=>"An experiment in advanced weather technology has turned a desert canyon into 
                fertile farmland ", :assetId=>"1446531544", :Duration=>"P0Y0M0DT0H0M0.000S", :AspectRatio=>"4x3", 
                :Sound=>"Stereo", :trailerId=>"1446531544_T"}}

                $i=0
     
       puts "the id of programme is #{$grades[:programeIds][1]}"
       $value="#{$grades[:programeIds][1]}"
       puts "final id is #{$grades[$value][:offer_node_SD]}"
       partial_relative_path="#{$grades[$value][:offer_node_SD]}"
       relative_path="/offer/#{partial_relative_path}"
       puts "#{relative_path}"
       @request_url=$base_url + relative_path
       puts "request_url is #{@request_url}"
       response = Net::HTTP.get_response(URI.parse(@request_url))
 
       CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/offer_new_csv_file.csv", :headers => true) do |col|
        #puts "after reading csv"
        @test_id = col[0]
        @path = col[2]
        @hash_key = col[1]
        @validation=col[3]
        $element = JsonPath.new(@path).on(JSON.parse(response.body))

        #puts $grades[$value][":\"#{temp}\""]
        #p '__________'
        #puts $grades[$value][:"#{@hash_key}"]
        #p '__________'
      

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

offer=Offer.new
offer.offer_function









