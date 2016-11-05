module ApplicationHelper
  require 'redcarpet'
  require 'rouge'
  require 'rouge/plugins/redcarpet'

  class HTML < Redcarpet::Render::HTML
    include Rouge::Plugins::Redcarpet
  end

  def markdown(text)
    renderer = HTML.new(hard_wrap: true, filter_html: false)
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

  def category_active?(category)
    if params[:controller] == "blog/categories" && params[:id]
      @category = Category.find_by(:slug => params[:id])
      @category == category ? true : false
    end
  end

  def should_be_white?
    controller?('home_page')
  end

end
