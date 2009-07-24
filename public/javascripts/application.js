var map;
var startZoom = 9;

var centerLatitude = 37.818361;
var centerLongitude = -122;


//Create new icon for cluster of airports
var iconCluster = new GIcon();
iconCluster.image = "/images/cluster.png";
iconCluster.shadow = "/images/cluster_shadow.png";
iconCluster.iconSize = new GSize(26, 25);
iconCluster.shadowSize = new GSize(22, 20);
iconCluster.iconAnchor = new GPoint(13, 25);
iconCluster.infoWindowAnchor = new GPoint(13, 1);
iconCluster.infoShadowAnchor = new GPoint(26, 13);


//Create new icon for single airport
var iconSingle = new GIcon();
iconSingle.image = "/images/single.png";
iconSingle.shadow = "/images/single_shadow.png";
iconSingle.iconSize = new GSize(26, 25);
iconSingle.shadowSize = new GSize(22, 20);
iconSingle.iconAnchor = new GPoint(13, 25);
iconSingle.infoWindowAnchor = new GPoint(13, 1);
iconSingle.infoShadowAnchor = new GPoint(26, 13);


function addMarker(latitude, longitude, description) {
    var marker = new GMarker(new GLatLng(latitude, longitude));

    GEvent.addListener(marker, 'click',
        function() {
           marker.openInfoWindowHtml(description);
        }
    );

    map.addOverlay(marker);
}

function old_init() {
    if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"));
        map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(centerLatitude, centerLongitude), startZoom);

        for(id in markers) {
           var airport_info = markers[id].airport_id;
           airport_info += ", " + markers[id].airport_name;
           airport_info += ", " + markers[id].city;
           airport_info += ", " + markers[id].state;
           addMarker(markers[id].latitude, markers[id].longitude, airport_info);
        }
    }
}

function init() {
    if (GBrowserIsCompatible()) {
        map = new GMap2(document.getElementById("map"));
        map.addControl(new GSmallMapControl());
        map.addControl(new GMapTypeControl());
        map.setCenter(new GLatLng(centerLatitude, centerLongitude), startZoom);

        updateMarkers();
        
        GEvent.addListener(map, 'zoomend', function() {
        	updateMarkers();
        });
        
        GEvent.addListener(map, 'moveend', function() {
	        	updateMarkers();
        });
    }
    
 //Function to create clustered airport markers
 function updateMarkers() {
 	map.clearOverlays();
 	var bounds = map.getBounds();
 	var southWest = bounds.getSouthWest();
 	var northEast = bounds.getNorthEast();
 	var url= '/viewallairports/clustered_airports?ne=' + northEast.toUrlValue() + '&sw= ' + southWest.toUrlValue();
 	
 	//log for debugging
 	GLog.writeUrl(url);
 	
 	//AJAX to retrieve airports dynamically
 	var request = GXmlHttp.create();
 	request.open('GET', url, true);
 	request.onreadystatechange = function() {
 		if (request.readyState == 4){
 			var data = request.responseText;
 			var points = eval('('+data+')');
 			
 			//create each point from list
 			for (var i=0; i < points.length; i++){
 				//var point = new GLatLng(points[i].latitude, points[i].longitude);
 				var marker = createMarker(points[i]);
 				map.addOverlay(marker);
 			}
 		}
 	}
 	request.send(null);
 }
 
 function createMarker(point, type) {
	 var markerPoint = new GLatLng(point.latitude, point.longitude);
	 if(point.type == 'c'){
 		var marker = new GMarker(markerPoint, iconCluster, true);
 	} else {
 		var marker = new GMarker(markerPoint);
 	}
 	
 	var airport_info = "Airport Id = " + point.airport_id + "<br>";
    airport_info += "Airport Name = " + point.airport_name + "<br>";
    airport_info += "Location = " + point.city;
    airport_info += ", " + point.state;
    
    var infoTabs = [
      new GInfoWindowTab("Info", airport_info),
      new GInfoWindowTab("Reviews", "Pilot Reviews go here")]
      
 	GEvent.addListener(marker, 'click',
 	        function() {
 	           marker.openInfoWindowTabsHtml(infoTabs);
 	        }
 	    );
 	return marker;
 }

}


window.onload = init;
window.onunload = GUnload;

