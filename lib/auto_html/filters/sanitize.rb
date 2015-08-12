require 'rails-html-sanitizer'

AutoHtml.add_filter(:sanitize).with({}) do |text, options|
  Rails::Html::WhiteListSanitizer.new.sanitize(text, options)
end
