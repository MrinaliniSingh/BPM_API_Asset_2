require 'cucumber'
require 'CSV'
require 'net/http'
require 'json'
require 'jsonpath'

#=begin
Then(/^executing the Asset scenario$/) do
   compare = Compare_response.new
   compare.run_AssetFunction
end

Then(/^executing the offer scenario$/) do
   compare = Compare_response.new 
   compare.offer
end

Then(/^executing the programme scenario$/) do
   compare = Compare_response.new 
   compare.programme
end

Then(/^executing the String scenario$/) do
   compare = Compare_response.new 
   compare.string
end
#=end

Then(/^executing the Review scenario$/) do
   compare = Compare_response.new 
   compare.review
end

Then(/^executing the Season scenario$/) do
   compare = Compare_response.new 
   compare.season
end

Then(/^executing the Series scenario$/) do
   compare = Compare_response.new 
   compare.series
end

Then(/^executing the Genre scenario$/) do
  puts "in step definition block"
   compare = Compare_response.new 
   compare.genre_function
end

class Compare_response


  def validate_200
        
    $element.each do |url|
    #puts "url is #{url}"
      if url.include?"?"
         #puts "1st Type Bad URI"
         urlStr=url.gsub(/\{\w*[?]\}/, '')
         url = URI.parse(urlStr)
         res = Net::HTTP.get_response(URI.parse("#{url}"))
      elsif(!url.include?"http://foxtel-api.local")
         #puts "2nd Type Bad URI"
         url = URI.parse("http://foxtel-api.local"+url)
         res = Net::HTTP.get_response(URI.parse("#{url}"))
         
      else 
         #puts "good url" 
         res = Net::HTTP.get_response(URI.parse("#{url}"))
      end
          
      if res.code == "200"
         #puts "for url #{url} response code is 200"
      else
        puts "the value of response code is incorrect for the link #{url} is #{res.code}"
        $i=$i+1
      end
    end
  end
  
  def validate_value
       
    if $grades[@hash_key]==$element[0]|| $grades[@hash_key]=="null"
      #puts "value of hash key is #{$grades[@hash_key]}"
    elsif $grades[@hash_key]!=$element[0]
       puts "value not matched for the Hash key is :=> #{@hash_key} "
       puts "value of json key is #{$element[0]}"
       puts "value of hash key is #{$grades[@hash_key]}"
       #$grades.has_key?('@hash_key')
       $i=$i+1
    end
  end

  def validate_value_new
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
=begin
       
  def run_AssetFunction

    puts "For Ooyala:Asset API call"
   
    $i=0
    $base_url = "http://foxtel-api.local"
    $grades=Hash.new("Asset")
    $grades={"title"=>"00000057_SD - Test Asset for API_57_Automation","asset_type"=>"asset",
    "field_asset_status_value"=>"ingestionCompleted","field_asset_status_format"=>"null",
      "field_closed_captions_value"=>"0", "field_color_value"=>"BlackAndWhite",
      "field_color_format"=>"null",
      "field_duration_value"=>"PT0H0M40.04S","field_duration_format"=>"null" ,
      "field_subtitles_value"=>"0",
      "window_start"=>"2015-07-03T01:37:22", "window_end"=>"2021-07-14T04:37:38",
      "class"=>"feature","embed_code"=>"ZscGZ5dToGYaNIWpluAbQwZnFDOJtHsy", "asset_id"=>"00000057",
       "programme_ids"=>"00000057", "id"=>"ZscGZ5dToGYaNIWpluAbQwZnFDOJtHsy",}

  
    CSV.foreach("E:/Mrinaini/Cucumber/features/Asset_csv_file.csv", :headers => true) do |col|
      @test_id = col[0]
      partial_relative_path="#{$grades['embed_code']}"
      relative_path="/asset/#{partial_relative_path}"
      @request_url=$base_url + relative_path
      @hash_key= col[1]
      @path = col[2]
      @validation=col[3]
      response = Net::HTTP.get_response(URI.parse(@request_url))
      $element = JsonPath.new(@path).on(JSON.parse(response.body))
      p2 = $grades[@hash_key]

      if @validation=="200"
         validate_200
      end

      if @validation=="value"
         validate_value
      end

    end

    if $i>0
      raise "API call fails"
    end

  end


  def offer
     puts "For Ooyala:Offer API call"
     $i=0
     $base_url = "http://foxtel-api.local"
     $grades=Hash.new("Offer")
     $grades={"type"=>"offer","offer_id_value"=>"00000051_SD","offer_id_format"=>"null" ,
     "offer_price_value"=>"600","offer_price_format"=>"null","window_start"=>"2001-01-01T11:00:00",
     "window_end"=>"2021-01-01T11:00:00","device_id_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
     "device_id_ 1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e","programme_ids"=>"00000051",
     "asset_ids"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU","window_status"=>"now",
     "access_control_0_destinationID"=>"", "access_control_0_deviceID"=>"all_devices",
     "access_control_0_accessTerm"=>"null", "access_control_0_productTerm"=>"null",
     "access_control_1_destinationID"=>"bigpond_movies","access_control_1_deviceID"=>"STBmanaged",
     "access_control_1_accessTerm"=>"null","access_control_1_productTerm"=>"null",
     "access_control_2_destinationID"=>"bigpond_movies","access_control_2_deviceID"=>"STBunmanaged",
     "access_control_2_accessTerm"=>"null","access_control_2_productTerm"=>"null",
     "global_offset"=>"5H","offer_id"=>"121","link_ooyala:asset_asset_class"=>"promo", 
     "link_ooyala:programme_title"=>"Programme","embedded_ooyala:asset_title"=>"00000051_SD - Test Asset for API_51_Automation",
     "embedded_ooyala:asset_type"=>"asset","embedded_ooyala:asset_field_closed_captions_value"=>"0",
     "embedded_ooyala:asset_field_color_value"=>"BlackAndWhite",
     "embedded_ooyala:asset_field_color_format"=>"null",
     "embedded_ooyala:asset_field_duration_value"=>"PT0H0M40.04S",
     "embedded_ooyala:asset_field_duration_format"=>"null",
     "embedded_ooyala:asset_field_subtitles_value"=>"0",
     "embedded_ooyala:asset_window_start"=>"2015-07-01T00:49:17",
     "embedded_ooyala:asset_window_end"=>"2018-07-31T00:49:27","embedded_ooyala:asset_class"=>"promo",
     "embedded_ooyala:asset_ooyala"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU",
     "embedded_ooyala:asset_asset:id"=>"00000051","embedded_ooyala:asset_programme_ids"=>"00000051",
     "embedded_ooyala:asset_id"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU"
}

  
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/Offer_csv_file.csv", :headers => true) do |col|
    @test_id = col[0]
    partial_relative_path="#{$grades['offer_id']}"
    relative_path="/offer/#{partial_relative_path}"
    @request_url=$base_url + relative_path
    @hash_key= col[1]
    @path = col[2]
    @validation=col[3]
    response = Net::HTTP.get_response(URI.parse(@request_url))
    $element = JsonPath.new(@path).on(JSON.parse(response.body))
    p2 = $grades[@hash_key]
      if @validation=="200"
        validate_200
      end
      if @validation=="value"
        validate_value
      end


    end
    if $i>0
      raise "API call fails"
    end

  end


  def programme
     puts "For Ooyala:Programme API call"
     $i=0
     $base_url = "http://foxtel-api.local"
     $grades=Hash.new("Progamme")
     $grades={"imdbid"=>"0369610","programme_title"=> "TV_Eps_Test Asset for API_51_Automation", "type"=>"programme",
      "field_color_en_value"=>"BlackAndWhite","field_color_en_format"=>"null",
      "field_episode_number_en_value"=>"5","field_episode_title_en_value"=>"API_Episode 1",
      "field_episode_title_en_format"=>"null","field_group_id_en_value"=>"612345",
      "field_group_id_en_format"=>"null","field_programme_country_en_value"=>"JP",
      "field_programme_country_en_format"=>"null","field_programme_credit_soure_en_value"=>"bigpond",
      "field_programme_season_id_en_target_id"=>"118","field_programme_synopsis_source_en_value"=>"rottentomatoes",
      "field_programme_type_en_value"=>"TV_EPS","field_rotten_tomatoes_movie_en_target_id"=>"209",
      "field_rt_country_en_iso2"=>"AU","field_synopsis_en_value"=>"Steven Spielberg returns to executive produce the long-awaited next installment of his groundbreaking Jurassic Park series, Jurassic World. Colin Trevorrow directs the epic action-adventure based on characters created by Michael Crichton. The screenplay is by Rick Jaffa & Amanda Silver and Derek Connolly & Trevorrow, and the story is by Rick Jaffa & Amanda Silver. Frank Marshall and Patrick Crowley join the team as producers. (C) Universal",
      "actors_name"=>"Candi Milo","directors_name"=>"Genndy Tartakovsky",
      "writer_0_name"=>"Rajkumar", "Writer_1_name"=>"Rajkappor","genre_ids_0"=>"576","genre_ids_1"=>"4",
      "programme_id"=>"00000051","provider_id"=>"SON","offers_0_id"=>"121","offers_0_offer_types"=>"null",
      "offers_0_device_ids_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
      "offers_0_device_ids_1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e",
      "offers_0_window_start"=>"2001-01-01T11:00:00","offers_0_window_end"=>"2021-01-01T11:00:00",
      "offers_0_window_status"=>"now","ratings_critics_consensus"=>"", 
      "ratings_critics_rating"=>"Fresh","ratings_audience_rating"=>"Upright","ratings_critics_score"=>'71',
      "ratings_audience_score"=>"81","ratings_bigpond_rating"=>"4 Stars","ratings_bigpond_score"=>4,
      "critics_score"=>"71","audience_score"=>"81","bigpond_score"=>4, "rating"=>4,
      "maturity_rating"=>"MA15+","image_landscape_mask"=>'0.00', "ptype"=> "tv","sea_pub"=>"published",
      "season_id"=>"612345","season_title"=>"Test Asset for API_51 Season 1_Automation","ser_pub"=>"published",
      "series_id"=>"61234","series_title"=>"Test Asset for API_51_Automation","programme_id"=>"00000051",
      "links_ooyala:asset_asset_class"=>"promo","links_ooyala:actor_title"=>"Candi Milo",
      "links_ooyala:director_title"=>"Genndy Tartakovsky","links_ooyala:writer_0_title"=>"Rajkumar",
      "links_ooyala:writer_1_title"=>"Rajkappor","links_ooyala:programmeReviews_title"=>"Programme reviews",
      "links_ooyala:programmeReviews_templated"=>true,"links_ooyala:season_title"=>"Season",
      "links_ooyala:season_templated"=>false,"links_ooyala:series_title"=>"Series",
      "links_ooyala:season_templated"=>false,"embedded_ooyala:offer_0_title"=>"2001-01-01T11:00:00.000Z--2021-01-01T11:00:00.000Z--         PPV-Library_API-51",
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
      "embedded_ooyala:asset_0_programme_ids"=>"00000051" }


      #puts "value of imdbid is #{$grades['imdbid']}"



  
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/Programme_csv_file.csv", :headers => true) do |col|
    @test_id = col[0]
    partial_relative_path="#{$grades['programme_id']}"
    relative_path="/programme/#{partial_relative_path}"
    @request_url=$base_url + relative_path
    #puts "request url is #{@request_url} "
    @hash_key= col[1]
    @path = col[2]
    @validation=col[3]
    response = Net::HTTP.get_response(URI.parse(@request_url))
    $element = JsonPath.new(@path).on(JSON.parse(response.body))
    p2 = $grades[@hash_key]
      if @validation=="200"
        validate_200
      end
      if @validation=="value"
        validate_value
      end


    end
    if $i>0
      raise "API call fails"
    end

  end


 def string

    puts "For Ooyala:String API call"
   
    $i=0
    $base_url = "http://foxtel-api.local"
    $grades=Hash.new("String")
    $grades={"title"=>"String_API_Automation","machine_name"=>"machine_18","string"=>"Watch Now",
      "id"=>"machine_18"}

  
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/String_csv_file.csv", :headers => true) do |col|
      @test_id = col[0]
      partial_relative_path="#{$grades['id']}"
      relative_path="/string/#{partial_relative_path}"
      @request_url=$base_url + relative_path
      @hash_key= col[1]
      @path = col[2]
      @validation=col[3]
      response = Net::HTTP.get_response(URI.parse(@request_url))
      $element = JsonPath.new(@path).on(JSON.parse(response.body))
      p2 = $grades[@hash_key]

      if @validation=="200"
         validate_200
      end

      if @validation=="value"
         validate_value
      end

    end

    if $i>0
      raise "API call fails"
    end

  end


