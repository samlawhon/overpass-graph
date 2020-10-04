require 'set'

def create_vertex_set(roads)
    '''
    Function to process a list of road hashes and return the set of vertex coordinates from that list.
    Vertices are any coordinates that either: a) begin or end a road or b) are found within at least two roads (i.e. intersections)
    :return: a set of vertices
    '''

    # frequency map of times a given node appears in all roads
    node_count = {}

    roads.each do |road|

        road_nodes = road[:geometry]
        start_vertex = [road_nodes[0][:lat], road_nodes[0][:lon]]
        end_vertex = [road_nodes[-1][:lat], road_nodes[-1][:lon]]

        # this ensures that each start and end vertex will be included in the set of returned
        # vertices, because post iteration they'll both have at least 2 in node_count
        if !node_count.has_key?(start_vertex)
            node_count[start_vertex] = 1
        end
        if !node_count.has_key?(end_vertex)
            node_count[end_vertex] = 1
        end
        
        # this will pick up any nodes that form intersections (i.e. are nodes in multiple roads),
        # but aren't the starting or ending nodes of any road
        road_nodes.each do |node|
            current = [node[:lat], node[:lon]]
            if !node_count.has_key?(current)
                node_count[current] = 1
            else
                node_count[current] += 1
            end
        end
    end

    return Set.new( node_count.filter{ |node, num| num > 1 }.keys )

end