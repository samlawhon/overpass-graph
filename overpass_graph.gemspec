Gem::Specification.new do |s|
  s.name          = 'overpass_graph'
  s.version       = '0.0.0'
  s.date          = '2020-10-01'
  s.summary       = "Creates a weighted, directed graph from Open Street Map data"
  s.description   = "Lightweight gem to create weighted, directed graphs of streets in a given bounding box. The library builds graphs using Open Street Map data queried through the Overpass API."
  s.authors       = ["Sam Lawhon"]
  s.email         = 'samlawhon1@gmail.com'
  s.files         = ["lib/overpass_graph.rb","lib/overpass_graph/get_roads.rb","lib/overpass_graph/create_vertex_set.rb","lib/overpass_graph/create_adjacency_hash.rb"]
  s.homepage      = 'https://github.com/samlawhon/overpass-graph'
  s.license       = 'MIT'
  s.add_dependency 'overpass-api-ruby', ["0.3.1 >=", "< 1.0.0"]
  s.add_dependency 'haversine', ["0.3.2 >=", "< 1.0.0"]
  s.add_development_dependency 'rspec', ["3.9.0 >="]
end