#encoding: utf-8
require 'rmmseg'

class SyncopateDecorator
  def self.process(text)
    RMMSeg::Dictionary.load_dictionaries
    algor = RMMSeg::Algorithm.new(text)
    results = []
    loop do
        tok = algor.next_token
        break if tok.nil?
        results << tok.text.force_encoding("UTF-8")
    end
    return results
  end
end
