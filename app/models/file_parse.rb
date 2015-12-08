class FileParse
  def self.parse_file
    #FileParse.parse_file
    file = File.readlines("public/1511160430.054")[2..-1]
    array = []
    file.each do |f|
      array = array + f.split(" ")
    end
    array
  end

  def self.parse_position
    a = (118.958..123.278).step(0.01).to_a
    b = (28.755..33.075).step(0.01).to_a.reverse
    arr = a.product(b)
    array = []
    arr.each do |a1|
      hash = {}
      hash['lng'] = a1[0]
      hash['lat'] = a1[1]
      array << hash
    end
    array
  end

  def self.parse_all
    #FileParse.parse_all
    a = FileParse.parse_position
    b = FileParse.parse_file

    arr = [a, b].transpose.to_h
    array = []
    arr.each do |a1|
      hash = {}
      hash['count'] = a1[1].to_f
      hash = a1[0].merge(hash)
      array << hash
    end
    array
  end

  def self.store_data
    #FileParse.store_data
    raindata = FileParse.parse_all.reject{|x| x['count'] == 0.0}
    $redis.set('raindata', raindata.to_json)
  end
end