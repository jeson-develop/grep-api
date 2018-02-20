require 'nokogiri'
require 'open-uri'

class ModelType < ActiveRecord::Base
  include Upsertable
  belongs_to :model
  has_one :organization, through: :model

  def total_price
    pricing_policy = self.organization.pricing_policy.downcase
    margin_amount = margin (pricing_policy)
    # ap({base_price: base_price, margin_amount: margin_amount})
    case pricing_policy.to_sym
    when :fixed, :prestige
      base_price + margin_amount
    when :flexible
      base_price * margin_amount
    end
  end

  def margin (pricing_policy)
    word_count = get_word_count(pricing_policy)
    case pricing_policy.to_sym
    when :fixed, :prestige
      word_count
    when :flexible
      (word_count / 100).to_f
    end
  end

  def get_word_count(pricing_policy)
    pricing_policies = Settings.pricing_policies
    url = pricing_policies[pricing_policy.to_sym].url
    word = pricing_policies[pricing_policy.to_sym].word
    source_type = pricing_policies[pricing_policy.to_sym].source_type
    html = source_type == 'html' ? Nokogiri::HTML(open url) : Nokogiri::XML(open url)
    text = source_type == 'html' ? html.inner_text : html
    text.to_s.scan(/#{word}/).size
  rescue => e
    p '-' * 100
    p e.message
    0
  end
end
