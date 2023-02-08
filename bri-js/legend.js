/* global map, getColorTWTEN, getColorTWELE, getColorTWTWE, getColorTWTHI,
getColorTWFOU, getColorTWFIF, getColorTWSIX, getColorTWSEV, getColorTWEIG,
getColorTWNIN */
// === Legend code ===//
/* Legend Function */
let LegendTitle;

// 2010 LEGEND ///
var TWTENlegend = L.control({ position: 'bottomright' });
TWTENlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWTEN(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2011 LEGEND ///
var TWELElegend = L.control({ position: 'bottomright' });
TWELElegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWELE(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2012 LEGEND ///
var TWTWElegend = L.control({ position: 'bottomright' });
TWTWElegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWTWE(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2013 LEGEND ///
var TWTHIlegend = L.control({ position: 'bottomright' });
TWTHIlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWTHI(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2014 LEGEND ///
var TWFOUlegend = L.control({ position: 'bottomright' });
TWFOUlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWFOU(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2015 LEGEND ///
var TWFIFlegend = L.control({ position: 'bottomright' });
TWFIFlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWFIF(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2016 LEGEND ///
var TWSIXlegend = L.control({ position: 'bottomright' });
TWSIXlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWSIX(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2017 LEGEND ///
var TWSEVlegend = L.control({ position: 'bottomright' });
TWSEVlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWSEV(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2018 LEGEND ///
var TWEIGlegend = L.control({ position: 'bottomright' });
TWEIGlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWEIG(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

// 2019 LEGEND ///
var TWNINlegend = L.control({ position: 'bottomright' });
TWNINlegend.onAdd = function (map) {
  let div = L.DomUtil.create('div', 'info-legend');
  let labels = [`<div class="legendTitle">${LegendTitle}</div><div class="legendBody">`];
  let catlables = ['Most PM 2.5', 'Above-Average PM 2.5', 'Country Average PM 2.5', 'Some PM 2.5', 'Low PM 2.5'];
  let categories = [5, 4, 3, 2, 1];
  for (let i = 0; i < categories.length; i++) {
    div.innerHTML
            += labels.push(
        `<div>`
              + `<i class="circle" style=" color: white;background-color:${
                getColorTWNIN(categories[i])}"></i> `
              + `<i class="legendtext">${catlables[i] ? catlables[i] : ''}</i>`
            + `</div>`
      );
  }
  labels.push('</div>');
  div.innerHTML = labels.join("");
  return div;
};

function getLegend(name) {
  if (name === "TWTEN") {
    LegendTitle = "2010 PM 2.5 Concentration";
    TWTENlegend.addTo(map);
  }
  if (name === "TWELE") {
    LegendTitle = "2011 PM 2.5 Concentration";
    TWELElegend.addTo(map);
  }
  if (name === "TWTWE") {
    LegendTitle = "2012 PM 2.5 Concentration";
    TWTWElegend.addTo(map);
  }
  if (name === "TWTHI") {
    LegendTitle = "2013 PM 2.5 Concentration";
    TWTHIlegend.addTo(map);
  }
  if (name === "TWFOU") {
    LegendTitle = "2014 PM 2.5 Concentration";
    TWFOUlegend.addTo(map);
  }
  if (name === "TWFIF") {
    LegendTitle = "2015 PM 2.5 Concentration";
    TWFIFlegend.addTo(map);
  }
  if (name === "TWSIX") {
    LegendTitle = "2016 PM 2.5 Concentration";
    TWSIXlegend.addTo(map);
  }
  if (name === "TWSEV") {
    LegendTitle = "2017 PM 2.5 Concentration";
    TWSEVlegend.addTo(map);
  }
  if (name === "TWEIG") {
    LegendTitle = "2018 PM 2.5 Concentration";
    TWEIGlegend.addTo(map);
  }
  if (name === "TWNIN") {
    LegendTitle = "2019 PM 2.5 Concentration";
    TWNINlegend.addTo(map);
  }
}
