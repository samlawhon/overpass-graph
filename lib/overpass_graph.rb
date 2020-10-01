require_relative './overpass_graph/get_roads'
require_relative './overpass_graph/create_vertex_set'
require_relative './overpass_graph/create_adjacency_hash'

def overpass_graph(north, east, south, west)

    roads = get_roads(north, east, south, west)

    vertices = create_vertex_set(roads)

    return create_adjacency_hash(roads, vertices)

end
