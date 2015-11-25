=begin

require 'cucumber'
require 'CSV'
require 'net/http'
require 'json'
require 'jsonpath'


Then(/^run Asset class$/) do
   compare = Compare_response.new
   compare.run_AssetFunction
end

Then(/^run offer class$/) do
   compare = Compare_response.new 
   compare.offer
end

class Compare_response


  def validate_200
        
    $element.each do |url|
    puts "url is #{url}"
    if url.include?"?"
       puts "1st Type Bad URI"
       urlStr=url.gsub(/\{\w*[?]\}/, '')
       url = URI.parse(urlStr)
       res = Net::HTTP.get_response(URI.parse(url))
    elsif(!url.include?"http://foxtel-api.local")
       puts "2nd Type Bad URI"
       res = Net::HTTP.get_response(URI.parse(url))
          
       url = URI.parse("http://foxtel-api.local"+url)

    else 
       puts "good url" 
       res = Net::HTTP.get_response(URI.parse(url))
    end
          
    if res.code == "200"
       puts "yes"
    else
        puts "the value of incorrect res code is #{res.code}"
        $i=$i+1
    end
    end
  end
  
  def validate_value
        
    if $grades[@hash_key]==$element[0]|| $grades[@hash_key]=="null"
    elsif $grades[@hash_key]!=$element[0]
      puts "value not matched for the key :=> #{@hash_key} "
      $i=$i+1
    end

  end

         
  def run_AssetFunction
   
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

  
      CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/Cucumber/features/Asset_csv_file.csv", :headers => true) do |col|
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
     #puts "partial_relative_path is:=>#{partial_relative_path}"
     relative_path="/offer/#{partial_relative_path}"
     @request_url=$base_url + relative_path
     #puts "request_url is:=>#{@request_url}"
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

end #end of class
=end
 
