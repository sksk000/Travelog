module Public::PlacesHelper
  def action_button(type, text, target, action, css_classes = '', id = nil)
    options = {
      type: 'button',
      class: "btn #{type} tabbutton #{css_classes}",
      data: { place_target: target, action: action }
    }
    options[:id] = id if id.present?
    content_tag(:button, text, options)
  end
end
