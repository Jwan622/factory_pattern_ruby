=begin
Another way that we can simplify the implementation of abstract factories is to
rely on a consistent naming convention for the product classes. This approach won’t
work for our habitat example, which is populated with things like tigers and frogs
that have unique names, but imagine you need to produce an abstract factory
for objects that know how to read and write a variety of file formats, such as
PDF, HTML, and PostScript files. Certainly we could implement IOFactory using
any of the techniques that we have discussed so far. But if the reader and
writer class names follow some regular pattern, something like HTMLReader and
HTMLWriter for HTML and PDFReader and PDFWriter for PDF, we can simply derive
the class name from the name of the format. That’s exactly what the following code does:

=end

class IOFactory
  def initialize(format)
    @reader_class = self.class.const_get("#{format}Reader")
    @writer_class = self.class.const_get("#{format}Writer")
  end

  def new_reader
    @reader_class.new
  end

  def new_writer
    @writer_class.new
  end
end

html_factory = IOFactory.new('HTML')
html_reader = html_factory.new_reader

pdf_factory = IOFactory.new('PDF')
pdf_writer = pdf_factory.new_writer

=begin
The const_get method used in IOFactory takes a string (or a symbol)
containing the name of a constant1 and returns the value of that constant.
For example, if you pass const_get the string "PDFWriter", you will get back
the class object of that name, which is exactly what we want in this case.s
=end
