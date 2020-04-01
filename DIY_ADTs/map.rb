class Map #stores list items as key value pairs. 
    def initialize
        @map = []
    end

    def set(key, value)
        if !@map.include?(key)
            @map << [key, value]
        else
            puts "There is already a key = value pair with that key. Please choose another key."
        end
    end

    def get(key)
        @map.each_with_index do |sub_arr, idx|
            return sub_arr[1] if sub_arr[0] == key 
        end
    end

    def delete(key)
        @map.each_with_index do |sub_arr, idx|
            if sub_arr[0] == key
                @map.delete_at(idx)
            end
        end
    end

    def show
        print @map
    end



end