1.upto(10) do |i|
  Event.create(title: "Article #{i}",
               description: "Its random article #{i+rand(100)} =)",
               tags: "tags",
               category: "Random category #{i+rand(100)}",
               url: "https://#{i}"
               )
end
