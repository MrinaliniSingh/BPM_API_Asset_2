require 'cucumber'
require 'CSV'
require 'net/http'
require 'json'
require 'jsonpath'

$base_url = "http://foxtel-api.local"
$i=0

Then(/^executing the Asset scenario$/) do
 asset = Asset.new
 asset.asset_function
end

class Asset 
  def asset_function
    puts "in asset_function"
    $grades = {:assetIds=>{":1448358012_T_SD"=>"lmMjczeToWi0fdx-_l8IRsDR9EpmOL_7", 
      ":1448358012_SD"=>"liMjczeTqqB4yySs5Jl8cO8AuKEzLZCE",
      ":1448358012_HD"=>"lkMjczeTrCMnr__ndi-ctt9A0UI0GXkd" 
      },

      :programeIds=>["1448358012", "1448358011", "1448358013"], 
      "1448358011"=>{:start_date=>"2006-01-01T00:00:00.000Z",
        :end_date=>"2025-01-01T00:00:00.000Z", :offerType=>"PPV-Promotion-699", 
        :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone", 
          "pc_mac", "pc_mac_play", "connTV"], 
          :showID=>"1448358011", :category=>"TV_EPS", :programmeId=>"1448358011", :providerId=>"SON", 
          :groupId=>"1448358012", :Title=>"E2EAutomationAssetTvEps_1448358011", :VideoFormat=>["SD", "HD"], 
          :genre=>"Entertainment:Bollywood", :MaturityRating=>"G", :Subtitle=>"0", :Year=>"2003", 
          :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"JP", :Director=>"Dadasaheb Phalake", 
          :Actor=>"Prasad Oak", :Writer=>"Subodh Bhave", :SeasonNumber=>"597", :EpisodeNumber=>"10", 
          :ViewingPeriod=>"48", :EpisodeTitle=>"E2EAutomationEpisode_1448358011", 
          :ShortSynopsis=>"An experiment in advanced weather technology has turned farmland ", 
          :LongSynopsis=>"An experiment in advanced weather technology has turned a desert canyon into 
          fertile farmland ", 
          :assetId=>"1448358011", :Duration=>"P0Y0M0DT0H0M0.000S", :AspectRatio=>"4x3", :Sound=>"Stereo", 
          :trailerId=>"1448358011_T", :EmbedCode=>{":1448358011_SD"=>"loMjczeTpL4yYPj7XchWTxQ5s50yn2qc", 
            ":1448358011_T_SD"=>"k3MjczeTrhVU6fIi4kz7GbOazxPEYFxN", 
            ":1448358011_HD"=>"k5MjczeTrnJ3ss22vKIbETuT_yvaGIUg"}}, 

            
            "1448358012"=>{:start_date=>"2006-01-01T00:00:00", :end_date=>"2025-01-01T00:00:00", 
              :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone", 
                "pc_mac", "pc_mac_play", "connTV"], :category=>"MOVIE", :programmeId=>"1448358012", 
                :providerId=>"Studio", :Title=>"E2EAutomationAssetMovie_1448358012", 
                :MaturityRating=>"M", :Subtitle=>"0", :Year=>"2005", :Colour=>"BlackAndWhite", :Languages=>"en", 
                :Country=>"US", :Director=>"Mrinalini Singh", :Actor=>"Anupama Bhise", :Writer=>"Manisha Lawate", 
                :ViewingPeriod=>"48", :ShortSynopsis=>"An experiment in advanced weather technology has turned 
                farmland ", :LongSynopsis=>"An experiment in advanced weather technology has turned a desert 
                canyon into fertile farmland ", :assetId=>"1448358012", :Duration=>"PT0H0M40.04S", 
                :AspectRatio=>"4x3", :Sound=>"Stereo", :trailerId=>"1448358012_T", :ClosedCaption=>"0",
                :AssetStatus=>"uploadingOoyalaCompleted",
                :EmbedCode=>{":1448358012_T_SD"=>
                  "lmMjczeToWi0fdx-_l8IRsDR9EpmOL_7", ":1448358012_HD"=>"lkMjczeTrCMnr__ndi-ctt9A0UI0GXkd", 
                  ":1448358012_SD"=>"liMjczeTqqB4yySs5Jl8cO8AuKEzLZCE"
                  }}, 

                  

                  "1448358013"=>{:start_date=>"2006-01-01T00:00:00", 
                    :end_date=>"2025-01-01T00:00:00", :offerType=>"PPV-Promotion-DoublePack", 
                    :deviceId=>["STBmanaged", "STBunmanaged", "CEMediaPlayer", "gameConsole", "tablet", "phone", 
                      "pc_mac", "pc_mac_play", "connTV"], :showID=>"1448358013", :category=>"TV_NO_EPS", 
                      :programmeId=>"1448358013", :providerId=>"SON1", 
                      :Title=>"E2EAutomationAssetTvNoEps_1448358013", 
                      :VideoFormat=>["SD", "HD"], :MaturityRating=>"PG", :Subtitle=>"0", :Year=>"2006", 
                      :Colour=>"BlackAndWhite", :Languages=>"en", :Country=>"IN", :Director=>"Yash chopra", 
                      :Actor=>"Sidharth Jadhav", :Writer=>"Kanitkar Sir", :SeasonNumber=>"411", 
                      :ViewingPeriod=>"48", 
                      :ShortSynopsis=>"An experiment in advanced weather technology has turned farmland ", 
                      :LongSynopsis=>"An experiment in advanced weather technology has turned a desert canyon 
                      into fertile 
                      farmland ", :assetId=>"1448358013", :Duration=>"P0Y0M0DT0H0M0.000S", :AspectRatio=>"4x3", 
                      :Sound=>"Stereo", :trailerId=>"1448358013_T", :EmbedCode=>{":1448358013_SD"=>
                        "JzMzczeTr1PIUvK1uhsfybq5u2k86dcj", ":1448358013_HD"=>"JxMzczeTrPDXXBz9ic4ySQCQuEcvz0TA", 
                        ":1448358013_T_SD"=>"J1MzczeTqMznM14cqqzjdM476hotebxr"}}}

                        $i=0


                        $grades[:assetIds].each do |key|

                          
                          $value =key[0].split('_')[0].split(':')[1] 
                          puts "value of programme Id is #{$value}"


                          $grades[$value][:embeddCode]=key[1]
                          $grades[$value][:Asset_title]=key[0].split(':')[1]
                          $grades[$value][:type]='asset'
                          if key[0].include?('T_SD')
                            $grades[$value][:assetId_type]=key[0].split('_SD')[0].split(':')[1]
                            $grades[$value][:AssetClass]='trailer'
                            $grades[$value][:VideoFormat]='SD'
                            puts "the modified hash for trailer is #{$grades[$value]}"

                          elsif key[0].include?('HD')
                           $grades[$value][:assetId_type]=key[0].split('_HD')[0].split(':')[1]
                           $grades[$value][:AssetClass]='feature'
                           $grades[$value][:VideoFormat]='HD'
                           puts "the modified hash for HD is #{$grades[$value]} "

                         else key[0].include?('SD')
                          $grades[$value][:assetId_type]=key[0].split('_SD')[0].split(':')[1]
                          $grades[$value][:AssetClass]='feature'
                          $grades[$value][:VideoFormat]='SD'
                          puts "the modified hash for SD is #{$grades[$value]}"

                        end


                        partial_relative_path=key[1]
                        puts "#{partial_relative_path}"
                        relative_path="/asset/#{partial_relative_path}"
                        puts "#{relative_path}"
                        @request_url=$base_url + relative_path
                        puts "request_url is #{@request_url}"
                        response = Net::HTTP.get_response(URI.parse(@request_url))
                        $value =key[0].split('_')[0].split(':')[1] 
                        puts "value of programme Id is #{$value}"

                        CSV.foreach("E:/EndToEndAPiDoc/E2E_Automation code/BPM_API/features/Asset_new_csv_file.csv", :headers => true) do |col|
        #puts "after reading csv"
        @test_id = col[0]
        @path = col[2]
        @hash_key = col[1]
        @validation=col[3]
        $element = JsonPath.new(@path).on(JSON.parse(response.body))

        if @validation=="200"
         validate_200
       end

       if @validation=="value"
         validate_value
       end

     end
   end
   if $i>0
     raise "API call fails"
 
   end

 end

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
           if $grades[$value][:"#{@hash_key}"][0]==$element[0]|| $grades[$value][:"#{@hash_key}"]=="null"
           elsif $grades[$value][:"#{@hash_key}"][0]!=$element[0]
            puts "value not matched for the key :=> #{@hash_key} "
            puts "value of json key is #{$element[0]}"
            puts "value of hash key is #{$grades[$value][:"#{@hash_key}"]}"
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
    end