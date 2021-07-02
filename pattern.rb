class Pattern
  @@collection = []
  @@number_of_pages_in_pattern = 4

  def self.find(array)
    @@collection.find do |pattern_obj|
      pattern_obj.subarray == array
    end
  end

  def self.find_or_initialize_by(start_index, base_array, length)
    find(base_array[start_index...start_index+length]) || begin
      obj = new(start_index, base_array, length)
      @@collection.push(obj)
      obj
    end
  end

  def self.collection
    @@collection
  end

  def self.clear_collection
    @@collection = []
  end

  def self.number_of_pages_in_pattern
    @@number_of_pages_in_pattern
  end

  def self.number_of_pages_in_pattern=(number)
    @@number_of_pages_in_pattern = number
  end

  def initialize(start_index, base_array, length)
    @occurences = 0
    @subarray = base_array[start_index...start_index+length]
  end

  attr_accessor :occurences, :subarray

  def find_matches(array)
    array.to_enum.with_index.each do |element, index|
      self.occurences +=1 if inside?(array[index...index + @@number_of_pages_in_pattern])
    end
  end

  def inside?(array)
    subarray.to_enum.with_index.all? do |element, index|
      element == array[index]
    end
  end
end