def review

    puts "For Ooyala:Review API call"
   
    $i=0
    $base_url = "http://foxtel-api.local"
    $grades=Hash.new("Review")
    $grades={"Title"=>"Joe Morgenstern_2015-07-09_Wall Street Journal","type"=>"rt_review","imdbid"=>"2293640",
      "field_critic_en_0_value"=>"Joe Morgenstern","field_critic_en_0_format"=>"null",
      "field_freshness_en_0_value"=>"rotten","field_freshness_en_0_format"=>"null",
      "field_publication_en_0_value"=>"Wall Street Journal","field_publication_en_0_format"=>"null",
      "field_quote_en_0_value"=>"The begoggled, capsule-shaped, banana-colored scamps who stole the show in two installments of the popular Despicable Me franchise deserved something better than this indifferently animated, catch-as-catch-can venture in comedic chaos.",
      "field_review_date_en_0_value"=>"2015-07-09","field_review_date_en_0_format"=>"null",
      "field_review_link_en_0_title"=>"null","field_review_link_en_0_attributes"=>"null","id"=>"883",

}

  
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/Review_csv_file.csv", :headers => true) do |col|
      @test_id = col[0]
      partial_relative_path="#{$grades['id']}"
      relative_path="/review/#{partial_relative_path}"
      @request_url=$base_url + relative_path
      @hash_key= col[1]
      @path = col[2]
      @validation=col[3]
      response = Net::HTTP.get_response(URI.parse(@request_url))
      $element = JsonPath.new(@path).on(JSON.parse(response.body))
      p2 = $grades[@hash_key]

      if @validation=="200"
         validate_200
      end

      if @validation=="value"
         validate_value
      end

    end

    if $i>0
      raise "API call fails"
    end

  end

  def season

    puts "For Ooyala:Season API call"
   
    $i=0
    $base_url = "http://foxtel-api.local"
    $grades=Hash.new("Season")
    $grades={"title"=>"Test Asset for API_51 Season 1_Automation","type"=>"season",
      "field_is_season_closed_captioned_en_0_value"=>"0","field_is_season_subtitled_en_0_value"=>"0",
      "field_season_audience_rating_en_0_value"=>"Upright","field_season_audience_score_en_0_value"=>"61",
      "field_season_critics_rating_en_0_value"=>"Certified Fresh","field_season_critics_score_en_0_value"=>"41",
      "field_season_year_en_0_value"=>"2013","field_season_year_en_0_format"=>"null","season_id"=>"612345",
      "offers_0_id"=>"121","offers_0_offer_types"=>"",
      "offers_0_device_ids_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
      "offers_0_device_ids_1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e",
      "offers_0_window_start"=>"2001-01-01T11:00:00",
      "offers_0_window_end"=>"2021-01-01T11:00:00","offers_0_window_status"=>"now",
      "programme_ids_0"=>"00000051","episode_numbers_0"=>"5","series_id"=>"61234",
      "series_title"=>"Test Asset for API_51_Automation","actors_0_name"=>"test",
      "directors_0_name"=>"coffee great","writers_0_name"=>"tea coffee","maturity_rating"=>"MA15+",
      "critics_score"=>"41","audience_score"=>"61","ratings_critics_consensus"=>"",
      "ratings_audience_rating"=>"Upright",
      "ratings_bigpond_rating"=>"2.5 Stars","ratings_bigpond_score"=>2.5,"genre_ids_0"=>"576",
      "genre_ids_1"=>"4","id"=>"612345","links_ooyala:series_id"=>"61234",
      "links_ooyala:programme_title"=>"00000051","links_ooyala:actor_title"=>"test",
      "links_ooyala:director_title"=>"coffee great","links_ooyala:writer_title"=>"tea coffee",
      "links_ooyala:genre_0_title"=>"576","links_ooyala:genre_1_title"=>"4",
      "embedded_ooyala:programme_0_title"=>"TV_Eps_Test Asset for API_51_Automation",
      "embedded_ooyala:programme_0_type"=>"programme",
      "embedded_ooyala:programme_0_field_color_en_0_value"=>"BlackAndWhite",
      "embedded_ooyala:programme_0_field_color_en_0_format"=>"null",
      "embedded_ooyala:programme_0_field_episode_number_en_0_value"=>"5",
      "embedded_ooyala:programme_0_field_episode_title_en_0_format"=>"null",
      "embedded_ooyala:programme_0_field_programme_country_en_0_value"=>"JP",
      "embedded_ooyala:programme_0_field_programme_country_en_0_format"=>"null",
      "embedded_ooyala:programme_0_field_programme_credits_source_en_0_value"=>"bigpond",
      "embedded_ooyala:programme_0_field_programme_season_id_en_0_target_id"=>"118",
      "embedded_ooyala:programme_0_field_programme_synopsis_source_en_0_value"=>"rottentomatoes",
      "embedded_ooyala:programme_0_field_programme_type_en_0_value"=>"TV_EPS",
      "embedded_ooyala:programme_0_field_rotten_tomatoes_movie_en_0_target_id"=>"209",
      "embedded_ooyala:programme_0_field_rt_country_en_0_iso2"=>"AU",
      "embedded_ooyala:programme_0_field_synopsis_en_0_value"=>"Steven Spielberg returns to executive produce the long-awaited next installment of his groundbreaking Jurassic Park series, Jurassic World. Colin Trevorrow directs the epic action-adventure based on characters created by Michael Crichton. The screenplay is by Rick Jaffa & Amanda Silver and Derek Connolly & Trevorrow, and the story is by Rick Jaffa & Amanda Silver. Frank Marshall and Patrick Crowley join the team as producers. (C) Universal",
      "embedded_ooyala:programme_0_imdbid"=>"0369610",
      "embedded_ooyala:programme_0_actors_0_name"=>"Candi Milo",
      "embedded_ooyala:programme_0_directors_0_name"=>"Genndy Tartakovsky",
      "embedded_ooyala:programme_0_writers_0_name"=>"Rajkumar",
      "embedded_ooyala:programme_0_genre_ids_0"=>"576",
      "embedded_ooyala:programme_0_programme_id"=>"00000051","embedded_ooyala:programme_0_provider_id"=>"SON",
      "embedded_ooyala:programme_0_offers_0_id"=>"121",
      "embedded_ooyala:programme_0_offers_0_offer_types"=>"",
      "embedded_ooyala:programme_0_offers_0_device_ids_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
      "embedded_ooyala:programme_0_offers_0_device_ids_1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e",
      "embedded_ooyala:programme_0_offers_0_window_start"=>"2001-01-01T11:00:00",
      "embedded_ooyala:programme_0_offers_0_window_end"=>"2021-01-01T11:00:00",
      "embedded_ooyala:programme_0_offers_0_window_status"=>"now",
      "embedded_ooyala:programme_0_ratings_critics_consensus"=>"",
      "embedded_ooyala:programme_0_ratings_audience_rating"=>"Upright",
      "embedded_ooyala:programme_0_ratings_bigpond_rating"=>"4 Stars",
      "embedded_ooyala:programme_0_ratings_bigpond_score"=>4,
      "embedded_ooyala:programme_0_critics_score"=>"71",
      "embedded_ooyala:programme_0_audience_score"=>"81",
      "embedded_ooyala:programme_0_bigpond_score"=>4,"embedded_ooyala:programme_0_rating"=>4,
      "embedded_ooyala:programme_0_maturity_rating"=>"MA15+",
      "embedded_ooyala:programme_0_image_landscape_mask"=>"0.00","embedded_ooyala:programme_0_ptype"=>"tv",
      "embedded_ooyala:programme_0_sea_pub"=>"published",
      "embedded_ooyala:programme_0_season_id"=>"612345",
      "embedded_ooyala:programme_0_season_title"=>"Test Asset for API_51 Season 1_Automation",
      "embedded_ooyala:programme_0_id"=>"00000051",
      "embedded_ooyala:programme_0_links_ooyala:asset_asset_class"=>"promo",
      "embedded_ooyala:programme_0_links_ooyala:actor_title"=>"Candi Milo",
      "embedded_ooyala:programme_0_links_ooyala:director_title"=>"Genndy Tartakovsky",
      "embedded_ooyala:programme_0_links_ooyala:writer_0_title"=>"Rajkumar",
      "embedded_ooyala:programme_0_links_ooyala:programmeReviews_title"=>"Programme reviews",
      "embedded_ooyala:programme_0_links_ooyala:programmeReviews_templated"=>true,
      "embedded_ooyala:programme_0_links_ooyala:season_title"=>"Season",
      "embedded_ooyala:programme_0_links_ooyala:series_title"=>"Series",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_type"=>"offer",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_field_offer_id_en_0_value"=>"00000051_SD",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_field_offer_id_en_0_format"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_field_offer_price_en_0_value"=>"600",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_field_offer_price_en_0_format"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_field_offer_type_en_0_target_id"=>"12",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_field_viewing_period_en_0_value"=>"48",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_window_start"=>"2001-01-01T11:00:00",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_window_end"=>"2021-01-01T11:00:00",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_device_ids_0"=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_device_ids_1"=>"735b23ae18fd6bf76caa3d13ff0b8bfab0661c7e",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_programme_ids_0"=>"00000051",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_asset_ids_0"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_window_status"=>"now",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_access_control_0_destinationID"=>"",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_access_control_0_deviceId"=>"all_devices",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_access_control_0_accessTerm"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_access_control_0_productTerm"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_global_offset"=>"5H",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_id"=>"121",
      "embedded_ooyala:programme_0_embedded_ooyala:offer_0_links_ooyala:asset_asset_class"=>"promo",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_title"=>"00000051_SD - Test Asset for API_51_Automation",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_type"=>"asset",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_asset_status_en_0_value"=>"Started",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_asset_status_en_0_format"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_closed_captions_en_0_format"=>"0",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_color_en_0_value"=>"BlackAndWhite",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_color_en_0_format"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_duration_en_0_value"=>"PT0H0M40.04S",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_duration_en_0_format"=>"null",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_subtitles_en_0_value"=>"0",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_field_video_format_en_0_value"=>"SD",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_window_start"=>"2015-07-01T00:49:17",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_window_end"=>"2018-07-31T00:49:27",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_asset_class"=>"promo",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_ooyala"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_asset_id"=>"00000051",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_programme_ids_0"=>"00000051",
      "embedded_ooyala:programme_0_embedded_ooyala:asset_0_id"=>"wxb3B4dTrzzjHHdzSmAHH9GFTEXagraU"



}

  
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/Season_csv_file.csv", :headers => true) do |col|
      @test_id = col[0]
      partial_relative_path="#{$grades['season_id']}"
      relative_path="/season/#{partial_relative_path}"
      @request_url=$base_url + relative_path
      #puts "the request url is #{@request_url}"
      @hash_key= col[1]
      @path = col[2]
      @validation=col[3]
      response = Net::HTTP.get_response(URI.parse(@request_url))
      $element = JsonPath.new(@path).on(JSON.parse(response.body))
      p2 = $grades[@hash_key]

      if @validation=="200"
         validate_200
      end

      if @validation=="value"
         validate_value
      end

    end

    if $i>0
      raise "API call fails"
    end

  end

  def series
    puts "For ooyala:sereis API call"

  $grades = {:programeIds=>["1442992948", "1442992950"], "1442992948"=>{:start_date=>"2006-01-01T00:00:00.000Z", 
  :end_date=>"2021-01-01T00:00:00.000Z", :offerType=>"PPV-Promotion-699", 
  :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone"],  
  :series_id=>"61234",:title => "Test Asset for API_51_Automation1",  :providerId=>"Studio", 
  :Title=>"E2EAutomationAssetMovie", 
  :VideoFormat=>["SD", "HD"], 
    :genre=>"Entertainment:Bollywood_Automation",:genre_id=>"513" ,:ParentalRating=>"M", :Subtitled=>"false", :Year=>"2005", 
    :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"US", :Director=>"Genndy Tartakovsky",
     :Actor=>"Candi Milo", :SeasonNumber=>"634", :EpisodeNumber=>"10",
     :EpisodeTitle=>"episode_bpm_fpe_of_tv_eps_", :assetId=>"1442992950", :Duration=>"P0Y0M0DT0H0M0.000S", 
     :AspectRatio=>"4x3", :Sound=>"Stereo", :trailerId=>"1442992950_T", 
     :title=>"Test Asset for API_51_Automation",:field_is_series_closed_captioned_en_0_value=>"0",
     :field_is_series_subtitled_en_0_value=>"0",:field_series_audience_rating_en_0_value=>"Spilled", 
     :field_series_audience_score_en_0_value=>"12", :field_series_critics_rating_en_0_value=>"Rotten",
     :field_series_critics_score_en_0_value=>"98",
     :field_series_presto_editorial_en_0_value=>"test",:field_series_presto_editorial_en_0_format=>"null",
     :field_total_number_of_programmes_en_0_value=>"1",:field_total_number_of_seasons_en_0_value=>"1",
     :series_id=>"61234",:actors_0_name=>"test",:maturity_rating=>"MA15+",:offers_0_id=>"121",
     :offers_0_window_start=>"2001-01-01T11:00:00",:offers_0_window_end=>"2021-01-01T11:00:00",
     :offers_0_window_status=>"now", :critics_score =>"98", :audience_score=>"12", :rating=>3,
     :bigpond_score=>3, :id=>"61234", 
    
   }
 }
  $i=0
    CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/series_csvfile.csv", :headers => true) do |col|
      puts "in do loop after reading csv"
      puts ""
    @test_id = col[0]
    partial_relative_path="#{$grades[$grades[:programeIds][0]][:series_id]}"
    #puts "partial_relative_path is #{partial_relative_path}"
    #puts "read partial_relative_path"
    relative_path="/series/#{partial_relative_path}"
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

      if @validation=="200"
         validate_200
      end

      if @validation=="value"
         validate_value_new
      end

    end
    if $i>0
       puts "API call fails"
    end
  

   end #end of series function
