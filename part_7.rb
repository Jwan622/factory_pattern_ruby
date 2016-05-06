=begin
Classes Are Just Objects (Again)
One way to look at the abstract factory is to view it as a sort of super-duper-class
object. While ordinary class objects know how to create only one type of
object (i.e., instances of themselves), the abstract factory knows how to create
several different types of objects (i.e., its products).

This suggests a way to simplify our Abstract Factory pattern implementation:
We can make it a bundle of class objects, with one class for each product.
This is exactly the same “classes are just objects” insight that helped us
simplify the Factory Method pattern.

The code below shows a class-based abstract factory.
Instead of having several different abstract factory classes, one class for
each set of things that the factory needs to produce, we can have just one
factory class that stores the class objects of the things that it needs to produce:
=end

class Habitat
  def initialize(number_animals, number_plants, organism_factory)
    @organism_factory = organism_factory

    @animals = []
    number_animals.times do |i|
      animal = @organism_factory.new_animal("Animal#{i}")
      @animals << animal
    end

    @plants = []
    number_plants.times do |i|
      plant  = @organism_factory.new_plant("Plant#{i}")
      @plants << plant
    end
  end

  def simulate_one_day
    @plants.each {|plant| plant.grow}
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end
end

class OrganismFactory
  def initialize(plant_class, animal_class)
    @plant_class = plant_class
    @animal_class = animal_class
  end

  def new_animal(name)
    @animal_class.new(name)
  end

  def new_plant(name)
    @plant_class.new(name)
  end
end

class Tree
  def initialize(name)
    @name = name
  end

  def grow
    puts("The tree #{@name} grows tall")
  end
end

class Tiger
  def initialize(name)
    @name = name
  end

  def eat
    puts("Tiger #{@name} eats anything it wants.")
  end

  def speak
    puts("Tiger #{@name} Roars!")
  end

  def sleep
    puts("Tiger #{@name} sleeps anywhere it wants.")
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


# With this class-based abstract factory, we can create a new instance of the factory for each compatible set of objects that we need:

jungle_organism_factory = OrganismFactory.new(Tree, Tiger)
pond_organism_factory = OrganismFactory.new(WaterLily, Frog)

jungle = Habitat.new(1, 4, jungle_organism_factory)
jungle.simulate_one_day

pond = Habitat.new( 2, 4, pond_organism_factory)
pond.simulate_one_day


=begin
This all may seem a bit circular. After all, didn’t we originally create the
abstract factory to avoid specifying the individual classes? And with our
latest abstract factory implementation, aren’t we right back to being able to
create a pond full of tigers or a jungle overrun by algae? Not really.
The important thing about the abstract factory is that it encapsulates
the knowledge of which product types go together.

You can express that encapsulation with classes and subclasses, or you can
get to it by storing the class objects as we did in the code above.
Either way, you end up with an object that knows which kind of things belong together
=end
