def coprime?(val1, val2)
    value = val1 > val2 ? val2 : val1

    (2..value).none? do |n|
        val1 % n == 0 && val2 % n == 0
    end
    true
end

p coprime?(25,12)