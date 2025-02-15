module Public::PostsHelper
  def post_form_input(form, field, label, size, placeholder, options = {})
    options[:class] ||= 'form-control'
    options[:required] ||= true
    options[:placeholder] ||= placeholder

    if size.include?("x")
      col, row = size.split("x").map(&:strip)
      options[:row] = row
      options[:col] = col
    else
      options[:size] ||= size
    end

    content_tag(:div, class: "form-group col p-3 post-form") do
      form.label(field, label, class: "form-label") +
        if options[:row] && options[:col]
          form.text_area(field, options)
        else
          form.text_field(field, options)
        end +
        content_tag(:div, '', class: 'invalid-feedback')
    end
  end

  def post_form_select(form, field, label, collection, options = {})
    options[:class] ||= 'form-control w-25'
    content_tag(:div, class: 'form-group col d-flex p-3 post-form') do
      form.label(field, label, class: 'form-label w-25') +
        form.select(field, collection, {}, options)
    end
  end

  def post_travel_months
    [["1月", 1], ["2月", 2], ["3月", 3], ["4月", 4], ["5月", 5], ["6月", 6],
     ["7月", 7], ["8月", 8], ["9月", 9], ["10月", 10], ["11月", 11], ["12月", 12]]
  end

  def post_show_image(post, size, options = {})
    options[:size] = size
    options[:class] = "mt-3 rounded mx-auto d-block"

    if post.image.present?
      image_tag(post.image, options)
    else
      image_tag(asset_path('no_image.jpg'), options)
    end
  end
end
