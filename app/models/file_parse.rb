class FileParse
  def self.parse_file
    #FileParse.parse_file
    file = File.readlines("public/1511160430.000")[2..-1]
    array = []
    file.each do |f|
      array = array + f.split(" ")
    end
    array
    p array
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
  end


  #测试
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