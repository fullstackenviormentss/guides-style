require 'jekyll'
require 'safe_yaml'

module GuidesStyle18F
  class Breadcrumbs
    def self.create(site)
      (site.config['navigation'] || []).flat_map do |nav|
        Breadcrumbs.generate_breadcrumbs(nav, '/', [])
      end.to_h
    end

    def self.generate_breadcrumbs(nav, parent_url, parents)
      url = parent_url + (nav['url'] || '')
      crumbs = parents + [{ 'url' => url, 'text' => nav['text'] }]
      child_crumbs = (nav['children'] || []).flat_map do |child|
        generate_breadcrumbs(child, url, crumbs)
      end
      [[url, crumbs]] + child_crumbs
    end
  end
end
