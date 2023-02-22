/* global layerGroup, map, TWTENlegend, TWELElegend, TWTWElegend, TWTHIlegend,
TWFOUlegend, TWFIFlegend, TWSIXlegend, TWSEVlegend, TWEIGlegend, TWNINlegend,
getTableData, getLegend, sidebarContentController, intialTableData,
dataT, showmeHistogram, addHistInput, checkies, showdown */
let dlist;
/* === MY DATA ON GITHUB === */
const mapvars = {
  TWTEN: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2010pm25.geojson",
  TWELE: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2011pm25.geojson",
  TWTWE: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2012pm25.geojson",
  TWTHI: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2013pm25.geojson",
  TWFOU: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2014pm25.geojson",
  TWFIF: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2015pm25.geojson",
  TWSIX: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2016pm25.geojson",
  TWSEV: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2017pm25.geojson",
  TWEIG: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2018pm25.geojson",
  TWNIN: "https://raw.githubusercontent.com/aidanpcole/India-PM-2.5-Pollution-Project/main/data/DataForMap/states2019pm25.geojson"
};

//const pointLayers = ["coolingCenters", "emergencyP", "pools", "parks", "hosp"]; // i think this needs to be a dictionary
const polygonLayers = ["TWTEN", "TWELE", "TWTWE", "TWTHI", "TWFOU", "TWFIF", "TWSIX", "TWSEV", "TWEIG", "TWNIN"]; // with string name and var



let tableData;

// =================== Functions ==========///

// === onEachFeature: Bindings === //



/* function onEachFeatureName(feature, layer){
  //use feature.properties to construct popup html
  var resourceName = `<h2> Resource: ${feature.properties.Name} </h2>`;
  layer.bindPopup(resourceName);
  }; */

