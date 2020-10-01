require 'overpass_api_ruby'

def get_roads(north, east, south, west)
    
    options = {
        bbox: {
            s: south,
            n: north,
            w: west,
            e: east
        },
        timeout: 900,
        maxsize: 1073741824
    }

    # query for all highways within the bounding box
    overpass = OverpassAPI::QL.new(options)
    query = "way['highway'];(._;>;);out geom;"
    response = overpass.query(query)

    # filter out all partial roads and return the filtered hash
    elements = response[:elements]
    elements.filter { |element| element[:type] == "way" }

end