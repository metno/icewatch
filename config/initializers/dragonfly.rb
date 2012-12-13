require 'dragonfly'

app = Dragonfly[:observation]

app.configure_with(:rails)
app.content_disposition = :attachment

# Allow all mongoid models to use the macro 'file_accessor'
app.define_macro_on_include(Mongoid::Document, :file_accessor)