function onEachFeatureTWTEN(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWELE(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWTWE(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWTHI(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWFOU(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWFIF(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWSIX(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWSEV(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWEIG(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


function onEachFeatureTWNIN(feature, layer) {
// use feature.properties to construct popup html
  let popupContent = '<table class="popupTable"><th><h3>State Stats</h3></th>';
  for (let p of Object.keys(feature.properties)) {
    popupContent += `<tr><td>${p}</td><td>${feature.properties[p]}</td></tr>`;
  }
  popupContent += '</table>';
  layer.bindPopup(popupContent);
  // var HVIScore = `<h2> Heat Vulnerability Score: ${feature.properties.rTotalVulScore} </h2>`;
  // layer.bindPopup(HVIScore);
}


// === Map color Function === //
function getColorTWTEN(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWELE(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWTWE(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWTHI(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWFOU(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWFIF(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWSIX(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWSEV(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWEIG(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}

function getColorTWNIN(d) {
  return d > 4 ? '#b30000'
    : d > 3  ? '#e34a33'
      : d > 2   ? '#fc8d59'
        : d > 1   ? '#fdcc8a'
          : d > 0   ? '#fef0d9'
            : '#fff9db';
}


// === Style  === //
function styleTWTEN(feature) {
  return {
    fillColor: getColorTWTEN(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWELE(feature) {
  return {
    fillColor: getColorTWELE(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWTWE(feature) {
  return {
    fillColor: getColorTWTWE(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWTHI(feature) {
  return {
    fillColor: getColorTWTHI(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWFOU(feature) {
  return {
    fillColor: getColorTWFOU(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWFIF(feature) {
  return {
    fillColor: getColorTWFIF(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWSIX(feature) {
  return {
    fillColor: getColorTWSIX(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWSEV(feature) {
  return {
    fillColor: getColorTWSEV(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWEIG(feature) {
  return {
    fillColor: getColorTWEIG(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

function styleTWNIN(feature) {
  return {
    fillColor: getColorTWNIN(feature.properties["PM 2.5 Concentration Quantile"]),
    weight: 0.5,
    opacity: 0.7,
    color: "gray",
    fillOpacity: 0.5,
    colorOpacity: 0.1,
  };
}

// === realted styles for mapping ==//

const stylevars = {
  TWTEN: styleTWTEN,
  TWELE: styleTWELE,
  TWTWE: styleTWTWE,
  TWTHI: styleTWTHI,
  TWFOU: styleTWFOU,
  TWFIF: styleTWFIF,
  TWSIX: styleTWSIX,
  TWSEV: styleTWSEV,
  TWEIG: styleTWEIG,
  TWNIN: styleTWNIN
};

const bindingsvars = {
  TWTEN: onEachFeatureTWTEN,
  TWELE: onEachFeatureTWELE,
  TWTWE: onEachFeatureTWTWE,
  TWTHI: onEachFeatureTWTHI,
  TWFOU: onEachFeatureTWFOU,
  TWFIF: onEachFeatureTWFIF,
  TWSIX: onEachFeatureTWSIX,
  TWSEV: onEachFeatureTWSEV,
  TWEIG: onEachFeatureTWEIG,
  TWNIN: onEachFeatureTWNIN
};
// === Updating the Map === //

function updateMap(url, styleType, bindings, callback) {
  layerGroup.clearLayers();

  fetch(url)
    .then(resp => resp.json())
    .then(data => {
      dlist = data;
      L.geoJSON(data, {
        style: styleType,
        onEachFeature: bindings
      }).addTo(layerGroup);
      if (callback) {
        callback(addHistInput, showmeHistogram);
      }
      console.log(dataT);
    });
}

// === markers ===//
//const parksIcon = new L.Icon({
//  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-green.png',
//  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
//  iconSize: [25, 41],
//  iconAnchor: [12, 41],
//  popupAnchor: [1, -34],
//  shadowSize: [41, 41]
//});

//const poolsIcon = new L.Icon({
//  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-blue.png',
//  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
//  iconSize: [25, 41],
//  iconAnchor: [12, 41],
//  popupAnchor: [1, -34],
//  shadowSize: [41, 41]
//});

//const emergencyPIcon = new L.Icon({
//  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-gold.png',
//  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
//  iconSize: [25, 41],
//  iconAnchor: [12, 41],
//  popupAnchor: [1, -34],
//  shadowSize: [41, 41]
//});

//const coolingCentersIcon = new L.Icon({
//  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-violet.png',
//  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
//  iconSize: [25, 41],
//  iconAnchor: [12, 41],
//  popupAnchor: [1, -34],
//  shadowSize: [41, 41]
//});


//const hospIcon = new L.Icon({
//  iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-grey.png',
//  shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
//  iconSize: [25, 41],
//  iconAnchor: [12, 41],
//  popupAnchor: [1, -34],
//  shadowSize: [41, 41]
//});


//function getMarker(pointName) {
//  let icon2use;
//  if (pointName === "coolingCenters") {
//    icon2use = coolingCentersIcon;
//  }
//  if (pointName === "emergencyP") {
//    icon2use = emergencyPIcon;
//  }
//  if (pointName === "pools") {
//    icon2use = poolsIcon;
//  }
//  if (pointName === "parks") {
//    icon2use = parksIcon;
//  }
//  if (pointName === "hosp") {
//    icon2use = hospIcon;
//  }
//  return icon2use;
//}
//= ========== point data bindings =============//



//function updateMappointPCH(url, name, callback) { // THIS IS for pools, cooling centers and hosp
//  layerGroup.clearLayers();
//  let iconuse;
//  let markersClust = new L.MarkerClusterGroup();
//  iconuse = getMarker(name);
//  fetch(url)
//    .then(resp => resp.json())
//    .then(data => {
//      L.geoJSON(data, {
//        onEachFeature(feature) {
//          let popupContent = `<h4> ${feature.properties.Name} </h4>
//        <p>Address: ${feature.properties.addrln1}  &nbsp ${feature.properties.zip} <br>
//        Hours: ${feature.properties.hours} <br>
//        Phone Number: ${feature.properties.phones} <br>
//        Website: <a href="${feature.properties.url}">${feature.properties.url} </a> </p>`;
//          let marker = L.marker(
//            [feature.geometry.coordinates[1], feature.geometry.coordinates[0]],
//            { icon: iconuse }
//          ).bindPopup(popupContent);
//          markersClust.addLayer(marker);
//        }
//      });
//      markersClust.addTo(layerGroup);
//    });
//  if (callback) {
//    callback();
//  }
//}

//function updateMappointEmergency(url, name, callback) {
  // THIS IS for pools, cooling centers and hosp
//  layerGroup.clearLayers();
//  let iconuse;
//  let markersClust = new L.MarkerClusterGroup();
//  iconuse = getMarker(name);
//  fetch(url)
//    .then(resp => resp.json())
//    .then(data => {
//      L.geoJSON(data, {
//        onEachFeature(feature) { // THIS IS only for emergencyP
//          let popupContent = `<h4>${feature.properties.Name} </h4>
//        <p>Address: ${feature.properties.addrln1}  &nbsp ${feature.properties.zip} <br>
//        Phone Number: ${feature.properties.phones} <br>
//        Website: <a href="${feature.properties.url}">${feature.properties.url} </a></p>`;
//          let marker = L.marker(
//            [feature.geometry.coordinates[1], feature.geometry.coordinates[0]],
//            { icon: iconuse }
//          ).bindPopup(popupContent);
//          markersClust.addLayer(marker);
//        }
//      });
//      markersClust.addTo(layerGroup);
//    });
//  if (callback) {
//    callback();
//  }
//}



//function updateMappointParks(url, name, callback) { // THIS IS only for parks
//  layerGroup.clearLayers();
//  let iconuse;
//  let markersClust = new L.MarkerClusterGroup();
//  iconuse = getMarker(name);
//  fetch(url)
//    .then(resp => resp.json())
//    .then(data => {
//      L.geoJSON(data, {
//        onEachFeature(feature) {    // THIS IS only for emergencyP
//          let popupContent = `<h4> ${feature.properties.Name} </h4>
//        <p>Address: ${feature.properties.ADDRESS} &nbsp ${feature.properties.CITY} &nbsp ${feature.properties.ZIP} <br>
//        Phone Number: ${feature.properties.PHONES} <br>
//        Website: <a href="${feature.properties.AGNCY_WEB}">${feature.properties.AGNCY_WEB} </a></p>`;
//          let marker = L.marker(
//            [feature.geometry.coordinates[1], feature.geometry.coordinates[0]],
//            { icon: iconuse }
//          ).bindPopup(popupContent);
//          markersClust.addLayer(marker);
//        }
//      });
//      markersClust.addTo(layerGroup);
//    });
//  if (callback) {
//    callback();
//  }
//}


// getridof fn below
/*
function updateMappoint(url, name) {
  layerGroup.clearLayers();
  let iconuse
  var markersClust = new L.MarkerClusterGroup();
  iconuse = getMarker(name);
  fetch(url)
  .then(resp => resp.json())
  .then(data => {
    L.geoJSON(data, {
      onEachFeature: function(feature) {
      var marker = L.marker([feature.geometry.coordinates[1], feature.geometry.coordinates[0]],
        {icon: iconuse}).bindPopup(`<h2> Resource: ${feature.properties.Name} </h2>`);
      markersClust.addLayer(marker);}
    });
    markersClust.addTo(layerGroup);

    });
}; */

function emptyCallback() {
  console.log("this is a callback");
}



function initializeMap(callback) {
  updateMap(mapvars.TWTEN, styleTWTEN, onEachFeatureTWTEN, intialTableData);
  getLegend("TWTEN");
  sidebarContentController("story-slide");
  if (callback) {
    callback();
  }
}
// === intialize map === //
/*
function initializeMap(callback) {
  fetch(mapvars.HVI)
  .then(resp => resp.json())
  .then(data => {
    L.geoJSON(data, {style: styleHVI,
      onEachFeature: onEachFeatureHVI
    }).addTo(layerGroup);
  if (callback){
    callback();
  };
});
getLegend("HVI");
sidebarContentController("story-slide");
}; */

// these might be useful IDK

function check(box) {
  let b = box;
  b.checked = true;
}

function uncheck(box) {
  let b = box;
  b.checked = false;
}

function disable(box) {
  let b = box;
  b.enabled = false;
}
// === Determine & Update Map From Check boxes == //
function determineMap() {
  layerGroup.clearLayers();
  let names = [];
  checkies.forEach(c => {
    if (c.checked === true) {
      let n = c.id;
      names.push(n);
    }
  });
  console.log(names);
  names.forEach(name => {
//    if (pointLayers.includes(name)) {
//      if (name === "parks") {
//        updateMappointParks(mapvars[name], name, emptyCallback);
//      }
//      if (name === "emergencyP") {
//        updateMappointEmergency(mapvars[name], name, emptyCallback);
//      }
//      updateMappointPCH(mapvars[name], name, emptyCallback);
//    }
    if (polygonLayers.includes(name)) {
      updateMap(mapvars[name], stylevars[name], bindingsvars[name], getTableData);
      getLegend(name);
    }
  });
}

//checkies 3 and onward not incorporated in original
function anyChecked() {
  if (!checkies[0].checked) {
    map.removeControl(TWTENlegend);
  }
  if (!checkies[1].checked) {
    map.removeControl(TWELElegend);
  }
  if (!checkies[2].checked) {
    map.removeControl(TWTWElegend);
  }
  if (!checkies[3].checked) {
    map.removeControl(TWTHIlegend);
  }
  if (!checkies[4].checked) {
    map.removeControl(TWFOUlegend);
  }
  if (!checkies[5].checked) {
    map.removeControl(TWFIFlegend);
  }
  if (!checkies[6].checked) {
    map.removeControl(TWSIXlegend);
  }
  if (!checkies[7].checked) {
    map.removeControl(TWSEVlegend);
  }
  if (!checkies[8].checked) {
    map.removeControl(TWEIGlegend);
  }
  if (!checkies[9].checked) {
    map.removeControl(TWNINlegend)
  }

  let trues = [];

  let l1 = checkies[0];
  let l2 = checkies[1];
  let l3 = checkies[2];
  let l4 = checkies[3];
  let l5 = checkies[4];
  let l6 = checkies[5];
  let l7 = checkies[6];
  let l8 = checkies[7];
  let l9 = checkies[8];
  let l10 = checkies[9];

  let cs = [l1, l2, l3, l4, l5, l6, l7, l8, l9, l10];
//  if (cs[3].checked) {
//    console.log("includes resources");
//    check(l5);
//    check(l6);
//    check(l7);
//    check(l8);
//    check(l9);
//  }

  cs.forEach(c => {
    if (c.checked === true) {
      trues.push("y");
    }
  });
  return trues;
}

//function onCheck() {
//  console.log("checkbox checked!");
//  let trues = anyChecked();
//  console.log(trues);
//  if (trues.length > 0) {
//    determineMap();
//  } else {
//    layerGroup.clearLayers();
//  }
//}

//function resourceCheck() {
//  if (!checkies[3].checked) {
//    console.log("resources unchecked");
//    uncheck(checkies[4]);
//    uncheck(checkies[5]);
//    uncheck(checkies[6]);
//    uncheck(checkies[7]);
//    uncheck(checkies[8]);
//    layerGroup.clearLayers();
//  }
//  onCheck();
//}


function TWTENCheck() {
  if (checkies[0].checked) {
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWELECheck() {
  if (checkies[1].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWTWECheck() {
  if (checkies[2].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWTHICheck() {
  if (checkies[3].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWFOUCheck() {
  if (checkies[4].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWFIFCheck() {
  if (checkies[5].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWSIXCheck() {
  if (checkies[6].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[7]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWSEVCheck() {
  if (checkies[7].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[8]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[8]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWEIGCheck() {
  if (checkies[8].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[9]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[9]);
    layerGroup.clearLayers();
  }
  // onCheck();
}

function TWNINCheck() {
  if (checkies[9].checked) {
    uncheck(checkies[0]);
    uncheck(checkies[1]);
    uncheck(checkies[2]);
    uncheck(checkies[3]);
    uncheck(checkies[4]);
    uncheck(checkies[5]);
    uncheck(checkies[6]);
    uncheck(checkies[7]);
    uncheck(checkies[8]);
    disable(checkies[0]);
    disable(checkies[1]);
    disable(checkies[2]);
    disable(checkies[3]);
    disable(checkies[4]);
    disable(checkies[5]);
    disable(checkies[6]);
    disable(checkies[7]);
    disable(checkies[8]);
    layerGroup.clearLayers();
  }
  // onCheck();
}






// const pointLayers = [coolingCenters, emergencyP, pools, parks]
// const polygonLayers = [HVI, PVI, SVI]



// tableData.features.forEach(ele => dataT.push(ele.properties))




// const urlList = [coolingCenters, emergencyP, pools]

// urlList.forEach(element => updateMap(element))
