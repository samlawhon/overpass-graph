
def create_adjacency_hash(roads, vertices)

    adj = {}

    roads.each do |road|

        road_nodes = road[:geometry]

        start_vertex = [road_nodes[0][:lat], road_nodes[0][:lon]]
        if !adj.has_key?(start_vertex)
            adj[start_vertex] = []
        end

        # as we iterate through the nodes in the road, we need to keep track of the distance
        # we've traveled so far along the road, the previous node (to incremenent distance),
        # and the previous vertex to join it with any new vertex we discover
        distance = 0
        prev_node = { coords: start_vertex, distance: distance }
        prev_vertex = { coords: start_vertex, distance: distance }

        (1..road_nodes.length - 1).each do |i|

            current = [road_nodes[i][:lat], road_nodes[i][:lon]]
            
            # updating distance with previous node and current node
            distance += haversine_distance(prev_node[:coords][0], prev_node[:coords][1], current[0], current[1], true)
            
            # if the current node is in the set of vertices, calculate the distance between it and the previous vertex,
            # then add the previous vertex as a neighbor of the current in adj, and the current as a neighbor of
            # the previous vertex in adj, both with the same weight equal to distance between. Finally, just update
            # the previous vertex
            if vertices === current

                distance_between = distance - prev_vertex[:distance]

                if adj.has_key?(current)
                    adj[current].push( {coords: prev_vertex[:coords], distance: distance_between})
                else
                    adj[current] = [ {coords: prev_vertex[:coords], distance: distance_between} ]
                end
                adj[prev_vertex[:coords]].push( {coords: current, distance: distance_between} )

                prev_vertex = {coords: current, distance: distance}
            end

            # previous node kept track of to calculate distance along the road
            prev_node = {coords: current, distance: distance}
        end

    end

    adj

end