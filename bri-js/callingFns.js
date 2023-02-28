/* global initializeMap, initializeDataTable */
/* 1. === Setting up Map === */
/* set up with zoom 5, may change, changed lat
and long from 34,0836417742618, -118.5298649280784 */
let map = L.map('map', { zoomControl: false }).setView([21.196640407274728, 72.40726019546284], 5);

const basemap = 'http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png';
const attribution = 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, under <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a>. Data by <a href="http://openstreetmap.org">OpenStreetMap</a>, under <a href="http://creativecommons.org/licenses/by-sa/3.0">CC BY SA</a>.';

L.tileLayer(basemap, {
  attribution,
}).addTo(map);

let layerGroup = L.layerGroup().addTo(map);

L.Control.geocoder().addTo(map);

L.control.zoom({
  position: 'topright'
}).addTo(map);


/* === initial Filling in Map with our motiviation statement in our data table info == */
// might also want to change the name from data table to smething else during this intial step

initializeMap(initializeDataTable);
// initializeDataTable(); //<-- this will also be called when zoom level is 9
console.log("MAP INITIALIZED CALLING FNS");

/* === Fillling Map and Data Table === */
// clear map
// take list of filters checked ON and fill map with them
// depending on list of filter, fill the table with relevant info


let dataT = [];


//updateMap(TWTEN,styleTWTEN,onEachFeatureTWTEN,getTableData);
