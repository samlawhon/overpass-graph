require 'overpass_graph/get_roads'
require 'overpass_graph/create_vertex_list'
require 'overpass_graph/create_adjacency_hash'

def overpass_graph(north, east, south, west)

    roads = get_roads(north, east, south, west)

    vertices = create_vertex_list(roads)

    create_adjacency_hash(roads, vertices)

end
