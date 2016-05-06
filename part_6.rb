=begin

One problem with our new Habitat class is that it is possible to
create incoherent (not to mention ecologically unsound) combinations of
fauna and flora. For instance, nothing in our current habitat implementation
tells us that tigers and lily pads do not go together:

unstable = Habitat.new( 2, Tiger, 4, WaterLily)

This may not seem like much of a problem when you are dealing with just two
kinds of things (plants and animals, in this case), but what if our simulation
was much more detailed, extending to insects and birds and mollusks and fungi?
We certainly don’t want any mushrooms growing on our lily pads or fish
floundering away in the boughs of some jungle tree.

We can deal with this problem by changing the way we specify which creatures live in
the habitat. Instead of passing the individual plant and animal classes to Habitat,
we can pass a single object that knows how to create a consistent set of products.
We will have one version of this object for ponds, a version that will create
frogs and lily pads. We will have a second version of this object that will create the
tigers and trees that are appropriate to a jungle. An object dedicated to
creating a compatible set of objects is called an abstract factory. In fact,
the Abstract Factory pattern is yet another of those patterns made famous by the GoF. The code below shows two abstract factories for our habitat simulation, one for the jungle and one for the pond:
=end

class PondOrganismFactory
  def new_animal(name)
    Frog.new(name)
  end

  def new_plant(name)
    Algae.new(name)
  end
end

class JungleOrganismFactory
  def new_animal(name)
    Tiger.new(name)
  end

  def new_plant(name)
    Tree.new(name)
  end
end

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

jungle = Habitat.new(1, 4, JungleOrganismFactory.new)
jungle.simulate_one_day

pond = Habitat.new( 2, 4, PondOrganismFactory.new)
pond.simulate_one_day
