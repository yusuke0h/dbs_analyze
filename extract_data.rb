require 'nokogiri'
require 'pp'

f = File.open("data.html")
doc = Nokogiri::HTML(f)
f.close

data = []
keys = Hash.new(0)

doc.css("div #comments > div").each do |div|
  if div.text.include?("【午前")
    tmp_h = {}
    div.css("div.comment").text.split("【").each do |content|
      pair = content.split("】").map { |e| e.strip }
      if pair.size == 2
        tmp_h[pair.first] = pair.last
        keys[pair.first] += 1
      end
    end
    data << tmp_h
  end
end

print keys.keys.join(", ")
puts ""

data.each do |record|
  tmp_a = []
  keys.keys.each do |key|
    tmp_a << record[key]
  end
  print tmp_a.join(", ")
  puts ""
end