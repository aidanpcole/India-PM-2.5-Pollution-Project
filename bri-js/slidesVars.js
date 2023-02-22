




//= === Function_outlines Vars ===//

const sidebar = document.querySelector(".side-bar");
const slideTitleDiv = document.querySelector('.slide-title');
const slideContentDiv = document.querySelector('.slide-content');

// for map change and data table change
let checkboxContainer;

let allButResources;
/*= == Slides === */
const storySlide = {
  title: '<h1> Abstract </h1>',
  slide: 'storySlide',
  content: '<p><b>Motivations and Acknowledgements:</b><p>Taking inspiration from the "Los Angeles Heat Vulnerability Index" story map, I hope to highlight the areas within India that are most vulnerable to PM 2.5 pollution. My general process:<ol><li>gathered organization satellite imagery and open source data relating to State boundaries and PM 2.5 concentration in India,</li><li>calculated and mapped the average PM 2.5 concentration for each State in the country</li></ol></p><p><b>Methods:</b><p>In order to calculate a State&apos;s average PM 2.5 concentration, I used granular PM 2.5 raster data provided by the University of Michigan. More specifically, I converted each pixel (1kmx1km) contained in the PM 2.5 raster file into a point. I then overlayed these points over a map of India&apos;s States, designated each point to a State, and averaged the PM 2.5 concentration value for all the points found in each State.</p><p><b>Conclusions and Usability:</b><p>With the average PM 2.5 concentrations that I calculated for each State in India, I produced this India PM 2.5 Pollution interactive map - illustrating the areas of the country that are most polluted with PM 2.5 to help people cope with and mitigate the effects of pollution. With this map, I hope to educate individuals within India about their relative vulnerability to pollution. Additionally, we encourage that the government of India use our map to inform residents of this issue and to aid in the allocation of pollution-mitigating resources and strategies.</p><p><em>This website was created by University of Pennsylvania MUSA (Master of Urban Spatial Analytics) student, Aidan Cole. Please contact aidancol@usc.edu for more information.</em></p></p>'
};

// <input type="checkbox" id="Resources"><h4>Resources</h4>
const filterslide = {
  title: '<h1> Map Layers </h1>',
  slide: 'filterSlide',
  content: `<div class="checkies">
  <h2><input type="checkbox" id="TWTEN" class="largerCheck"> &nbsp2010 PM 2.5</h2>
  <h2><input type="checkbox" id="TWELE" class="largerCheck"> &nbsp2011 PM 2.5</h2>
  <h2><input type="checkbox" id="TWTWE" class="largerCheck"> &nbsp2012 PM 2.5</h2>
  <h2><input type="checkbox" id="TWTHI" class="largerCheck"> &nbsp2013 PM 2.5</h2>
  <h2><input type="checkbox" id="TWFOU" class="largerCheck"> &nbsp2014 PM 2.5</h2>
  <h2><input type="checkbox" id="TWFIF" class="largerCheck"> &nbsp2015 PM 2.5</h2>
  <h2><input type="checkbox" id="TWSIX" class="largerCheck"> &nbsp2016 PM 2.5</h2>
  <h2><input type="checkbox" id="TWSEV" class="largerCheck"> &nbsp2017 PM 2.5</h2>
  <h2><input type="checkbox" id="TWEIG" class="largerCheck"> &nbsp2018 PM 2.5</h2>
  <h2><input type="checkbox" id="TWNIN" class="largerCheck"> &nbsp2019 PM 2.5</h2>
  </ul>
 </div>`,
};

const slides = [storySlide, filterslide];

const motive = {
  title: 'Summary Statistics',
  slide: 'motive',
  content: `<p>Here, we want to put an interactive data table that presents summary statistics depending on the layer shown and the user's selected district.</p>`
};

// const motivationText = [motive]
