require 'overpass_api_ruby'

def get_roads(north, east, south, west)
    '''
    Gets roads by querying the Overpass API.
    :return: a list of hashes with information about all the roads in the bounding box
    '''
    options = {
        bbox: {
            s: south,
            n: north,
            w: west,
            e: east
        },
        timeout: 2000,
        maxsize: 1073741824
    }

    # query for all highways within the bounding box
    overpass = OverpassAPI::QL.new(options)
    query = "way['highway'];(._;>;);out geom;"
    
    begin
        response = overpass.query(query)
    rescue
        
        # try again if first request is denied, if second request is denied, throw the exception
        response = overpass.query(query)

    end

    # filter out all partial roads and return the filtered hash
    elements = response[:elements]
    return elements.filter { |element| element[:type] == "way" }

end