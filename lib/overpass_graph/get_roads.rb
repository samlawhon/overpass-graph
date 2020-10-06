require 'overpass_api_ruby'

module OverpassGraph

  TIMEOUT = 900  # in seconds (15m)
  MAXSIZE = 1_073_741_824  # about 1 GB (server may abort for queries near the uppper end of this range, especially at peak hours)

  def self.get_roads(north, east, south, west, allowed_values, disallowed_values)
    '''
    Gets roads by querying the Overpass API.
    :return: a list of hashes with information about all the roads in the bounding box
    '''
  
    if 90 < north || 90 < south || north < -90 || south < -90
      raise "Latitudes in bounding boxes must be between -90.0 and 90.0"
    end
  
    if 180 < east || 180 < west || east < -180 || west < -180
      raise "Longitudes in bounding boxes must be between -180.0 and 180.0"
    end
  
    if north < south
      raise "Northern latitude is less than southern latitude.\nDid you mean 'overpass_graph(#{south}, #{east}, #{north}, #{west}...)"
    end
  
    if east < west
      puts "OVERPASS_GRAPH WARNING: Eastern longitude is less than western longitude.\n"\
           "In most cases this is not intended by the developer.\n"\
           "Perhaps you meant 'overpass_graph(#{north}, #{west}, #{south}, #{east}...)'?\n"\
           "Find out more here: https://dev.overpass-api.de/overpass-doc/en/full_data/bbox.html"
    end
  
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

end