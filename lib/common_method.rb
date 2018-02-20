require 'nokogiri'
require 'open-uri'
module CommonMethod

  def get_words_count(pricing_policy)
    pricing_policies = Settings.pricing_policies
    url = pricing_policies[pricing_policy.to_sym].url
    word = pricing_policies[pricing_policy.to_sym].word

    html = Nokogiri::XML(open url)
    text  = html.at('body').inner_text
    text.scan(/#{word}/).size
  rescue
    0
  end
end