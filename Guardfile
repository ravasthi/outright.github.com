guard 'jekyll' do
  ignore(%r{_site/}, %r{public/})
  watch(%r{.+})
end

# Tell the browser to automatically reload whenever anything changes in the
# _site directory. See https://github.com/guard/guard-livereload
guard 'livereload' do
  watch(%r{_site/.+})
end
