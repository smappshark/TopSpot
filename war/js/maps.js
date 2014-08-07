
var map = new GMap2(document.getElementById("map_canvas"));
map.setCenter(new GLatLng(25.178485, 55.266275), 15);
map.setUIToDefault();

function initialize() {
var building = new Building();
var latitude =building.latitude;
var longitude = building.longitude;

 var map = new GMap2(document.getElementById("map_canvas")); 
map.setCenter(new GLatLng(25.178485, 55.266275), 15); 
 var map = new GMap2(document.getElementById("map_canvas"));  
 map.setMapType(G_SATELLITE_MAP);

var map = new GMap2(document.getElementById("map_canvas"));
map.setCenter(new GLatLng(25.178485, 55.266275), 15);
var _text = document.createTextNode('Dubai,Executive Bay' + '\n' + 'DAMAC STAR PROPERTIES (L L C)'+ '\n'+ 'ENGINEERING CONSORTI' +'\n'+ 'floors: 19,Height :84'+'\n'+'...');

var _pre = document.createElement("pre");
_pre.appendChild(_text); 
map.openInfoWindow(map.getCenter(),_pre);
}