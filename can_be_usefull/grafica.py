#Es de Nestor!

import numpy as np 
import matplotlib.pyplot as plt

def cargaCiudades(archivo):
	fcd = open(archivo,"r")
	lineas = fcd.readlines()
	fcd.close()
	posicionesx = []
	posicionesy = []

	for i, linea in enumerate(lineas):
		nums = linea.split(" ")
		posicionesx.append(float(nums[0]))
		posicionesy.append(float(nums[1]))
	posicionesx.append(posicionesx[0])
	posicionesy.append(posicionesy[0])
	return posicionesx,posicionesy

"""
def generaMapa( posicionesx,posicionesy, rutaArchivo ):
	archivo   = open( rutaArchivo, "w" )
	contenido = ""
	
	
	contenido += "<html><body>\n"
	contenido += "<div id='mapdiv'></div>\n"
   	contenido += "\t<script src='http://www.openlayers.org/api/OpenLayers.js'></script>\n"
	contenido += "\t<script>\n"
	contenido += "\t\tmap = new OpenLayers.Map('mapdiv');\n"
	contenido += "\t\tmap.addLayer(new OpenLayers.Layer.OSM());\n"

	
	contenido += "\t\tvar zoom = 5;\n"
	contenido += "\t\tvar markers = new OpenLayers.Layer.Markers( 'Markers' );\n"
	contenido += "\t\tmap.addLayer(markers);\n"

	contador = 0
	for posx,posy in zip(posicionesx,posicionesy):
		contenido += "\t\tvar lonLat%d = new OpenLayers.LonLat( %f ,%f )\n" % (contador,posx, posy)
		contenido += "\t\t\t.transform(\n"
		contenido += "\t\t\tnew OpenLayers.Projection('EPSG:4326'), // transform from WGS 1984\n"
		contenido += "\t\t\tmap.getProjectionObject() // to Spherical Mercator Projection\n"
		contenido += "\t\t\t);\n"
		contador+= 1	

		

	contador = len(posicionesx) 
	for i in range(contador):
		contenido += "\t\tmarkers.addMarker(new OpenLayers.Marker(lonLat%d));\n" % i

	var lineLayer = new OpenLayers.Layer.Vector("Line Layer");
		map.addLayer(lineLayer);                    
		map.addControl(new OpenLayers.Control.DrawFeature(lineLayer, OpenLayers.Handler.Path));                                     
		var points = new Array(
		   new OpenLayers.Geometry.Point(lonLat1.lon ,lonLat1.lat).transform(
		   	new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject()),
		   new OpenLayers.Geometry.Point(lonLat2.lon ,lonLat2.lat).transform(
		   	new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject())
		   );

		var line = new OpenLayers.Geometry.LineString(points);

		var style = { 
		  strokeColor: '#0000ff', 
		  strokeOpacity: 0.8,
		  strokeWidth: 10
		};

		var lineFeature = new OpenLayers.Feature.Vector(line, null, style);
		lineLayer.addFeatures([lineFeature]);

	contenido += "\t\tmap.setCenter (lonLat0, zoom);\n"
	contenido += "\t</script>\n"
	contenido += "</body></html>\n"

	archivo.write(contenido)
		
	archivo.close()
"""

def main():
	posicionesx,posicionesy = cargaCiudades("recorrido-optimo.data")	
	#generaMapa(posicionesx,posicionesy,"map.html")
	plt.plot(posicionesx,posicionesy)
	plt.show()
	

if __name__ == "__main__":
	main()