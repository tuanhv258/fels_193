module ApplicationHelper

  def corrected_user
    @user = User.find_by params[:id]
    redirect_to root_url unless current_user? @user
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "page.usercontroller.loggeddanger"
      redirect_to login_url
    end
  end

  def gravatar_for user, size: Settings.size
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    gravatar_url =
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.fullname,
      class: "gravatar img-circle img-center")
  end

  def index_plus index, per_page
    (params[:page].to_i - 1) * per_page + 1 +index
  end

  def link_to_function name, *args, &block
   html_options = args.extract_options!.symbolize_keys
   function = block_given? ? update_page(&block) : args[0] || ""
   onclick = "#{"#{html_options[:onclick]}; " if
    html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"
   content_tag :a, name,
    html_options.merge(:href => href, :onclick => onclick)
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "btn remove danger")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')", :class => "btn")
  end
end