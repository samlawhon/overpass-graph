require_relative '../spec_helper'
require_relative '../../lib/overpass_graph/get_roads'

shore_acres_roads = shore_acres_roads()
midtown_roads = midtown_roads()
hanover_roads = hanover_roads()

describe "Shore Acres, Mamaroneck, NY analysis" do 

    describe "roads data type" do
        it "should be an array" do
            expect(shore_acres_roads).to be_a(Array)
        end
    end

    describe "elements in roads array" do
        it "should only include hashes of type 'way'" do
            expect( shore_acres_roads.filter{|road| road[:type] == 'way'}.length ).to eq(shore_acres_roads.length)
        end
    end

end

describe "Midtown, Manhattan, NY analysis" do 

    describe "roads data type" do
        it "should be an array" do
            expect(midtown_roads).to be_a(Array)
        end
    end

    describe "elements in roads array" do
        it "should only include hashes of type 'way'" do
            expect( midtown_roads.filter{|road| road[:type] == 'way'}.length ).to eq(midtown_roads.length)
        end
    end

end

describe "Hanover, NH analysis" do

    describe "roads data type" do
        it "should be an array" do
            expect(hanover_roads).to be_a(Array)
        end
    end

    describe "elements in roads array" do
        it "should only include hashes of type 'way'" do
            expect( hanover_roads.filter{|road| road[:type] == 'way'}.length ).to eq(hanover_roads.length)
        end
    end

end