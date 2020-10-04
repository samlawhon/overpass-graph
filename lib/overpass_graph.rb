require_relative './overpass_graph/get_roads'
require_relative './overpass_graph/create_vertex_set'
require_relative './overpass_graph/create_adjacency_hash'

def overpass_graph(north, east, south, west, directed: true, filter_by_allowing: true, filtered_values:[])

    allowed_values = []
    disallowed_values = []

    filter_by_allowing ? allowed_values = filtered_values : disallowed_values = filtered_values

    roads = get_roads(north, east, south, west, allowed_values, disallowed_values)

    vertices = create_vertex_set(roads)

    return create_adjacency_hash(roads, vertices, directed)

end
