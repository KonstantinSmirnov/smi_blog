module ApplicationHelper

  def title(title)
    if Setting.first.nil?
      "Welcome | #{title}"
    else
      "#{Setting.first.website_title} | #{title}"
    end
  end

  def meta_tag(tag, text)
    content_for :"meta_#{tag}", text
  end

  def yield_meta_tag(tag, default_text='')
    content_for?(:"meta_#{tag}") ? content_for(:"meta_#{tag}") : default_text
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def namespace?(*namespace)
    namespace.include?(params[:controller].split('/').first)
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: false)
    options = {
        autolink: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        lax_html_blocks: true,
        strikethrough: true,
        superscript: true,
        space_after_headers: true,
        tables: true
    }
    Redcarpet::Markdown.new(renderer, options).render(text).html_safe
  end

  def category_active?(category)
    if params[:controller] == "blog/categories" && params[:id]
      @category = Category.find_by(:slug => params[:id])
      @category == category ? true : false
    end
  end

end
