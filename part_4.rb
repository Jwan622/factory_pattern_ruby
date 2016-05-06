# classe are objects too
=begin

A more significant objection to the Factory Method pattern as we have written
it so far is that this pattern requires a separate subclass for each specific
type of object that needs to be manufactured. This is reflected in the
names of the subclasses in the last version—we have DuckWaterLilyPond and
FrogAlgaePond, but we could have just as easily needed a DuckAlgaePond or
a FrogWaterLilyPond. Add a few more types of animals and plants, and the
number of possible subclasses becomes truly scary. But the only difference
between the various flavors of ponds is the class of objects produced by
the factory method: In the one case it produces lilies and ducks, and in
the other it makes algae and frogs.

The thing to realize is that the Frog, Duck, WaterLily, and Algae classes are
just objects—objects that make their living by producing other objects,
but objects nevertheless. We can get rid of this whole hierarchy of Pond
subclasses by storing the classes of the objects that we want to create in instance variables:
=end

class Pond
  def initialize(number_animals, animal_class,
                 number_plants, plant_class)
    @animal_class = animal_class
    @plant_class = plant_class

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

  def simulate_one_day
    @plants.each {|plant| plant.grow}
    @animals.each {|animal| animal.speak}
    @animals.each {|animal| animal.eat}
    @animals.each {|animal| animal.sleep}
  end

  def new_organism(type, name)
    if type == :animal
      @animal_class.new(name)
    elsif type == :plant
      @plant_class.new(name)
    else
      raise "Unknown organism type: #{type}"
    end
  end
end

# Using the new Pond class is not really any more complex than using the old one. We just pass the plant and animal classes into the constructor:

pond = Pond.new(3, Duck, 2, WaterLily)
pond.simulate_one_day

# By storing the animal and plant classes in Pond, we have knocked the number of classes that we need to write down to one. That’s a good thing, considering that we have not really added any additional complexity to Pond.
