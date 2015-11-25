require 'CSV'
require 'net/http'
require 'json'
require 'jsonpath'

#require 'rest-client'

#CSV_FILE = ARGV[0] || 'mrinalini_hal_browser_automation2.csv'

$base_url = "http://foxtel-api.local"

$grades=Hash.new("Asset")
=begin
$grades={"asset_type"=>"asset","field_asset_status_value"=>"ingestionCompleted", 
      "field_closed_captions_value"=>"0", "field_color"=>"BlackAndWhite", "embed_code"=>"ZscGZ5dToGYaNIWpluAbQwZnFDOJtHsy"}
      "programme_title"=> "TV_Eps_Test Asset for API_51_Automation", "type"=>"programme",
      "field_color_en_value"=>"BlackAndWhite","field_color_en_format"=>"null",
      "field_episode_number_en_value"=>"5","field_episode_title_en_value"=>"API_Episode 1",
      "field_episode_title_en_format"=>"null","field_group_id_en_value"=>"612345",
      "field_group_id_en_format"=>"null","field_programme_country_en_value"=>"JP",
      "field_programme_country_en_format"=>"null","field_programme_credit_soure_en_value"=>"bigpond",
      "field_programme_season_id_en_target_id"=>"118","field_programme_synopsis_source_en_value"=>"rottentomatoes",
      "field_programme_type_en_value"=>"TV_EPS","field_rotten_tomatoes_movie_en_target_id"=>"209",
      "field_rt_country_en_iso2"=>"AU","field_synopsis_en_value"=>"Steven Spielberg returns to executive produce the long-awaited next installment of his groundbreaking Jurassic Park series, Jurassic World. Colin Trevorrow directs the epic action-adventure based on characters created by Michael Crichton. The screenplay is by Rick Jaffa & Amanda Silver and Derek Connolly & Trevorrow, and the story is by Rick Jaffa & Amanda Silver. Frank Marshall and Patrick Crowley join the team as producers. (C) Universal",
      "imdbid"=>"0369610","actors_name"=>"Candi Milo","directors_name"=>"Genndy Tartakovsky",
      "writer_0_name"=>"Rajkumar", "Writer_1_name"=>"Rajkappor","genre_ids_0"=>"576","genre_ids_1"=>"4",
      "programme_id"=>"00000051","provider_id"=>"SON","offers_0_id"=>"121","offers_0_offer_types"=>"null",
      "offers_0_device_ids_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
      "offers_0_device_ids_1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e",
      "offers_0_window_start"=>"2001-01-01T11:00:00","offers_0_window_end"=>"2021-01-01T11:00:00",
      "offers_0_window_status"=>"now","year"=>"2003","ratings_critics_consensus"=>"", 
      "ratings_critics_rating"=>"Fresh","ratings_audience_rating"=>"Upright","ratings_critics_score"=>'71',
      "ratings_audience_score"=>"81","ratings_bigpond_rating"=>"4 Stars","ratings_bigpond_score"=>"4",
      "critics_score"=>"71","audience_score"=>"81","bigpond_score"=>'4', "rating"=>'4',
      "maturity_rating"=>"MA15+","image_landscape_mask"=>'0.00', "ptype"=> "tv","sea_pub"=>"published",
      "season_id"=>"612345","season_title"=>"Test Asset for API_51 Season 1_Automation","ser_pub"=>"published",
      "series_id"=>"61234","series_title"=>"Test Asset for API_51_Automation","programme_id"=>"00000051",
      "links_ooyala:asset_asset_class"=>"promo","links_ooyala:actor_title"=>"Candi Milo",
      "links_ooyala:director_title"=>"Genndy Tartakovsky","links_ooyala:writer_0_title"=>"Rajkumar",
      "links_ooyala:writer_1_title"=>"Rajkappor","links_ooyala:programmeReviews_title"=>"Programme reviews",
      "links_ooyala:programmeReviews_templated"=>"true","links_ooyala:season_title"=>"Season",
      "links_ooyala:season_templated"=>"false","links_ooyala:series_title"=>"Series",
      "links_ooyala:season_templated"=>"false","embedded_ooyala:offer_0_title"=>"2001-01-01T11:00:00.000Z--2021-01-01T11:00:00.000Z--         PPV-Library_API-51",
      "embedded_ooyala:offer_0_type"=>"offer","embedded_ooyala:offer_0_field_offer_id_en_0_value"=>"00000051_SD",
      "embedded_ooyala:offer_0_field_offer_id_en_0_format"=>"null",
      "embedded_ooyala:offer_0_field_offer_price_en_0_value"=>"600",
      "embedded_ooyala:offer_0_field_offer_price_en_0_format"=>"null",
      "embedded_ooyala:offer_0_field_offer_type_en_0_target_id"=>"12",
      "embedded_ooyala:offer_0_field_viewing_period_en_0_value"=>"48",
      "embedded_ooyala:offer_0_window_start"=>"2001-01-01T11:00:00",
      "embedded_ooyala:offer_0_window_end"=>"2021-01-01T11:00:00",
      "embedded_ooyala:offer_0_device_ids_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
      "embedded_ooyala:offer_0_device_ids_1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e",
      "programme_id"=>"00000051","embedded_ooyala:offer_0_asset_ids_0"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU",
      "embedded_ooyala:offer_0_window_status"=>"now",
      "embedded_ooyala:offer_0_access_control_0_destinationID"=>"null",
      "embedded_ooyala:offer_0_access_control_0_deviceId"=>"all_devices",
      "embedded_ooyala:offer_0_access_control_0_accessTerm"=>"null",
      "embedded_ooyala:offer_0_access_control_0_productTerm"=>"null",
      "embedded_ooyala:offer_0_global_offset"=>"5H", "offer_id"=>"121",
      "embedded_ooyala:offer_0_links_ooyala:asset_asset_class"=>"promo",
      "embedded_ooyala:asset_0_title"=>"00000051_SD - Test Asset for API_51_Automation",
      "embedded_ooyala:asset_0_type"=>"asset",
      "embedded_ooyala:asset_0_field_asset_status_en_0_value"=>"Started",
      "embedded_ooyala:asset_0_field_asset_status_en_0_format"=>"null",
      "embedded_ooyala:asset_0_field_closed_captions_en_0_value"=>"0",
      "embedded_ooyala:asset_0_field_color_en_0_value"=>"BlackAndWhite",
      "embedded_ooyala:asset_0_field_color_en_0_format"=>"null",
      "embedded_ooyala:asset_0_field_duration_en_0_value"=>"PT0H0M40.04S",
      "embedded_ooyala:asset_0_field_duration_en_0_format"=>"null",
      "embedded_ooyala:asset_0_field_subtitles_en_0_value"=>"0",
      "embedded_ooyala:asset_0_field_video_format_en_0_value"=>"SD",
      "embedded_ooyala:asset_0_window_start"=>"2015-07-01T00:49:17",
      "embedded_ooyala:asset_0_window_end"=>"2018-07-31T00:49:27",
      "embedded_ooyala:asset_0_asset_class"=>"promo",
      "embedded_ooyala:asset_0_ooyala"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU",
      "embedded_ooyala:asset_0_id"=>"00000051",
      "embedded_ooyala:asset_0_programme_ids"=>"00000051"}

