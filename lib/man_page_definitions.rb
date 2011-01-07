def man_page_definitions
  list = man_pages.inject(String.new) do |string,page|
    string << "<a href='#{link(page)}'><dt>#{tool_name(page)}</dt></a>\n"
    string << "<dd>#{tool_definition(page)}</dd>\n"
  end
  "<dl>\n" + list + "</dl>\n"
end

private

def man_pages
  files = File.join(%W|#{File.dirname(__FILE__)} .. content code scaffolder-tools man *.ronn|)
  Dir[files]
end

def link(file)
  relative_path_to('/man/' + File.basename(file).gsub(/\.\d\.ronn/,''))
end

def tool_name(file)
  file_first_line(file).split(' -- ').first
end

def tool_definition(file)
  file_first_line(file).split(' -- ').last
end

def file_first_line(file)
  File.readlines(file).first
end
