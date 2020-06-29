class AutofillerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)
  desc "Build an autofiller to autofill an item from a schema."

  argument :feed, type: :string, default: ''
  argument :attributes, type: :array, default: [], banner: "fields"

  def create_initializer_file
    create_file "app/autofillers/#{file_name}_autofiller.rb", <<-EOF
class #{class_name}Autofiller < Autofill
  def_fields #{attributes.map{ |attr| ":" + attr.name }.join(", ")}, feed: :#{feed}

  def fill
    # Put your autofill code here. This code will automatically get executed on the object's instantiation.
    # You can use the instance variable @fields in order to access the fields that were previously defined.
  end
end
EOF
  end
end
