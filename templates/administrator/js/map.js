
var def_zoom = 11;
var def_lat = 57.04932;
var def_lng = 61.47263;

var glat = '';
var glng = '';
var gzoom = '';

var poli = [];
//var polyline = L.polyline({color: 'red'});
//polyline.editing.enable();

var loadmap = new Object({
	initialize: function(t)
    {
		this.type = t;
		$('#map').html(
		'<div id="west">Запад</div>' +
		'<div id="east">Восток</div>' +
		'<div id="north">Север</div>' +
		'<div id="south">Юг</div>' +
		'<div id="zoom">Зум</div>' +
		'<div id="center">Центр</div>'
		);
		
		$('#map-bi').hide();
		$('#map-bd').show();
		
		glat = $('#'+t+'_lat').val();
		glng = $('#'+t+'_lng').val();
		gzoom = $('#'+t+'_zoom').val();
		
		if (glat == '' || glat == 0) glat = def_lat;
		if (glng == '' || glng == 0) glng = def_lng;
		if (gzoom == '' || gzoom == 0) gzoom = def_zoom;
		
		var map = L.map('map',{
			zoom: gzoom,
			center: [glat,glng],
			maxZoom: 18,
			minZoom: 5
		});
		
		var drawnItems = new L.FeatureGroup();
		map.addLayer(drawnItems);
		
		var drawControl = new L.Control.Draw({
			draw: {
				position: 'topleft',
				polyline: {
					shapeOptions: {
						color: '#0000FF'
					}
				},
				polygon: {
					title: 'Draw a sexy polygon!',
					allowIntersection: false,
					drawError: {
						color: '#b00b00',
						timeout: 1000
					},
					shapeOptions: {
						color: '#bada55'
					}
				},
				circle: {
					shapeOptions: {
						color: '#662d91'
					}
				}
			},
			edit: {
				featureGroup: drawnItems
			}
		});
		map.addControl(drawControl);

		L.tileLayer('http://tile.openstreetmap.org/{z}/{x}/{y}.png', {
			attribution: '&copy; <a href="http://openstreetmap.org">OpenStreetMap</a>'
		}).addTo(map);
		
		var polyline1 = new L.Polyline([
			[57.12262, 61.38901],
			[57.12264, 61.38968],
			[57.12268, 61.39002],
			[57.1252, 61.40045]
		]);
		polyline1.editing.enable();
		map.addLayer(polyline1);
		polyline1.on('edit', function() {
			$('#street_line').val(polyline1.getLatLngs());
		});
		
		map.on('draw:created', function (e) {
			var type = e.layerType,
				layer = e.layer;

			if (type === 'marker') {
				alert('marker');
			}
			if (type === 'polyline') {
				map.fitBounds(layer.getBounds());
				//alert(layer.getLatLngs());
				$('#street_line').val(layer.getLatLngs());
			}
			if (type === 'polygon') {
				alert('polygon');
			}

			drawnItems.addLayer(layer);
		});

		map.on('draw:edited', function (e) {
			var layers = e.layers;
			var countOfEditedLayers = 0;
			layers.eachLayer(function(layer) {
			});
		});
		
		map.on('move', this.onMapMove);
		map.on('moveend', this.onMapMoveend);
		//map.on('click', this.onMapClick);
    },
	onMapMove: function(e)
	{
		$('#map').css({'cursor':'move'});
		var map = e.target;
		var str = map.getBounds().toBBoxString();
		var tBounds = str.split(',');
		var zoom = map.getZoom();
		var center = map.getCenter().toString();
		var tcenter = center.slice(7,-1).split(',');
		$('#west').html(tBounds[0]);
		$('#east').html(tBounds[2]);
		$('#north').html(tBounds[3]);
		$('#south').html(tBounds[1]);
		$('#zoom').html(zoom);
		$('#center').html(center);
		
		glat = tcenter[0];
		glng = tcenter[1];
		gzoom = zoom;
	},
	onMapMoveend: function(e)
	{
		$('#map').css({'cursor':'default'});
	},
	onMapClick: function(e)
	{
		var p = $('#poliline').val();
		if (p == 1) {
			var map = e.target;
			var click = e.latlng.toString().slice(7,-1).split(',');
			var koo = [];
			koo.push(parseFloat(click[0]));
			koo.push(parseFloat(click[1]));
			poli.push(koo);
			
			polyline.setLatLngs(poli).addTo(map);
			//alert(polyline.getLatLngs());
			polyline.on('move', this.onPolylineMove);
			
		}
	},
	onPolylineMove: function(e)
	{
		alert('1');
	},
	getdata: function(t)
	{
		$('#'+t+'_lat').val(glat);
		$('#'+t+'_lng').val(glng);
		$('#'+t+'_zoom').val(gzoom);		
	}
	
});