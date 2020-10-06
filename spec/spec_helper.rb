# these are defined outside of the describe function so as to avoid unnecessary api calls

# analysis of Shore Acres, Mamaroneck, NY
def shore_acres_roads
  shore_acres_north = 40.95352042058797
  shore_acres_east = -73.71407747268677
  shore_acres_south = 40.94329381595473
  shore_acres_west = -73.73105049133301
  get_roads(shore_acres_north, shore_acres_east, shore_acres_south, shore_acres_west, [], [])
end

# analysis of (a small section of) Midtown, Manhattan, NY
def midtown_roads
  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  get_roads(midtown_north, midtown_east, midtown_south, midtown_west, [], [])
end

# analysis of Midtown, Manhattan, NY only 'primary' roads
def midtown_primary_roads
  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  get_roads(midtown_north, midtown_east, midtown_south, midtown_west, ['primary'], [])
end

# analysis of Midtown, Manhattan, NY no 'primary' roads
def midtown_no_primary_roads
  midtown_north = 40.764104432913086
  midtown_east = -73.97675156593323
  midtown_south = 40.75897668730365
  midtown_west = -73.98523807525635
  get_roads(midtown_north, midtown_east, midtown_south, midtown_west, [], ['primary'])
end

# analysis of Hanover, NH
def hanover_roads
  hanover_north = 43.7031803975023
  hanover_east = -72.28413820266724
  hanover_south = 43.69828604529516
  hanover_west = -72.29262471199036
  get_roads(hanover_north, hanover_east, hanover_south, hanover_west, [], [])
end

# analysis of invalid latitude query
def invalid_latitude_roads
  north = 91
  east = -100
  south = 90
  west = -101
  get_roads(north, east, south, west, [], [])
end

# analysis of invalid longitude query
def invalid_longitude_roads
  north = 80
  east = -178
  south = 79
  west = -181
  get_roads(north, east, south, west, [], [])
end

# analysis of invalid latitude (south greater than north) query
def south_greater_than_north_roads
  north = 78
  east = -100
  south = 79
  west = -101
  get_roads(north, east, south, west, [], [])
end
