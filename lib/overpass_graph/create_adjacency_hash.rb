require 'haversine'

def create_adjacency_hash(roads, vertices, directed, metric)
    """
    Creates an adjacency hash from a list of roads and set of vertices. 
    
    The graph is represented as a hash of hashes, where the keys are coordinate pairs [lat, lon] (as a list), 
    and the values are hashes that contain neighbor coordinate pairs as keys and edge lengths as values.
    If an edge exists from a coordinate pair, x, to coordinate pair, y, of length z, then adj[x][y] will equal z.
    
    Here's an example: { [lat1, lon1] => { [lat2, lon2] => distance1, [lat3, lon3] => distance2 } }
    In this example, there is an edge from [lat1, lon1] to [lat2, lon2] of length distance1 and an edge from [lat1, lon1] to [lat3, lon3] of length distance2.

    :return: adjacency hash representation of a graph
    """
    adj = {}

    roads.each do |road|

        road_nodes = road[:geometry]

        start_vertex = [road_nodes[0][:lat], road_nodes[0][:lon]]
        if !adj.has_key?(start_vertex)
            adj[start_vertex] = {}
        end

        # Need to keep track of the distance travelled along road, the previous node (to increment distance)
        # and the previous vertex. Upon discovering a new vertex in the iteration, an edge is created from
        # the previous vertex to the discovered vertex (and if the road is two-way, from the discovered 
        # vertex back to the previous vertex)
        distance = 0
        prev_node = { coords: start_vertex, distance: distance }
        prev_vertex = { coords: start_vertex, distance: distance }

        (1..road_nodes.length - 1).each do |i|

            current = [road_nodes[i][:lat], road_nodes[i][:lon]]
            
            # updating distance with previous node and current node
            if !metric
                distance += Haversine.distance(prev_node[:coords][0], prev_node[:coords][1], current[0], current[1]).to_miles
            else
                distance += Haversine.distance(prev_node[:coords][0], prev_node[:coords][1], current[0], current[1]).to_km
            end
            
            # if the current node is in the set of vertices, calculate the distance between it and the previous vertex.
            # Then add an edge of that length from the previous vertex to the current node. If the road is two-way, also add an edge
            # from the current node back to the previous vertex.
            if vertices === current

                distance_between = distance - prev_vertex[:distance]

                if road[:tags][:oneway] != 'yes' || !directed
                    if adj.has_key?(current)
                        adj[current][prev_vertex[:coords]] = distance_between
                    else
                        adj[current] = { prev_vertex[:coords] => distance_between }
                    end
                end

                if adj.has_key?(prev_vertex[:coords])
                    adj[prev_vertex[:coords]][current] = distance_between
                else
                    adj[prev_vertex[:coords]] = { current => distance_between }
                end

                prev_vertex = {coords: current, distance: distance}
            end

            # previous node kept track of to calculate distance along the road
            prev_node = {coords: current, distance: distance}
        end

    end

    return adj

end