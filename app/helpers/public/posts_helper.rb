module Public::PostsHelper
  def form_input(form, field, label, size, placeholder, options = {})
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
      end
    end
  end

  def form_select(form, field, label, collection, options = {})
    options[:class] ||= 'form-control w-25'
    Rails.logger.debug "Options for select: #{options.inspect}"  # デバッグ用ログ
    content_tag(:div, class: 'form-group col d-flex p-3 post-form') do
      form.label(field, label, class: 'form-label w-25') +
      form.select(field, collection, {}, options)
    end
  end
end