=end

def genre_function
    puts "in genre API call"
    $grades = {:programeIds=>["1442992948", "1442992950"], "1442992948"=>{:start_date=>"2006-01-01T00:00:00.000Z", 
    :end_date=>"2021-01-01T00:00:00.000Z", :offerType=>"PPV-Promotion-699", 
    :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone"],  
    :series_id=>"61234",:title => "Test Asset for API_51_Automation1",  :providerId=>"Studio", 
    :Title=>"E2EAutomationAssetMovie", 
    :VideoFormat=>["SD", "HD"], 
    :genre_title=>"Entertainment:Bollywood_Automation",:genre_type=>"genre",:genre_id=>"513" ,
    :field_genre_type_en_0_target_id=>"2", :weight=>"5", :featured_programme_ids_0=>"00000050",
    :recommendations_rating_limit=>"R18+", :maingenre=>"tv", :id=>"513", 
    :links_ooyala_genreProgrammes_templated =>"true", :links_ooyala_genreSeries_templated=>"field_total_number_of_seasons_en_0_value",
    :embedded_ooyala_programme_0_title=>"Test Asset for API_50_Automation", 
    :embedded_ooyala_programme_0_type=>"programme", 
    :embedded_ooyala_programme_0_field_color_en_0_value=>"BlackAndWhite", 
    :embedded_ooyala_programme_0_field_color_en_0_format=>"null", 
    :embedded_ooyala_programme_0_field_episode_number_en_0_value=>"5",
    :embedded_ooyala_programme_0_field_episode_title_en_0_value=>"API_Episode 1",
    :embedded_ooyala_programme_0_field_episode_title_en_0_format=>"null", 
    :embedded_ooyala_programme_0_field_group_id_en_0_value=>"512345", 
    :embedded_ooyala_programme_0_field_group_id_en_0_format=>"NULL",
    :embedded_ooyala_programme_0_field_programme_country_en_0_value=>"JP", 
    :embedded_ooyala_programme_0_field_programme_country_en_0_format=>"null",
    :embedded_ooyala_programme_0_field_programme_credits_source_en_0_value=>"bigpond", 
    :embedded_ooyala_programme_0_field_programme_season_id_en_0_target_id=>"113",
    :embedded_ooyala_programme_0_field_programme_synopsis_source_en_0_value=>"rottentomatoes",
    :embedded_ooyala_programme_0_field_programme_type_en_0_value=>"TV_EPS",
    :embedded_ooyala_programme_0_field_rotten_tomatoes_movie_en_0_target_id=>"209",
    :embedded_ooyala_programme_0_field_rt_country_en_0_iso2=>"AU",
    :embedded_ooyala_programme_0_field_short_synopsis_en_0_value=>"test for API",
    :embedded_ooyala_programme_0_field_short_synopsis_en_0_format=>"NULL",
    :embedded_ooyala_programme_0_field_synopsis_en_0_value=>"Steven Spielberg returns to executive produce the long-awaited next installment of his groundbreaking Jurassic Park series, Jurassic World. Colin Trevorrow directs the epic action-adventure based on characters created by Michael Crichton. The screenplay is by Rick Jaffa & Amanda Silver and Derek Connolly & Trevorrow, and the story is by Rick Jaffa & Amanda Silver. Frank Marshall and Patrick Crowley join the team as producers. (C) Universal",
    :embedded_ooyala_programme_0_imdbid=>"0369610", 
    :embedded_ooyala_programme_0_directors_0_name=>"Don't change", 
    :embedded_ooyala_programme_0_genre_ids_0=>"513", :embedded_ooyala_programme_0_programme_id=>"00000050",
    :embedded_ooyala_programme_0_provider_id=>"SON", :embedded_ooyala_programme_0_offers_0_id=>"116",
    :embeddedooyala_programme_0_offers_0_offer_types_0=>"SON_TV_EPS_PPV-Promotion-499-DayDate_SD_4",
    :embedded_ooyala_programme_0_offers_0_device_ids_0=>"0f51bce0bd3bb505c5d7ae27c755354a33aafbec",
    :embedded_ooyala_programme_0_offers_0_window_start=>"2015-11-18T11:00:00",
    :embedded_ooyala_programme_0_offers_0_window_end=>"2021-01-07T11:00:00", 
    :embedded_ooyala_programme_0_offers_0_window_status=>"comingsoon", 
    :embedded_ooyala_programme_0_offer_filters_0 =>"SON_TV_EPS_PPV-Promotion-499-DayDate_SD_4:0f51bce0bd3bb505c5d7ae27c755354a33aafbec:comingsoon",
    :embedded_ooyala_programme_0_year=>"2003", 
    :embedded_ooyala_programme_0_ratings_critics_rating=>"Fresh",
    :embedded_ooyala_programme_0_ratings_critics_score=>"71",
    :embeddedooyala_programme_0_ratings_audience_score=>"80", 
    :embedded_ooyala_programme_0_ratings_bigpond_rating=>"4 Stars",
    :embedded_ooyala_programme_0_ratings_bigpond_score=>4,
    :embedded_ooyala_programme_0_rating=>4, :embedded_ooyala_programme_0_maturity_rating=>"NC",
    :embedded_ooyala_programme_0_image_landscape_mask=>"0", :embedded_ooyala_programme_0_ptype=>"tv",
    :embedded_ooyala_programme_0_sea_pub=>"published", :embedded_ooyala_programme_0_series_id=>"512345",
    :embedded_ooyala_programme_0_series_title=>"Test Asset for API_50_Automation",
    :embedded_ooyala_programme_0_id=>"00000050", 
    :embedded_ooyala_programme_0_links_ooyala_programmeReviews_title=>"Programme reviews",
    :embedded_ooyala_programme_0_links_ooyala_season_title=>"Season", 
    :embedded_ooyala_programme_0_links_ooyala_series_title=>"Series", 
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_title=>"2001-01-01T11:00:00.000Z--2021-01-01T11:00:00.000Z--PPV-Promotion-499-DayDate",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_type=>"offer",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_field_offer_id_en_0_value=>"00000050_SD",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_field_offer_id_en_0_format=>"null",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_field_offer_price_en_0_value=>"4000",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_field_offer_type_en_0_target_id=>"12",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_field_viewing_period_en_0_value=>"4",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_window_start=>"2015-11-18T11:00:00",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_window_end=>"2021-01-07T11:00:00",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_device_ids_0=>"f51bce0bd3bb505c5d7ae27c755354a33aafbec",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_programme_ids_0=>"00000050",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_asset_ids_0=>"IwcW94dTpiwRrhGVBVq6CqbmlOv-zExX",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_offer_types_0=>"SON_TV_EPS_PPV-Promotion-499-DayDate_SD_4",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_window_status=>"comingsoon",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_offer_filters_0=>"SON_TV_EPS_PPV-Promotion-499-DayDate_SD_4:0f51bce0bd3bb505c5d7ae27c755354a33aafbec:comingsoon",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_access_control_0_destinationID=>"",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_access_control_0_deviceId=>"all_devices",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_access_control_0_accessTerm=>"null",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_access_control_0_productTerm=>"null",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_global_offset=>"3H",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_id=>"116",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_links_ooyala_asset_asset_class=>"feature",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_title=>"00000050_SD-Test Asset for API_50_Automation",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_type=>"asset",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_asset_status_en_0_value=>"error",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_asset_status_en_0_format=>"null",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_closed_captions_en_0_value=>"0",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_color_en_0_value=>"BlackAndWhite",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_color_en_0_format=>"null",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_duration_en_0_value=>"PT0H0M40.04S",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_duration_en_0_format=>"null",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_subtitles_en_0_value=>"0",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_field_video_format_en_0_value=>"SD",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_window_start=>"2001-07-01T07:43:45",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_window_end=>"2021-07-18T07:44:04",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_asset_class=>"feature",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_ooyala=>"IwcW94dTpiwRrhGVBVq6CqbmlOv-zExX",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_asset_id=>"00000050",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_programme_ids_0=>"00000050",
    :embedded_ooyala_programme_0_embedded_ooyala_offer_0_embedded_ooyala_asset_0_id=>"IwcW94dTpiwRrhGVBVq6CqbmlOv-zExX"

  }
 }

  $i=0
    CSV.foreach("E:/Mrinaini/Cucumber/features/Genre_csv_file.csv", :headers => true) do |col|
      #puts "abcdefff"
      #puts "in do loop after reading csv"
      #puts ""
    @test_id = col[0]
    partial_relative_path="#{$grades[$grades[:programeIds][0]][:genre_id]}"
    #puts "partial_relative_path is #{partial_relative_path}"
    #puts "read partial_relative_path"
    relative_path="/genre/#{partial_relative_path}"
    #puts "read relative_path is #{relative_path}"
    @request_url="http://foxtel-api.local/genre/513"
    #puts "request_url is #{@request_url}"
    @path = col[2]
    @hash_key= col[1]
    @validation=col[3]
    response = Net::HTTP.get_response(URI.parse(@request_url))
    $element = JsonPath.new(@path).on(JSON.parse(response.body))
    #puts "value of actual response is:=>#{element[0]}"
    p2 = $grades[@hash_key]

      if @validation=="200"
         validate_200
      end

      if @validation=="value"
         validate_value_new
      end

    end
    if $i>0
       puts "API call fails"
    end
  


   end   #end of genre function







end #end of class
 
