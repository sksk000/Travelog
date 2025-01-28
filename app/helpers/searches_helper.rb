module SearchesHelper
  def search_months_checkboxes(f, months, name, label)
    content_tag(:div, class: "month mb-3") do
      output = content_tag(:label, label) + tag(:br)
      output += content_tag(:div, class: "btn-group btn-group-toggle", data: { toggle: 'buttons' }) do
        (1..12).map do |month|
          content_tag(:label, class: 'btn btn-outline-primary btn-lg') do
            check_box_tag("#{name}[]", month, months&.include?(month.to_s), autocomplete: 'off') +
            "#{month}月"
          end
        end.join.html_safe
      end
      output.html_safe
    end
  end

  def search_form_select(f, field_name, label_text, all_option_value, list_keys, selected_value, options = {})
    options[:class] ||= 'mb-3'
    content_tag(:div, options) do
      f.label(label_text).concat(
        f.select field_name, [['指定なし', all_option_value]] + list_keys.map { |key| [key.humanize, key] }, { selected: selected_value || all_option_value }, class: 'form-control'
      )
    end
  end

  def search_good_checkboxes(f, goods, name, label)
    content_tag(:div, class: "good mb-3") do
      output = content_tag(:label, label) + tag(:br)
      output += content_tag(:div, class: "btn-group btn-group-toggle", data: { toggle: 'buttons' }) do
      (1..5).map do |i|  # 1から5までループ
          content_tag(:label, class: 'btn btn-outline-primary btn-lg') do
            check_box_tag("#{name}[]", i, goods&.include?(i.to_s), autocomplete: 'off') +
            (1..i).map do
              image_tag('star-on.png')  # i回分の星アイコンを表示
            end.join.html_safe
          end
        end.join.html_safe
      end
      output.html_safe
    end
  end
end