=end

 CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/new_asset_csvfile.csv", :headers => true) do |col|
    
    hash_key= col[1]
   

    puts "the value of hash csv key is #{hash_key}"

  $grades={:programeIds=>["1442992948", "1442992950"], "1442992948"=>{:start_date=>"2006-01-01T00:00:00.000Z", 
  :end_date=>"2021-01-01T00:00:00.000Z", :offerType=>"PPV-Promotion-699", 
  :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone", 
    "pc_mac", "pc_mac_play", "connTV"], :showID=>"1442992949", :category=>"MOVIE", :programmeId=>"1442992950", 
    :providerId=>"Studio", :Title=>"E2EAutomationAssetMovie", :VideoFormat=>["SD", "HD"], 
    :genre=>"Entertainment:Bollywood", :ParentalRating=>"M", :Subtitled=>"false", :Year=>"2005", 
    :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"US", :Director=>"Genndy Tartakovsky",
     ":Actor"=>"Candi Milo", :SeasonNumber=>"634", :EpisodeNumber=>"10", 
     :EpisodeTitle=>"episode_bpm_fpe_of_tv_eps_", :assetId=>"1442992950", :Duration=>"P0Y0M0DT0H0M0.000S", 
     :AspectRatio=>"4x3", :Sound=>"Stereo", :trailerId=>"1442992950_T", 
     :title=>"Test Asset for API_51_Automation",:field_is_series_closed_captioned_en_value_0=>"0",
     :field_is_series_subtitled_en_0_value=>"0",:field_series_audience_rating_en_0_value=>"Spilled", 
     :field_series_audience_score_en_0_value=>"12", :field_series_critics_rating_en_0_value=>"Rotten",
     :field_series_presto_editorial_en_0_value=>"test",:field_series_presto_editorial_en_0_value=>"null",
     :field_total_number_of_programmes_en_0_value=>"1",:field_total_number_of_seasons_en_0_value=>"1",
     :series_id=>"61234",:actors_0_name=>"test",:maturity_rating=>"MA15+",:offers_0_id=>"121",
     :offers_0_window_start=>"2001-01-01T11:00:00",:offers_0_window_end=>"2021-01-01T11:00:00",
     :offers_0_window_status=>"now", :critics_score => "98", :audience_score=>"12", :rating=>"3",
     :bigpond_score=>"3", :id=>"61234", 
   }

     }


      #puts "the device id 0 is #{$grades[$grades[:programeIds][0]][:deviceId][0]} "

      #puts "lengthhhhhhh #{$grades[$grades[:programeIds][0]][:deviceId].length}"


      if $grades[$grades[:programeIds][0]][:"#{hash_key}"].is_a?(Array)
      puts "is an array"
      puts "the value of fetched hash is #{$grades[$grades[:programeIds][0]][:"#{hash_key}"][0]}"
      else
      puts "not an array"
      puts "the value of fetched hash is #{$grades[$grades[:programeIds][0]][:"#{hash_key}"]}"
      end

      
  
  end





