module ApplicationHelper
  def authenticity_token
    html = <<-HTML.html_safe

            <input  name="authenticity_token"
                    type="hidden"
                    value="#{form_authenticity_token}">
          HTML
  end

end
