class Autofill

  def self.def_fields(*attrs, feed:)

    attrs_hash = attrs.map{ |attr| [attr, nil] }.to_h

    class_eval <<-EOF
    def initialize(feed)
      @fields = #{attrs_hash}
      @fields[#{":" + feed.to_s}] = feed
      fill
    end

    def self.fields
      #{attrs_hash.keys}
    end

    def self.feed
      #{":" + feed.to_s}
    end
    EOF

  end

  def field_data
    @fields
  end

  def self.autofillers
    Dir.glob("#{Rails.root}/app/autofillers/*.rb").each do |file|
      require file
    end
    descendants
  end

  def self.find(name)
    "#{name.titlecase}Autofiller".constantize
  end
end
