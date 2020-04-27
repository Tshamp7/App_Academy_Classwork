def first_anagram?(word1, word2)
  permutations = word1.chars.permutation.map(&:join)

  permutations.include?(word2) ? true : false
end

first = "levis"
second = "elvis"

#p first_anagram?(first, second)

def second_anagram?(word1, word2)
  chars1 = word1.chars
  chars2 = word2.chars

  chars1.each do |char|
    chars2.delete(char)
  end

  chars2.empty? ? true : false
end

#p second_anagram?(first, second)

def third_anagram?(first, second)
  chars1 = first.chars.sort
  chars2 = second.chars.sort

  chars1 == chars2 ? true : false
end

  
#p third_anagram?(first, second)

def fourth_anagram?(first, second)
  chars_count = Hash.new(0)

  first.each_char do |char|
    chars_count[char] += 1
  end

  second.each_char do |char|
    chars_count[char] += 1
end

  chars_count.value?(1) ? false : true

end

#p fourth_anagram?(first, second)