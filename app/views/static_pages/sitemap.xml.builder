xml.instruct!
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
    xml.url do
      xml.loc root_url
      xml.lastmod @home_page.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
    xml.url do
      xml.loc about_page_url
      xml.lastmod @about_page.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  @articles.each do |article|
    xml.url do
      xml.loc article_url(article)
      xml.lastmod article.updated_at.strftime('%Y-%m-%d')
      xml.changefreq 'daily'
      xml.priority '0.5'
    end
  end
end