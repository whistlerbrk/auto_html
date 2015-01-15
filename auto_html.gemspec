Gem::Specification.new do |gem|
  gem.name = 'auto_html-whistlerbrk'
  gem.version = '2.0.0-pre'

  gem.summary = "Transform URIs to appropriate markup"
  gem.description = "Automatically transforms URIs (via domain) and includes the destination resource (Vimeo, YouTube movie, image, ...) in your document"

  gem.authors  = ['Dejan Simic']
  gem.email    = 'desimic@gmail.com'
  gem.homepage = 'http://github.com/dejan/auto_html'

  gem.add_dependency('rinku', '~> 1.7')
  gem.add_dependency('redcarpet', '~> 3.1')

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*',
                  'README*', 'LICENSE'] & `git ls-files -z`.split("\0")
end

