=begin

The best way to go wrong with any of the object creation techniques that we have examined in this chapter
is to use them when you don’t need them. Not every object needs to be produced by a factory.
In fact, most of the time you will want to create most of your objects with a simple call to
MyClass.new. Use the techniques discussed in this chapter when you have a choice of several different,
related classes and you need to choose among them.

Remember, chances are You Ain’t Gonna Need It. The YAGNI principle applies with
a vengeance to factories. Perhaps I am dealing with only ducks and
lilies at the moment, but maybe in the future I might need to cope with tigers
and trees. Should I build a factory now to get ready? Probably not. You have
to balance the cost of the additional, currently useless factory infrastructure
against the likelihood that you will actually need the factory.
Factor in the price of back-fitting a factory in later. The answer depends
on the details, but engineers do have a tendency to build the Queen Mary
(or perhaps the Titanic?) when a canoe will suffice. If you have a choice
of exactly one class at the moment, put off adding in a factory.
=end
