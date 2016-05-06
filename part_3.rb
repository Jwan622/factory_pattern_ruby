=begin
Suppose your pond simulation is so popular that your users start asking you
to simulate plants as well as animals. So you wave your magic code wand
and come up with a couple of plant classes:
=end

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


class Algae
  def initialize(name)
    @name = name
  end

  def grow
    puts("The Algae #{@name} soaks up the sun and grows")
  end
end

class WaterLily
  def initialize(name)
    @name = name
  end

  def grow
    puts("The water lily #{@name} floats, soaks up the sun, and grows")
  end
end

=begin
# You will also need to modify the subclasses to create some flora:
# An awkward aspect of this implementation is that we need a separate method for
# each type of object we are producing: We have the new_animal method to
# make frogs and ducks and the new_plant method to create lilies and algae.

Having a separate method for each type of object that you need to produce
is not too much of a burden if you are dealing with only two types,
as in our pond example. But what if you have five or ten different types?
Coding all those methods can be, well, tedious.
=end



class DuckWaterLilyPond < Pond
  def new_animal(name)
    Duck.new(name)
  end

  def new_plant(name)
    WaterLily.new(name)
  end
end

class FrogAlgaePond < Pond
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

# You also modify the Pond class to deal with plants, like this:

class Pond
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_animal("Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_plant("Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each {|plant| plant.grow }
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end


=begin

we would do this instead:

A different and perhaps cleaner way to go is to have a single
factory method that takes a parameter, a parameter that tells
the method which kind of object to create.

Parameterized factory methods tend to slim down the code, because
each subclass needs to define only one factory method. They also make
the whole thing a bit easier to extend. Suppose you need to define
a new kind of product, perhaps fish to go in your pond. In that case, you
need to modify only a single method in the subclasses instead of adding a
whole new method

class Pond
  def initialize(number_animals, number_plants)
    @animals = []
    number_animals.times do |i|
      animal = new_organism(:animal, "Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant = new_organism(:plant, "Plant#{i}")
      @plants << plant
    end
  end

  # ...
end

class DuckWaterLilyPond < Pond
  def new_organism(type, name)
    if type == :animal
      Duck.new(name)
    elsif type == :plant
      WaterLily.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end

=end
