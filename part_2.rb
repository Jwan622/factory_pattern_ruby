# calls a method defined in the subclass whenever the base class needs a new object
# that method is new_animal

class Pond
  def initialize(number_animals)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end
  end

  def simulate_one_day
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end

# here are the subclasses

class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end

class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end

class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts("Duck #{@name} is eating.")
  end

  def speak
    puts("Duck #{@name} says Quack!")
  end

  def sleep
    puts("Duck #{@name} sleeps quietly.")
  end
end

class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts("Frog #{@name} is eating.")
  end

  def speak
    puts("Frog #{@name} says Crooooaaaak!")
  end

  def sleep
    puts("Frog #{@name} doesn't sleep; he croaks all night!")
  end
end


# Now we need simply choose the right kind of pond, and it will be full of the right kind of creatures:

pond = FrogPond.new(3)
pond.simulate_one_day

# The GoF called this technique of pushing the “which class” decision down on a subclass the Factory Method pattern.

=begin
In our pond example, the creator is the Pond class, and the specific types of
ponds (like DuckPond and FrogPond) are the concrete creators; the products are
the Duck and Frog classes. While Figure 13-1 shows the two products sharing a
common base class (Product), our Duck and Frog are not actually blood relatives:
They simply share a common type because they implement a common set of methods.

In both the Factory Method pattern and the Template Method pattern, a generic part
of the algorithm (in our pond example, its day-to-day aquatic existence)
is coded in the generic base class, and subclasses fill in the blanks left
in the base class.
=end
