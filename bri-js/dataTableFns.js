/* global dataT, dlist, checkies, showdown, motive */
let colly;
function getTableData(callback1, callback2) {
  console.log("GET TABLE DATA");
  dataT.length = 0;
  dlist.features.forEach(ele => dataT.push(ele.properties));
  console.log(dlist);
  console.log(dataT);// creates dataT
  if (checkies[0].checked) {
    colly = "2010 PM 2.5 Score";
  }
  if (checkies[1].checked) {
    colly = "2011 PM 2.5 Score";
  }
  if (checkies[2].checked) {
    colly = "2012 PM 2.5 Score";
  }
  if (checkies[3].checked) {
    colly = "2013 PM 2.5 Score";
  }
  if (checkies[4].checked) {
    colly = "2014 PM 2.5 Score";
  }
  if (checkies[5].checked) {
    colly = "2015 PM 2.5 Score";
  }
  if (checkies[6].checked) {
    colly = "2016 PM 2.5 Score";
  }
  if (checkies[7].checked) {
    colly = "2017 PM 2.5 Score";
  }
  if (checkies[8].checked) {
    colly = "2018 PM 2.5 Score";
  }
  if (checkies[9].checked) {
    colly = "2019 PM 2.5 Score";
  }
  if (callback1) {
    callback1();
  }
  if (callback2) {
    callback2(colly);
  }
}


function intialTableData(callback1, callback2) {
  dlist.features.forEach(ele => dataT.push(ele.properties)); // creates dataT, MAYBE ADD YEAR TO BEGINNING OF COLLY
  colly = "2010 PM 2.5 Score";
  if (callback1) {
    callback1();
  }
  if (callback2) {
    callback2(colly);
  }
}

/*= === Initial Data Table Content Function === */
function initializeDataTable() {
  console.log("INITIALIZE DATA TABLE");
  const converter = new showdown.Converter({ smartIndentationFix: true });
  let motiveFill = document.querySelector("#table");
  let accordionheading = document.querySelector(".accordion-trigger");
  accordionheading.innerHTML = motive.title;
  motiveFill.innerHTML = converter.makeHtml(motive.content);
  console.log("END INITIALIZE");
}


/*= === Search for census tract to filter histogram by === */

let h = [];
let ishere;
let trace = {};

function showmeHistogram(column, stateID) {
  // document.querySelector("#histHere").innerHTML = ""
  console.log("BEGIN SHOW HISTOGRAM");
  let x = [];
  console.log(column);
  // Plotly.purge('histHere');
  console.log("i might delete plot");
  /* if (Object.keys(trace).length > 0){
    Plotly.deleteTraces('histHere', 0);
    console.log("deleted plot")
  } */
  // get the data of what is currently clicked on
  dataT.forEach(f => { x.push(f[column]); });
  let layout;
  trace = {
    x,
    type: 'histogram',
    marker: { color: '#08415C' },
  };
  console.log(x);
/// y1 was 145
  if (stateID) {
    let datahist = [trace];
    layout = {
      title: `Distribution of ${column}`,
      shapes: [    // line vertical
        {
          type: 'line',
          x0: h[0],
          y0: 0,
          x1: h[0],
          y1: 25,
          line: {
            color: 'rgb(255, 231, 76)',
            width: 3
          }
        },
      ]
    };
    Plotly.newPlot('histHere', datahist, layout, { responsive: true });
  } else {
    let datahist = [trace];
    layout = {
      title: `Distribution of ${column}`,
    };
    Plotly.newPlot('histHere', datahist, layout, { responsive: true });
  }
  ishere = document.querySelector(".plot-container");
  console.log(`is here here, now? ${ishere}`);
}


function getStateID() {
  h.length = 0;
  console.log("IN GET");
  const statenum = document.getElementById("stateenter").value;
  let col = colly;
  let stateID;
  stateID = statenum;
  dataT.forEach(d => { if (d.Name === String(stateID)) { h.push(d[col]); } });
  showmeHistogram(col, stateID);
}
function addHistInput() {
  // create input box and histogram place
  const input = document.createElement("input");
  const hist = document.createElement("div");
  const inputEnterButton = document.createElement("button");
  const inputcontainer = document.createElement("div");
  input.setAttribute("type", "text");
  input.setAttribute("placeholder", "Search For a State");
  input.setAttribute("id", "stateenter");
  inputEnterButton.setAttribute("id", "stateButton");
  inputEnterButton.innerHTML = "Search State";
  console.log("BEFORE GET");
  inputEnterButton.addEventListener("click", getStateID);
  console.log("AFTER GET");
  hist.setAttribute('id', 'histHere');
  // locate elements
  let motiveFill = document.querySelector("#table");
  let accordionheading = document.querySelector(".accordion-trigger");

  // fill elements
  accordionheading.innerHTML = `Distribution of ${colly}`;
  motiveFill.innerHTML = "";
  motiveFill.appendChild(inputcontainer);
  inputcontainer.appendChild(input);
  inputcontainer.appendChild(inputEnterButton);
  motiveFill.appendChild(hist);
  console.log("END ADD INPUT HIST");
}









/*
var myTable = document.querySelector('#table').bootstrapTable({
  url: '../../data/DataForMap/newData/newoverallvulnerability.geojson',
  columns: [{
    field: 'SocVulScore',
    title: 'Item ID'
  }, {
    field: 'PhysVulScore',
    title: 'Item Name'
  }, {
    field: 'PhysVulScoreQuantile',
    title: 'Item Price'
  }, {
    field: 'SocVulScore',
    title: 'Item Price'
  }, {
    field: 'SocVulScoreQuantile',
    title: 'Item Price'
  }, {
    field: 'TotalVulScore',
    title: 'Item Price'
  }, {
    field: 'TotalVulScoreQuantile',
    title: 'Item Price'
  }, {
    field: 'Tract',
    title: 'Item Price'
  }, {
    field: 'Tract_N',
    title: 'Item Price'
  }]
}) */
