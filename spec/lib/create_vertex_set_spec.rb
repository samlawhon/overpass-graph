require_relative '../spec_helper'
require_relative '../../lib/overpass_graph/get_roads'
require_relative '../../lib/overpass_graph/create_vertex_set'

shore_acres_roads = shore_acres_roads()
midtown_roads = midtown_roads()
hanover_roads = hanover_roads()

shore_acres_vertices = create_vertex_set(shore_acres_roads)
midtown_vertices = create_vertex_set(midtown_roads)
hanover_vertices = create_vertex_set(hanover_roads)

describe "Shore Acres, Mamaroneck, NY analysis" do
  
  describe "the first and last coordinates of all roads" do
    it "should be included in the vertex set" do
      shore_acres_roads.each do |road|
        road_coords = road[:geometry]
        first = [road_coords[0][:lat], road_coords[0][:lon]]
        last = [road_coords[-1][:lat], road_coords[-1][:lon]]
        expect(shore_acres_vertices).to include(first)
        expect(shore_acres_vertices).to include(last)
      end
    end
  end

  describe "intersections that are not road endpoints" do
    shore_acres_intersection = [40.9469554, -73.7241626]  # intersection of the Parkway and South Barry Avenue
    it "should be included in the vertex set" do
      expect(shore_acres_vertices).to include(shore_acres_intersection)
    end
  end
   
  describe "coordinates that are not road endpoints nor intersections" do
    shore_acres_single_path_coord = [40.9500877, -73.7221500]   # coordinate along Creek Road
    it "should not be included in the vertex set" do
      expect(shore_acres_vertices).not_to include(shore_acres_single_path_coord)
    end
  end

end

describe "Midtown, Manhattan, NY analysis" do
  
  describe "the first and last coordinates of all roads" do
    it "should be included in the vertex set" do
      midtown_roads.each do |road|
        road_coords = road[:geometry]
        first = [road_coords[0][:lat], road_coords[0][:lon]]
        last = [road_coords[-1][:lat], road_coords[-1][:lon]]
        expect(midtown_vertices).to include(first)
        expect(midtown_vertices).to include(last)
      end
    end
  end

  describe "intersections that are not road endpoints" do
    midtown_intersection = [40.7614503, -73.9840983]  # intersection of the Broadway and West 50th Street
    it "should be included in the vertex set" do
      expect(midtown_vertices).to include(midtown_intersection)
    end
  end
   
  describe "coordinates that are not road endpoints nor intersections" do
    midtown_single_path_coord = [40.7613880, -73.9841402]   # coordinate along Broadway
    it "should not be included in the vertex set" do
      expect(midtown_vertices).not_to include(midtown_single_path_coord)
    end
  end

end

describe "Hanover, NH analysis" do

  describe "the first and last coordinates of all roads" do
    it "should be included in the vertex set" do
      hanover_roads.each do |road|
        road_coords = road[:geometry]
        first = [road_coords[0][:lat], road_coords[0][:lon]]
        last = [road_coords[-1][:lat], road_coords[-1][:lon]]
        expect(hanover_vertices).to include(first)
        expect(hanover_vertices).to include(last)
      end
    end
  end

  describe "intersections that are not road endpoints" do
    hanover_intersection = [43.7014640, -72.2895119]  # intersection of sidewalk and Allen street
    it "should be included in the vertex set" do
      expect(hanover_vertices).to include(hanover_intersection)
    end
  end
   
  describe "coordinates that are not road endpoints nor intersections" do
    hanover_single_path_coord = [43.7012278, -72.2895270]   # coordinate on main street sidewalk
    it "should not be included in the vertex set" do
      expect(hanover_vertices).not_to include(hanover_single_path_coord)
    end
  end
  
end
