module Jekyll
  class MarkdownBlock < Liquid::Block
    def initialize(tag_name, text, tokens)
      super
    end
    require "kramdown"
    def render(context)
      content = super
      content = content.split(/\r?\n/)
      puts content.inspect

      minTabs = 9999
      for line in content
        if line.length > 0
          if line.index(/[^ ]/) and line.index(/[^ ]/) < minTabs
            minTabs = line.index(/[^ ]/)
          end
        end
      end

      if minTabs > 0
        content = content.map { |line|
          line[minTabs..-1]
        }
      end

      "#{Kramdown::Document.new(content.join("\n"), input: 'GFM').to_html}"
    end
  end
end
Liquid::Template.register_tag('markdown', Jekyll::MarkdownBlock)
