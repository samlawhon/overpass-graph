require 'overpass_api_ruby'

TIMEOUT = 900  # in seconds (15m)
MAXSIZE = 1_073_741_824  # about 1 GB (server may abort for queries near the uppper end of this range, especially at peak hours)

def get_roads(north, east, south, west, allowed_values, disallowed_values)
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
        timeout: TIMEOUT,
        maxsize: MAXSIZE
    }

    allowed_string = allowed_values.map{|allowed_value| "[highway=#{allowed_value}]" }.join()
    disallowed_string = disallowed_values.map{|disallowed_value| "[highway!=#{disallowed_value}]" }.join()

    # query for all highways within the bounding box
    overpass = OverpassAPI::QL.new(options)
    query = "way[highway]#{allowed_string}#{disallowed_string};(._;>;);out geom;"
    
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