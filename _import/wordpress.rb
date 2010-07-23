require 'rubygems'
require 'sequel'
require 'fileutils'
require 'yaml'

# NOTE: This converter requires Sequel and the MySQL gems.
# The MySQL gem can be difficult to install on OS X. Once you have MySQL
# installed, running the following commands should work:
# $ sudo gem install sequel
# $ sudo gem install mysql -- --with-mysql-config=/usr/local/mysql/bin/mysql_config

module Jekyll
  module WordPress

    # Reads a MySQL database via Sequel and creates a post file for each
    # post in wp_posts that has post_status = 'publish'.
    # This restriction is made because 'draft' posts are not guaranteed to
    # have valid dates.
          # select post_title, post_name, post_date, post_content, post_excerpt, ID, guid from wp_13_posts where post_status = 'publish' and post_type = 'post'
    QUERY = <<-EOQ
      select post_title, post_name, post_date, post_excerpt, ID, guid, wp_13_terms.slug, post_content
      from wp_13_posts 
      left outer join wp_13_term_relationships on wp_13_posts.id = wp_13_term_relationships.object_id 
      left outer join wp_13_term_taxonomy on wp_13_term_relationships.term_taxonomy_id  = wp_13_term_taxonomy.term_taxonomy_id
      left outer join wp_13_terms on wp_13_terms.term_id = wp_13_term_taxonomy.term_id
      where post_status = 'publish' and post_type = 'post' and taxonomy = 'category';
    EOQ
    
    def self.process(dbname, user, pass, host = 'localhost')
      db = Sequel.mysql(dbname, :user => user, :password => pass, :host => host)

      FileUtils.mkdir_p "_posts"

      db[QUERY].each do |post|
        # Get required fields and construct Jekyll compatible name
        title = post[:post_title]
        slug = post[:post_name]
        date = post[:post_date]
        content = post[:post_content]
        name = "%02d-%02d-%02d-%s.markdown" % [date.year, date.month, date.day,
                                               slug]

        # Get the relevant fields as a hash, delete empty fields and convert
        # to YAML for the header
        data = {
           'layout' => 'post',
           'title' => title.to_s,
           'category' => post[:slug]
         }.delete_if { |k,v| v.nil? || v == ''}.to_yaml

        # Write out the data and content to file
        File.open("_posts/#{name}", "w") do |f|
          f.puts data
          f.puts "---"
          f.puts content
        end
      end

    end
  end
end
