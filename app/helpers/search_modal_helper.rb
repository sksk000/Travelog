module SearchModalHelper
  def search_modal_select(form, field, label, options, css_class: "form-control")
    content_tag(:div, class: "#{field} mb-3") do
      form.label(label) + form.select(field, [['指定なし', "all_#{field}"]] + options, {}, class: css_class)
    end
  end

  def search_modal_button_group(name, range, stars: false)
    content_tag(:div, class: "#{name} mb-3") do
      label_tag(name.humanize) + content_tag(:div, class: "btn-group btn-group-toggle", data: { toggle: "buttons" }) do
          range.map do |value|
            content_tag(:label, class: "btn btn-outline-primary btn-lg") do
              check_box_tag("#{name}[]", value, false, autocomplete: "off") +
                if stars
                  (1..value).map { image_tag('star-on.png') }.join.html_safe
                else
                  "#{value}月"
                end
            end
          end.join.html_safe
        end
    end
  end
end
