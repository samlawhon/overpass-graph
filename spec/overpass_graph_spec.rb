require_relative '../lib/overpass_graph'

DISTANCE_ERROR_TOLERANCE = 0.03   # % different from Google maps

describe "graph for Shore Acres, Mamaroneck, NY" do

  shore_acres_north = 40.95352042058797
  shore_acres_east = -73.71407747268677
  shore_acres_south = 40.94329381595473
  shore_acres_west = -73.73105049133301
  shore_acres_graph = overpass_graph(shore_acres_north, shore_acres_east, shore_acres_south, shore_acres_west)

  describe "one way street" do
    describe "the Parkway" do
      beginning = [40.9469554, -73.7241626]   # intersection of the Parkway and South Barry Avenue
      ending = [40.9451575, -73.7254262]
      distance = 0.14  # miles, per Google maps (approximate)

      it "should be about 0.14 miles to the next intersection" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(shore_acres_graph[beginning][ending]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the intersection of the Parkway and South Barry to the next intersection" do
        expect(shore_acres_graph[beginning]).to include(ending)
      end

      it "should not have an edge from that next intersection BACK to the intersection of the Parkway and South Barry" do
        expect(shore_acres_graph[ending]).not_to include(beginning)
      end
    end
  end

  describe "two way street" do
    describe "Oakhurst Road" do
      beginning_of_oakhurst = [40.9453010, -73.7272770]   # intersection with Shore Acres drive
      end_of_oakhurst = [40.9477130, -73.7245710]   # intersection with South Barry Avenue
      distance = 0.23  # miles, per Google maps (approximate)

      it "should be about 0.23 miles between the intersections" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(shore_acres_graph[beginning_of_oakhurst][end_of_oakhurst]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the intersection with Shore Acres Drive to the intersection with South Barry Avenue" do
        expect(shore_acres_graph[beginning_of_oakhurst]).to include(end_of_oakhurst)
      end

      it "should have an edge the intersection with South Barry Avenue BACK to the intersection with Shore Acres Drive" do
        expect(shore_acres_graph[end_of_oakhurst]).to include(beginning_of_oakhurst)
      end
    end
  end

  describe "intersection of Shore Acres Drive and Oakhurst Road" do
    intersection = [40.9453010, -73.7272770]
    it "should have 3 neighbor vertices" do
      expect(shore_acres_graph[intersection].keys.length).to eq(3)
    end

    it "should have the intersection of Shore Acres Drive and South Barry Avenue as a neighbor" do
      second_intersection = [40.9487330, -73.7250660]
      expect(shore_acres_graph[intersection]).to include(second_intersection)
    end

    it "should have intersection of Shore Acres Drive and the Parkway as a neighbor" do
      second_intersection = [40.9437791, -73.7263091]
      expect(shore_acres_graph[intersection]).to include(second_intersection)
    end

    it "should have the intersection of Oakhurst Road and South Barry Avenue as a neighbor" do
      second_intersection = [40.9477130, -73.7245710]
      expect(shore_acres_graph[intersection]).to include(second_intersection)
    end
  end

end

describe "graph for Shore Acres, Mamaroneck, NY with metric distances" do

  shore_acres_north = 40.95352042058797
  shore_acres_east = -73.71407747268677
  shore_acres_south = 40.94329381595473
  shore_acres_west = -73.73105049133301
  shore_acres_graph = overpass_graph(shore_acres_north, shore_acres_east, shore_acres_south, shore_acres_west, metric: true)

  describe "one way street" do
    describe "the Parkway" do
      beginning = [40.9469554, -73.7241626]   # intersection of the Parkway and South Barry Avenue
      ending = [40.9451575, -73.7254262]
      distance = 0.225  # km, per Google maps (approximate)

      it "should be about 0.225 km to the next intersection" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(shore_acres_graph[beginning][ending]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the intersection of the Parkway and South Barry to the next intersection" do
        expect(shore_acres_graph[beginning]).to include(ending)
      end

      it "should not have an edge from that next intersection BACK to the intersection of the Parkway and South Barry" do
        expect(shore_acres_graph[ending]).not_to include(beginning)
      end
    end
  end

  describe "two way street" do
    describe "Oakhurst Road" do
      beginning_of_oakhurst = [40.9453010, -73.7272770]   # intersection with Shore Acres drive
      end_of_oakhurst = [40.9477130, -73.7245710]   # intersection with South Barry Avenue
      distance = 0.37  # km, per Google maps (approximate)

      it "should be about 0.37 km between the intersections" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(shore_acres_graph[beginning_of_oakhurst][end_of_oakhurst]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the intersection with Shore Acres Drive to the intersection with South Barry Avenue" do
        expect(shore_acres_graph[beginning_of_oakhurst]).to include(end_of_oakhurst)
      end

      it "should have an edge the intersection with South Barry Avenue BACK to the intersection with Shore Acres Drive" do
        expect(shore_acres_graph[end_of_oakhurst]).to include(beginning_of_oakhurst)
      end
    end
  end

end

describe "graph for (part of) Midtown, Manhattan, NY" do

  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  midtown_graph = overpass_graph(midtown_north, midtown_east, midtown_south, midtown_west)

  describe "one way street" do
    describe "West 50th Street" do
      beginning = [40.7614200, -73.9840231]   # intersection of Broadway sidewalk and West 50th Street
      ending = [40.7612779, -73.9836865]    # end of western half of West 50th Street
      distance = 0.02  # miles, per Google maps (approximate)

      it "should be about 0.02 miles to the end of the western half of West 50th Street" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(midtown_graph[beginning][ending]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the intersection of Broadway and West 50th Street to the end of the western half of West 50th Street" do
        expect(midtown_graph[beginning]).to include(ending)
      end

      it "should not have an edge from the end of the western half of West 50th Street BACK to the intersection of Broadway and West 50th Street" do
        expect(midtown_graph[ending]).not_to include(beginning)
      end
    end
  end

  # no two-way streets in that section of Midtown

  describe "intersection of West 52nd Street and 8th Avenue" do
    intersection = [40.7635400, -73.9851929]
    it "should have 2 neighbor vertices" do
      expect(midtown_graph[intersection].keys.length).to eq(2)
    end

    it "should have the intersection of Broadway and West 52nd as a neighbor" do#
      second_intersection = [40.7627246, -73.9832662]
      expect(midtown_graph[intersection]).to include(second_intersection)
    end

    it "should have the end of southern 8th Avenue as a neighbor" do#
      end_southern_8th_av = [40.7640077, -73.9848520]
      expect(midtown_graph[intersection]).to include(end_southern_8th_av)
    end
  end

end

describe "undirected graph for (part of) Midtown, Manhattan, NY" do

  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  midtown_graph = overpass_graph(midtown_north, midtown_east, midtown_south, midtown_west, directed: false)

  describe "one way street" do
    describe "West 50th Street" do
      beginning = [40.7614200, -73.9840231]   # intersection of Broadway sidewalk and West 50th Street
      ending = [40.7612779, -73.9836865]    # end of western half of West 50th Street

      it "should have an edge from the intersection of Broadway and West 50th Street to the end of the western half of West 50th Street" do
        expect(midtown_graph[beginning]).to include(ending)
      end

      it "should have an edge from the end of the western half of West 50th Street BACK to the intersection of Broadway and West 50th Street" do
        expect(midtown_graph[ending]).to include(beginning)
      end
    end
  end

end

describe "graph for (part of) Midtown, Manhattan, NY excluding 'secondary' highways" do

  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  midtown_graph = overpass_graph(midtown_north, midtown_east, midtown_south, midtown_west, filter_by_allowing: false, filtered_values:['secondary'])

  describe "'secondary' highway" do
    describe "West 50th Street" do
      beginning = [40.7614200, -73.9840231]   # intersection of Broadway sidewalk and West 50th Street
      ending = [40.7612779, -73.9836865]    # end of western half of West 50th Street

      it "should not have beginning as a vertex, because while Broadway will be present in the graph, the 'beginning' node will only be on Broadway, hence not a vertex" do
        expect(midtown_graph).not_to include(beginning)
      end

      it "should not have ending as a vertex, because West 50th street as a 'secondary' highway should not be included in the graph" do
        expect(midtown_graph).not_to include(ending)
      end
    end
  end

end

describe "graph for (part of) Midtown, Manhattan, NY including only 'secondary' highways" do

  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  midtown_graph = overpass_graph(midtown_north, midtown_east, midtown_south, midtown_west, filtered_values:['secondary'])

  describe "'secondary' highway" do
    describe "West 50th Street" do
      beginning = [40.7614200, -73.9840231]   # intersection of Broadway sidewalk and West 50th Street
      ending = [40.7612779, -73.9836865]    # end of western half of West 50th Street

      it "should not have beginning as a vertex, because while West 50th Street will be present in the graph, the 'beginning' node will only be only on West 50th Street, hence not a vertex" do
        expect(midtown_graph).not_to include(beginning)
      end

      it "should have ending as a vertex, because West 50th street is a 'secondary' highway and its end should be a vertex in the graph" do
        expect(midtown_graph).to include(ending)
      end
    end
  end

end

describe "graph for Hanover, NH" do

  hanover_north = 43.7031803975023
  hanover_east = -72.28413820266724
  hanover_south = 43.69828604529516
  hanover_west = -72.29262471199036
  hanover_graph = overpass_graph(hanover_north, hanover_east, hanover_south, hanover_west)
  
  describe "one way street" do
    describe "allen street" do
      beginning = [43.7014640, -72.2895119]
      first_intersection = [43.7014774, -72.2904003]
      distance = 0.045  # miles, per Google maps

      it "should be about 0.045 miles to the first_intersection" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(hanover_graph[beginning][first_intersection]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the start of Allen street to the first_intersection" do
        expect(hanover_graph[beginning]).to include(first_intersection)
      end

      it "should not have an edge from the first_intersection to the start of Allen street" do
        expect(hanover_graph[first_intersection]).not_to include(beginning)
      end
    end
  end

  describe "two way street" do
    describe "south main street" do
      intersection_with_allen = [43.7014618, -72.2893677]
      ending = [43.7016272, -72.2893621]
      distance = 0.0117   # miles, per Google maps

      it "should be about 0.012 miles between the intersections" do
        distance_low_threshold = (1 - DISTANCE_ERROR_TOLERANCE) * distance
        distance_high_threshold = (1 + DISTANCE_ERROR_TOLERANCE) * distance
        expect(hanover_graph[intersection_with_allen][ending]).to be_between(distance_low_threshold, distance_high_threshold)
      end

      it "should have an edge from the intersection with Allen to the next intersection" do
        expect(hanover_graph[intersection_with_allen]).to include(ending)
      end

      it "should have an edge from the next intersection BACK to the intersection with Allen" do
        expect(hanover_graph[ending]).to include(intersection_with_allen)
      end
    end
  end

  describe "intersection of South Main Street and Lebanon Street" do
    intersection = [43.7008596, -72.2894113]
    it "should have 3 neighbor vertices" do
      expect(hanover_graph[intersection].keys.length).to eq(3)
    end

    it "should have the Lebanon Street crosswalk as a neighbor" do
      crosswalk = [43.7008604, -72.2893116]
      expect(hanover_graph[intersection]).to include(crosswalk)
    end

    it "should have the crosswalk south of it as a neighbor" do
      crosswalk = [43.7008276, -72.2894165]
      expect(hanover_graph[intersection]).to include(crosswalk)
    end

    it "should have the crosswalk north of it as a neighbor" do
      crosswalk = [43.7009357, -72.2894056]
      expect(hanover_graph[intersection]).to include(crosswalk)
    end
  end

end