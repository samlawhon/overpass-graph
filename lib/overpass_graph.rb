require_relative './overpass_graph/get_roads'
require_relative './overpass_graph/create_vertex_set'
require_relative './overpass_graph/create_adjacency_hash'

def overpass_graph(north, east, south, west, directed: true, filter_by_allowing: true, filtered_values:[], metric: false)
  '''
  Primary function for the library. The user may specify whether to filter by allowing or not, in addition to  a few other options.
  If they choose to filter by allowing certain road types, the get roads function will be passed an empty array for disallowed values.
  If they choose to filter by disallowing certain road types, the get roads function will be passed an empty array for allowed values.
  :return: adjacency map representation of a graph
  '''
  allowed_values = []
  disallowed_values = []

  filter_by_allowing ? allowed_values = filtered_values : disallowed_values = filtered_values

  roads = get_roads(north, east, south, west, allowed_values, disallowed_values)

  vertices = create_vertex_set(roads)

  return create_adjacency_hash(roads, vertices, directed, metric)

end
