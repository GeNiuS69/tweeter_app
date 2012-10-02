module TweetsHelper
  def errors_for(object)
    content_tag :ul do
      html = ""
      object.errors.each do |attribute, error|
        html << attribute.to_s << "  " << error
      end
      html
    end
  end
end
