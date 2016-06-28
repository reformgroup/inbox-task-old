module BootstrapHelper
  
  # ==== Examples
  #   search_tag(users_path, id: "users-search")
  #   # => <form id="users-search" role="search" action="/users" accept-charset="UTF-8" method="get">
  #   #      <input name="utf8" type="hidden" value="✓">
  #   #      <div class="input-group">
  #   #        <input type="search" name="search" id="search" class="form-control" placeholder="Search...">
  #   #        <div class="input-group-btn">
  #   #          <button name="button" type="submit" class="btn btn-secondary"><i class="fa fa-search"></i></button>
  #   #        </div>
  #   #      </div>
  #   #    </form>
  #
  def search_tag(url, options = {})
    options           ||= {}
    options[:role]    ||= 'search'
    options[:method]  ||= 'get'
    options[:id]      ||= 'index-search'
    content = content_tag(:div, class: 'input-group-btn') { button_tag(icon('search'), class: 'btn btn-secondary') }
    content = search_field_tag(:search, params[:search], class: 'form-control', placeholder: t('placeholder.search')).concat(content)
    content = content_tag(:div, content, class: 'input-group')
    content = content.concat(hidden_field_tag(:direction, params[:direction])) if params[:direction]
    content = content.concat(hidden_field_tag(:sort, params[:sort])) if params[:sort]
    
    form_tag(url, options) { content }
  end
  
  def button_dropdown_tag(name, content_or_options = nil, options = nil, &block)
    dropdown_tag(:button, name, content_or_options, options, &block)
  end
  
  # ==== Examples
  #   link_sort_tag(:sort, main_class: "default-link-style", selected_in_title: true) do
  #     option_for_sort(:last_name, "by name", default: true)
  #     option_for_sort(:created_at, "by created date")
  #   end
  #   # => <a class="dropdown-item" href="#"><i class="fa fa-fw fa-check"></i> Free</a>
  #   #    <a class="dropdown-item" href="#">Basic</a>
  #   #    <a class="dropdown-item" href="#">Advanced</a>
  #   #    <a class="dropdown-item" disabled="disabled" href="#">Super Platinum</a>
  #
  def link_dropdown_tag(name, content_or_options = nil, options = nil, &block)
    dropdown_tag(:a, name, content_or_options, options, &block)
  end
  
  # ==== Examples
  #   options_for_dropdown( ["Free", free_path, selected: true], 
  #                         ["Basic", basic_path], 
  #                         ["Advanced", advanced_path], 
  #                         ["Super Platinum", super_platinum_path, disabled: true])
  #   # => <a class="dropdown-item" href="#"><i class="fa fa-fw fa-check"></i> Free</a>
  #   #    <a class="dropdown-item" href="#">Basic</a>
  #   #    <a class="dropdown-item" href="#">Advanced</a>
  #   #    <a class="dropdown-item" disabled="disabled" href="#">Super Platinum</a>
  #
  def options_for_dropdown(content)
    if content.is_a Array
      content.each do |option_tag|
        name = option_tag[0]
        url  = option_tag[1]
        option_for_dropdown(name, url, option_tag[2])
      end.html_safe
    end
  end
  
  # ==== Examples
  #   option_for_dropdown( "Super Platinum", super_platinum_path, disabled: true)
  #   # => <a class="dropdown-item" disabled="disabled" href="#">Super Platinum</a>
  #
  def option_for_dropdown(name, url, options = {})
    options ||= {}
    
    if options.delete(:selected)
      select_icon     = options.delete(:icon) || 'check'
      options[:class] = ['current', options[:class]].compact.join(' ')
      @selected       = name
    end
    
    options[:class] = ['dropdown-item', options[:class]].compact.join(' ')
    link_content    = icon select_icon, name, class: 'fa-fw'
    link_to link_content, url, options
  end
  
  def button_sort_tag(name, content_or_options = nil, options = nil, &block)
    t('sort.title').concat(button_dropdown_tag(name, content_or_options, options, &block)).html_safe
  end
  
  def link_sort_tag(name, content_or_options = nil, options = nil, &block)
    t('sort.title').concat(link_dropdown_tag(name, content_or_options, options, &block)).html_safe
  end
  
  def option_for_sort(column, name, options = {})
    options ||= {}
    url     = {}
    column  = column.to_s
    
    direction           = column == params[:sort] && params[:direction] == 'asc' ? 'desc' : 'asc'
    options[:icon]      = sort_icon params[:direction]
    options[:selected]  = true if column == params[:sort]
    url[:sort]          = column
    url[:direction]     = direction
    url[:search]        = params[:search] if params[:search]
    
    option_for_dropdown name, url, options
  end
  
  private
  
  def sort_icon(current_direction)
    current_direction == 'asc' ? 'angle-down' : 'angle-up'
  end
  
  def dropdown_tag(tag_name, name, content_or_options = nil, options = nil, &block)
    raise ArgumentError, 'Missing block or content' unless block_given? || content_or_options
    
    if block_given?
      content_or_options ||= {}
      options, content_or_options = content_or_options, capture(&block)
    else
      options ||= {}
    end
    
    main_class    = tag_name == :button ? 'btn-group' : 'dropdown'
    main_class    = [main_class, options.delete(:main_class)].compact.join(' ')
    current_title = @selected || t('sort.not_selected') if options.delete(:selected_in_title)
    
    options['id']            ||= "dropdown_#{name}"
    options['data-toggle']   ||= 'dropdown'
    options['aria-haspopup'] ||= 'true'
    options['aria-expanded'] ||= 'false'
    options[:btn_style]      ||= 'secondary' if tag_name == :button
    options[:class] = ["btn dropdown-toggle btn-#{options.delete(:btn_style)}", options[:class]].compact.join(' ')
    
    content = content_tag(:div, class: 'dropdown-menu') { content_or_options }
    content_tag(:div, class: main_class) do
      if tag_name == :button
        button_tag(current_title, options).concat(content)
      else
        link_to(current_title, 'javascript:;', options).concat(content)
      end
    end
  end
end