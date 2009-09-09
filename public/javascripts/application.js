var map;
var startZoom = 10;

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
        map.getInfoWindow().show();

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
 	//GLog.writeUrl(url);
 	
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
 
 // Create a table for the reviews section
 // Return the Body dom element
 //
 function createReviewsTable() {
         // get the reference for the body
        // var body = document.getElementsByTagName("body")[0];
 	 var body = document.createElement("body");
         // creates a <table> element and a <tbody> element
         var tbl     = document.createElement("table");
         var tblBody = document.createElement("tbody");
         
         //Header Row
         var row1 = document.createElement("tr");
         var hCell1 = document.createElement("td");
         var hCell1Text = document.createTextNode("User");
         hCell1.appendChild(hCell1Text);
         row1.appendChild(hCell1);
         var hCell2 = document.createElement("td");
	 var hCell2Text = document.createTextNode("Review");
	 hCell2.appendChild(hCell2Text);
         row1.appendChild(hCell2);
         
         tblBody.appendChild(row1);
         
         //Data Row
	  var row2 = document.createElement("tr");
	  var hCell21 = document.createElement("td");
	  var hCell21Text = document.createTextNode("praveen");
	  hCell21.appendChild(hCell21Text);
	  row2.appendChild(hCell21);
	  var hCell22 = document.createElement("td");
	 var hCell22Text = document.createTextNode("Good Coffee, Long runway, Easy landing");
	 hCell22.appendChild(hCell22Text);
         row2.appendChild(hCell22);
         
         tblBody.appendChild(row2);
 
 
         // put the <tbody> in the <table>
         tbl.appendChild(tblBody);
         // appends <table> into <body>
         body.appendChild(tbl);
         // sets the border attribute of tbl to 2;
         tbl.setAttribute("border", "2");
         
         return body;
     }

 
 
 function createMarker(point, type) {
	 var markerPoint = new GLatLng(point.latitude, point.longitude);
	 if(point.type == 'c'){
 		var marker = new GMarker(markerPoint, iconCluster, true);
 	} else {
 		var marker = new GMarker(markerPoint);
 	}
 	
 	      
      GEvent.addListener(marker, 'click',
 	        function() {
 	        	var airport_info = "Airport Id = " + point.airport_id + "<br>";
		    	airport_info += "Airport Name = " + point.airport_name + "<br>";
		   	airport_info += "Location = " + point.city;
		    	airport_info += ", " + point.state;
		    
		   	// var airport_reviews = "Pilot reviews here";
		    
		    	var airport_reviews = createReviewsTable();
		   
		    	var tab1 = new GInfoWindowTab("Minimap", '<div id="detailmap"></div>');
		    	var tab2 = new GInfoWindowTab("Info", airport_info);
		    	var tab3 = new GInfoWindowTab("Reviews", airport_reviews);
		    	
		    	var infoTabs = [tab1, tab2, tab3];
		    	marker.openInfoWindowTabsHtml(infoTabs);
		      
		      	var dMapDiv = document.getElementById("detailmap");
		      	var detailMap = new GMap2(dMapDiv);
		      	detailMap.setMapType(G_SATELLITE_MAP);
		      	detailMap.setCenter(markerPoint, 14);
		      	detailMap.addControl(new GSmallMapControl());
		      	GEvent.addListener(detailMap, "zoomend", miniMapZoomEnd);
      			GEvent.addListener(detailMap, "moveend", miniMapMoveEnd);
 	           
 	        }
 	    );
 	  
 	    
 	  // GEvent.addListener(marker, 'click', marker.showMapBlowup());
	     	      
 	    
 	    
 	return marker;
 }

}


window.onload = init;
window.onunload = GUnload;

