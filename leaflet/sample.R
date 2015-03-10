library(leaflet)
m = leaflet() %>% addTiles()
m
m = m %>% setView(-93.65, 42.0285, zoom = 17)
m
m %>% addPopups(-93.65, 42.0285, 'Here is the <b>Department of Statistics</b>, ISU')

# add some circles to a map
df = data.frame(Lat = 1:10, Long = rnorm(10))
leaflet(df) %>% addCircles()
# you can also explicitly use Lat and Long
leaflet(df) %>% addCircles(lat = ~ Lat, lng = ~ Long)

leaflet() %>% addCircles(data = df)
# or use df in addCircles() only
leaflet() %>% addCircles(data = df, lat = ~ Lat, lng = ~ Long)

library(sp)
Sr1 = Polygon(cbind(c(2, 4, 4, 1, 2), c(2, 3, 5, 4, 2)))
Sr2 = Polygon(cbind(c(5, 4, 2, 5), c(2, 3, 2, 2)))
Sr3 = Polygon(cbind(c(4, 4, 5, 10, 4), c(5, 3, 2, 5, 5)))
Sr4 = Polygon(cbind(c(5, 6, 6, 5, 5), c(4, 4, 3, 3, 4)), hole = TRUE)
Srs1 = Polygons(list(Sr1), "s1")
Srs2 = Polygons(list(Sr2), "s2")
Srs3 = Polygons(list(Sr4, Sr3), "s3/4")
SpP = SpatialPolygons(list(Srs1, Srs2, Srs3), 1:3)
leaflet(height = "300px") %>% addPolygons(data = SpP)

library(maps)
mapStates = map("state", fill = TRUE, plot = FALSE)
leaflet(data = mapStates) %>% addTiles() %>% addPolygons(fillColor = topo.colors(10, alpha = NULL), stroke = FALSE)


m = leaflet() %>% addTiles()
df = data.frame(
  lat = rnorm(100),
  lng = rnorm(100),
  size = runif(100, 5, 20),
  color = sample(colors(), 100)
)
m = leaflet(df) %>% addTiles()
m %>% addCircleMarkers(radius = ~size, color = ~color, fill = FALSE)
m %>% addCircleMarkers(radius = runif(100, 4, 10), color = c('red'))

leaflet() %>% addTiles() %>%
  addMarkers(174.7690922, -36.8523071, icon = JS("L.icon({iconUrl: 'http://cran.rstudio.com/Rlogo.jpg',iconSize: [40, 40]})")) %>%
  addPopups(174.7690922, -36.8523071, 'R was born here!')

leaflet() %>%
  addTiles(
    'http://server.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/{z}/{y}/{x}',
    attribution = 'Tiles &copy; Esri &mdash; Esri, DeLorme, NAVTEQ, TomTom, Intermap, iPC, USGS, FAO, NPS, NRCAN, GeoBase, Kadaster NL, Ordnance Survey, Esri Japan, METI, Esri China (Hong Kong), and the GIS User Community') %>%
  setView(-93.65, 42.0285, zoom = 17)

set.seed(123)
m = leaflet() %>% addTiles()
rand_lng = function(n = 10) rnorm(n, -93.65, .01)
rand_lat = function(n = 10) rnorm(n, 42.0285, .01)

# circles (units in metres)
m %>% addCircles(rand_lng(50), rand_lat(50), radius = runif(50, 10, 200))

# circle markers (units in pixels)
m %>% addCircleMarkers(rand_lng(50), rand_lat(50), color = '#ff0000')

m %>% addCircleMarkers(rand_lng(100), rand_lat(100), radius = runif(100, 5, 15))

# rectangles
m %>% addRectangles(
  rand_lng(), rand_lat(), rand_lng(), rand_lat(),
  color = 'red', fill = FALSE, dashArray = '5,5', weight = 3
)

# polylines
m %>% addPolylines(rand_lng(50), rand_lat(50), fill = FALSE)

# polygons
m %>% addPolygons(
  c(rand_lng(3), NA, rand_lng(4), NA, rand_lng(5)),
  c(rand_lat(3), NA, rand_lat(4), NA, rand_lat(5)),
  color = c('red', 'green', 'blue')
)

# 6 Other Layers
# ########GeoJSON 格式
# var MPoint = {
#   "type": "MultiPoint",
#   "coordinates": [ [100.0, 0.0], [101.0, 1.0] ]
# };
# ########在R中用list表示
# MPoint = list(
#   type = 'MultiPoint',
#   coordinates = rbind(c(100.0, 0.0), c(101.0, 1.0))
# )

m = leaflet() %>% addCircles(lat = 1:26, lng = 1:26, popup = LETTERS)
shapes = list(
  list(
    type = 'Feature',
    properties = list(
      popup = 'Here are some markers!'
    ),
    geometry = list(
      type = 'MultiPoint',
      coordinates = cbind(10:1, 1:10)
    )
  ),
  list(
    type = 'Feature',
    properties = list(
      style = list(color = 'red', fillColor = 'yellow'),
      popup = 'Here is a polygon, or perhaps a flower...'
    ),
    geometry = list(
      type = 'Polygon',
      coordinates = list(26 + 10 * t(sapply(seq(0, 2 * pi, length = 10), function(x) {
        c(cos(x), sin(x))
      })))
    )
  )
)
m %>% addGeoJSON(shapes)



















