require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/module/attribute_accessors'

module AutoHtml
  extend self

  def self.add_filter(name, &block)
    AutoHtml::Builder.add_filter(name, &block)
  end

  def auto_html(raw, options = {}, &proc)
    return "" if raw.blank?
    builder = Builder.new(raw, options)
    result = builder.instance_eval(&proc)
    return raw if result.nil?
    result.respond_to?(:html_safe) ?
      result.html_safe :
        result
  end

end
