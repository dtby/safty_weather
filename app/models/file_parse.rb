class FileParse
  def self.parse_file
    #FileParse.parse_file
    file = File.readlines("public/1511160430.000")[2..-1]
    array = []
    file.each do |f|
      array = array + f.split(" ")
    end
    array
  end

  def self.parse_position
    a = (118.958..123.278).step(0.01).to_a
    b = (28.755..33.075).step(0.01).to_a
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
    array[0..10000]
  end


  #测试，parse_all方法
  def self.test_all
    #FileParse.test_all
    a = [{"lng"=>"foo", "lat"=>"hello"}, {"lng"=>"bar", "lat"=>"world"}, {"lng"=>"wei", "lat"=>"jing"}]
    b = ['1','2','3']
    arr = [a, b].transpose.to_h
    array = []
    arr.each do |a1|
      hash = {}
      hash['count'] = a1[1]
      hash = a1[0].merge(hash)
      array << hash
    end
    p array
  end

  #测试,parse_position方法
  def self.test_code
    #FileParse.test_code
    a = [:foo, :bar, :baz, :bof]
    b = ["hello", "world", 1, 2]
    arr = a.product(b)
    array = []
    arr.each do |a1|
      hash = {}
      hash['lng'] = a1[0]
      hash['lat'] = a1[1]
      array << hash
    end
    p array
  end
end