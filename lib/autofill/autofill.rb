class Autofill

  def self.def_fields(*attrs, feed:)

    attrs_hash = attrs.map{ |attr| [attr, nil] }.to_h

    class_eval <<-EOF
    def initialize(feed)
      @fields = #{attrs_hash}
      @fields[#{":" + feed.to_s}] = feed
      fill
    end
    EOF

  end

  def fields
    @fields.keys
  end

  def field_data
    @fields
  end

end
