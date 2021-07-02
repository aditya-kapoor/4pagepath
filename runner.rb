require_relative 'gems'
require_relative 'pattern'

arrays = [
  ['p1','p4','p3','p2','p7','p2','p2','p1','p2','p5','p7','p4','p3','p3','p2','p2','p2','p3','p2','p7'],
  ['p3','p2','p6','p4','p6','p2','p4','p2','p2','p6','p1','p5','p2','p6','p2','p7','p4','p9','p3','p3'],
  ['p5','p9','p9','p6','p5','p2','p9','p8','p5','p3','p4','p7','p1','p1','p6','p9','p6','p7','p5','p6'],
  ['p6','p8','p3','p8','p4','p2','p8','p9','p3','p8','p6','p3','p4','p2','p4','p6','p8','p2','p4','p2'],
  ['p7','p6','p6','p6','p3','p2','p7','p6','p7','p7','p3','p3','p2','p7','p2','p4','p9','p5','p6','p8'],
  ['p8','p2','p9','p4','p2','p2','p6','p3','p4','p4','p4','p2','p4','p6','p4','p2','p7','p4','p6','p9'],
  ['p9','p2','p7','p2','p1','p2','p5','p1','p1','p3','p8','p9','p3','p9','p7','p1','p5','p6','p8','p1'],
]

arrays.each do |array|
  array.each_with_index do |element, index|
    next if index + Pattern.number_of_pages_in_pattern > array.length
    Pattern.find_or_initialize_by(index, array, Pattern.number_of_pages_in_pattern)
  end
end

arrays.each do |array|
  Pattern.collection.each do |pattern_obj|
    pattern_obj.find_matches(array)
  end
end

rows = []
rows << ['Pattern', 'Occurences']

Pattern.collection.sort { |a,b| b.occurences <=> a.occurences }.each do |pattern_obj|
  rows << [pattern_obj.subarray, pattern_obj.occurences]
end

puts Terminal::Table.new(rows: rows)
