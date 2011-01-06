include Nanoc3::Helpers::Rendering
include Nanoc3::Helpers::LinkTo

def highlight(lang)
  "<pre class=\"class=prettyprint\">"
end

def endhighlight
  "</pre>"
end

def image(url,width=400)
  "<img src='#{relative_path_to(url)}' width=#{width}>"
end
