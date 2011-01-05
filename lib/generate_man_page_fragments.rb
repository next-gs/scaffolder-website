def generate_man_page_fragments
  content = File.join(%W|#{File.dirname(__FILE__)} .. content|)
  src = File.join(%W|#{content} code scaffolder-tools man *|)
  dst = File.join(%W|#{content} markup man|)

  Dir[src].each do |file|
    File.open(dst + '/' + File.basename(file) + '.html','w') do |out|
      out.puts `ronn --pipe --html --fragment #{file}`
    end
  end
end
