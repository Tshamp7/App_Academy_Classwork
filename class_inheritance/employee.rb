require "byebug"


class Employee
    attr_reader :name, :title, :salary, :boss
    attr_writer :boss, :salary
    def initialize(name, title, salary, boss = nil)
        @name = name
        @title = title
        @salary = salary
        @boss = boss
    end

    def bonus_multiplier(multiplier)
        bonus = @salary * multiplier
        bonus
    end
end

class Manager < Employee
    attr_accessor :employees
    def initialize(name, title, salary, boss = nil, employees = [])
        @name = name
        @title = title
        @salary = salary
        @boss = boss
        @employees = employees
    end

    def bonus_multiplier(multiplier)
        self.employees_subsalary * multiplier
    end

    def employees_subsalary
        bonus_amt = 0
        self.employees.each do |employee|
            if employee.is_a?(Manager)
                bonus_amt += employee.salary + employee.employees_subsalary
            else
                bonus_amt += employee.salary                    
            end
        end
        bonus_amt
    end

    def add_employee(subordinate)
        self.employees << subordinate
        subordinate.boss = self
    end
end

david = Employee.new("David", "TA", 10000)
shawna = Employee.new("Shawna", "TA", 12000)
darren = Manager.new("Darren", "TA Manager", 78000)
ned = Manager.new("Ned", "Founder", 1000000)

employees_arr = [david, shawna]

manager_arr = darren

darren.add_employee(david)
darren.add_employee(shawna)


p darren.bonus_multiplier(4)



