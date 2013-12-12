/** 
 *  Autogenerated, do not modify this file directly
 **/
/**
 * Geographic Information Network of Alaska
 * GINA Web Layers Javascript Library
 * @author Will Fisher
 **/
(function(){var a=this;typeof Gina=="undefined"&&(a.Gina={isArray:"isArray"in Array?Array.isArray:function(a){return Object.prototype.toString.call(a)==="[object Array]"},isString:function(a){return typeof a=="string"}}),Gina.global=a,Gina.Projections={define:function(a,b){Gina.Projections[a]=b},get:function(a){return Gina.Projections[a]?Gina.Projections[a]:Gina.Projections.build(a)},build:function(a){return!1}},Gina.layerHandlers={},Gina.Layers={Types:{TILE:"tile",WMS:"wms"},get:function(a,b){var c=a.split("."),d,e=Gina.Layers,f;for(d=0;d<c.length;d++){f=c[d];if(!e[f])return null;e=e[f]}return!b&&e&&e.type&&Gina.layerHandlers[e.type]?Gina.layerHandlers[e.type](e,a):e},getIDs:function(a){var b=a.split("."),c,d=Gina.Layers,e,f=[],g=[];for(c=0;c<b.length;c++){e=b[c];if(Gina.Layers.isWildcard(e)){var h=f.join(".");for(var i in d)g.push(h+"."+i)}else f.push(e);d=d[e]}return g},define:function(a,b){var c=a.split("."),d=c.length-1,e=Gina.Layers,f,g;b&&b.type&&(f=b.type);for(g=0;g<c.length-1;g++){var h=c[g];e[h]||(e[h]={}),e=e[h]}return e[c[d]]=b,e},exists:function(a){return Gina.Layers.get(a)!==null},isWildcard:function(a){var b=/\*$/;return a.match(b)},inject:function(a,b){Gina.isString(b)&&(b=[b]),Gina.isArray(b)?Gina.Layers.injectEachLayer(a,b):Gina.Layers.injectLayer(a,b)},injectEachLayer:function(a,b){for(var c=0;c<b.length;c++)Gina.isString(b[c])&&Gina.Layers.isWildcard(b[c])?Gina.Layers.inject(a,Gina.Layers.getIDs(b[c])):Gina.Layers.injectLayer(a,b[c])},injectLayer:function(a,b){Gina.isString(b)&&Gina.Layers.exists(b)?Gina.layerHandlers.inject(a,Gina.Layers.get(b),b):Gina.layerHandlers.inject(a,b)}}})(),Gina.Layers.define("TILE.EPSG:3338.BDL",{name:"Best Data Layer",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/bdl_aa/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,wmsId:"WMS.BDL"}}),Gina.Layers.define("TILE.EPSG:3572.BDL",{name:"Best Data Layer",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/bdl_3572/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,wmsId:"WMS.BDL"}}),Gina.Layers.define("TILE.EPSG:3857.BDL",{name:"Best Data Layer",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/bdl/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!0,visibility:!0,isBaseLayer:!0,sphericalMercator:!0,wmsId:"WMS.BDL"}}),Gina.Layers.define("WMS.BDL",{name:"Best Data Layer",type:Gina.Layers.Types.WMS,url:"http://wms.alaskamapped.org/bdl",wmsOptions:{layers:"BestDataAvailableLayer",transparent:!1},layerOptions:{wrapDateLine:!1,isBaseLayer:!0}}),Gina.Layers.define("TILE.EPSG:3857.CHARTS",{name:"Nautical Charts",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/charts/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,sphericalMercator:!0,wmsId:"WMS.CHARTS"}}),Gina.Layers.define("WMS.CHARTS",{name:"NOAA Charts",type:Gina.Layers.Types.WMS,url:"http://wms.alaskamapped.org/charts",wmsOptions:{layers:"NOAA_Charts",transparent:!1},layerOptions:{wrapDateLine:!1,isBaseLayer:!0}}),Gina.Layers.define("TILE.EPSG:3857.LANDSAT_PAN",{name:"Landsat - Panchromatic",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/landsat_pan/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,sphericalMercator:!0}}),Gina.Layers.define("TILE.EPSG:3338.OSM",{name:"OpenStreetMap",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/test/tilesrv/osm/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,attribution:'(c) <a href="http://www.openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'}}),Gina.Layers.define("TILE.EPSG:3572.OSM_OVERLAY",{name:"OpenStreetMap - Roads & Cities",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/test/tilesrv/osm-google-ol-3572/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!1,attribution:'(c) <a href="http://www.openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'}}),Gina.Layers.define("TILE.EPSG:3338.OSM_OVERLAY",{name:"OpenStreetMap - Roads & Cities",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/test/tilesrv/osm-google-ol/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!1,attribution:'(c) <a href="http://www.openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>'}}),Gina.Layers.define("TILE.EPSG:3857.SHADED_RELIEF",{name:"Shaded Relief",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/shaded_relief_ned/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,sphericalMercator:!0}}),Gina.Layers.define("TILE.EPSG:3338.SHADED_RELIEF",{name:"Shaded Relief + Bathymetry",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/aea_gina_bathymetry_aa/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0}}),Gina.Layers.define("TILE.EPSG:3857.SDMI_ORTHO_RGB",{name:"SDMI Ortho Natural Color",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/SPOT5.SDMI.ORTHO_RGB/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!1,isBaseLayer:!1,sphericalMercator:!0}}),Gina.Layers.define("TILE.EPSG:3857.SDMI_ORTHO_CIR",{name:"SDMI Ortho Color Infrared",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/SPOT5.SDMI.ORTHO_CIR/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!1,isBaseLayer:!1,sphericalMercator:!0}}),Gina.Layers.define("TILE.EPSG:3857.SDMI_ORTHO_GS",{name:"SDMI Ortho Grayscale",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/SPOT5.SDMI.ORTHO_PAN/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!1,isBaseLayer:!1,sphericalMercator:!0}}),Gina.Layers.define("TILE.EPSG:3338.SDMI_ORTHO_RGB",{name:"SDMI Ortho Natural Color",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/SPOT5.SDMI.ORTHO_RGB_aa/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!1,isBaseLayer:!1}}),Gina.Layers.define("TILE.EPSG:3338.SDMI_ORTHO_CIR",{name:"SDMI Ortho Color Infrared",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/SPOT5.SDMI.ORTHO_CIR_aa/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!1,isBaseLayer:!1}}),Gina.Layers.define("TILE.EPSG:3338.SDMI_ORTHO_GS",{name:"SDMI Ortho Grayscale",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tiles/SPOT5.SDMI.ORTHO_PAN_aa/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!1,isBaseLayer:!1}}),Gina.Layers.define("TILE.EPSG:3338.TOPO",{name:"Topographic DRG",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/drg_shaded_aa/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,wmsId:"WMS.TOPO"}}),Gina.Layers.define("TILE.EPSG:3857.TOPO",{name:"Topographic DRG",type:Gina.Layers.Types.TILE,url:"http://tiles.gina.alaska.edu/tilesrv/drg/tile/${x}/${y}/${z}",layerOptions:{type:"jpeg",transitionEffect:"resize",wrapDateLine:!1,visibility:!0,isBaseLayer:!0,sphericalMercator:!0,wmsId:"WMS.TOPO"}}),Gina.Layers.define("WMS.TOPO",{name:"Topographic DRG",type:Gina.Layers.Types.WMS,url:"http://no.gina.alaska.edu/extras",wmsOptions:{layers:"Hill Shaded DRG",transparent:!1},layerOptions:{wrapDateLine:!1,isBaseLayer:!0}}),Gina.layerHandlers={inject:function(a,b,c){a.entities.push(b)},tile:function(a,b){var c=function(b){var c=a.url;return c=c.replace("${x}",b.x),c=c.replace("${y}",b.y),c=c.replace("${z}",b.levelOfDetail),c+".png"},d=new Microsoft.Maps.TileSource({uriConstructor:c}),e=new Microsoft.Maps.TileLayer({mercator:d,opacity:1});return e}}