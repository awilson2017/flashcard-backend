require 'base64'
require 'HTTParty'


class ApiWrapper
  BASE_URL = "https://translation.googleapis.com/language/translate/v2/"
  GOOGLE_ID = ENV["GOOGLE_ID"]


  def self.google_translate(search)
  # "https://translation.googleapis.com/language/translate/v2/?key=${googleKey}&q=${this.state.word}&"
    # "source=en&target=ko&format=text"
url = "https://translation.googleapis.com/language/translate/v2/?key=#{GOOGLE_ID}&q=#{search}&source=en&target=ko&format=text"
    # url = BASE_URL + "?key=#{GOOGLE_ID}" + "&q=#{search}&" + "source=en&target=ko&format=text"

    response = HTTParty.post(url)
    korean_word = response["data"]["translations"][0]["translatedText"]
    return korean_word

    # need array to store the parsed api hash results
    # translations_list = []
    #
    # if response["data"]["translations"] == 0
    #   return []
    # else
    #   return response["data"]["translations"][0]["translatedText"]
    # end
  end

  def self.forvo(search)
    hex_array = search.each_byte.map { |b| b.to_s(16) } # .unpack('H*')[0] => "hex"
    encoded_ko = hex_array.map { |el| '%' + el }.join

    url = "https://apifree.forvo.com/action/word-pronunciations/format/json/word/" + encoded_ko + "/key/#{ENV["FORVO_KEY"]}"

    response = HTTParty.get(url)
    payload = response['items']

    audio_files = []
    payload.each do |audio|
      audio_object = {}
      # audio_object['country'] = audio['country']
      # audio_object['gender'] = audio['sex']
      audio_object['mp3'] = audio['pathmp3']

      audio_files.push(audio_object)
    end
    return audio_files[0]
  end
end