=begin
class Test
  puts "in class Test"
def run_test
  puts "in run_test function"
    $i=0
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/mrinalini_hal_browser_automation2.csv", :headers => true) do |col|
    @test_id = col[0]
    partial_relative_path="#{$grades['embed_code']}"
    relative_path="/asset/#{partial_relative_path}"
    @request_url=$base_url + relative_path
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
          
          #puts res.code
         # if res.code == "200"
            #puts "yes"
          #end
          #end   
          #end       
    end
  end

    def validate_value
        puts "in function validate_value"
        if $grades[@hash_key]==$element[0]|| $grades[@hash_key]=="null"
        elsif $grades[@hash_key]!=$element[0]
        puts "value not matched for the key :=> #{@hash_key} "
        $i=$i+1
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
#puts "outside class"
test = Test.new
test.run_test
=end





=begin
def validate
    puts "in loop"
	response = Net::HTTP.get_response(URI.parse(@request_url))
    element = JsonPath.new(@path).on(JSON.parse(response.body))
    puts "value of actual response is:=>#{element[0]}"
    p2 = $grades[@hash_key]
    puts "value of hash key is :=> #{p2}"
    if $grades[@hash_key]==element[0]
    puts "value match"
    else
    puts "value not matched for the key :=>#{@hash_key} " 
    end
end

end
=end



#puts "go in loop"
#run_test
#=end