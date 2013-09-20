
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
		
	glat = $('#draw-lat').val();
	glng = $('#draw-lng').val();
	gzoom = $('#draw-zoom').val();
		
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
        
        $('#draw-elements input').each(function(){
            var position = $(this).val();
            var type =  $(this).hasClass('poliline')?'poliline':
                        $(this).hasClass('polygon')?'polygon':
                        $(this).hasClass('marker')?'marker':'poliline';
            if (position)
            {
                var arr = kootoarr(position);
                if (type === 'poliline') var element = new L.Polyline(arr);
                if (type === 'polygon') var element = new L.Polygon(arr);
                if (type === 'marker') var element = new L.Marker(arr);
                drawnItems.addLayer(element);
                $(this).attr('id','draw' + element._leaflet_id);
            }
        });
			
	map.on('draw:created', function (e) {
            var type = e.layerType,
            layer = e.layer;

            if (type === 'marker') {
		var val = layer.getLatLng();
                var wrap = $('#draw-elements');
                var inner = $('<div class="control-group"><label class="control-label" for="marker">Marker:</label><div class="controls"><input type="text" class="textbox" id="draw-temp" name="marker[]" value="' + val + '" required /></div></div>');
                wrap.append(inner);
            }
            if (type === 'polyline') {
		//map.fitBounds(layer.getBounds());
		//alert(layer.getLatLngs());
                var val = layer.getLatLngs();
                var wrap = $('#draw-elements');
                var inner = $('<div class="control-group"><label class="control-label" for="poliline">Poliline:</label><div class="controls"><input type="text" class="textbox" id="draw-temp" name="poliline[]" value="' + val + '" required /></div></div>');
                wrap.append(inner);
            }
            if (type === 'polygon') {
		var val = layer.getLatLngs();
                var wrap = $('#draw-elements');
                var inner = $('<div class="control-group"><label class="control-label" for="polygon">Polygon:</label><div class="controls"><input type="text" class="textbox" id="draw-temp" name="polygon[]" value="' + val + '" required /></div></div>');
                wrap.append(inner);
            }

            drawnItems.addLayer(layer);
            $('#draw-temp').attr('id','draw' + layer._leaflet_id);
	});

	map.on('draw:edited', function (e) {
            drawnItems.eachLayer(function (layer) {
                $('#draw' + layer._leaflet_id).val(layer.getLatLngs());
            });
	});
        
        map.on('draw:deleted', function (e) {
            /*var de = $('#draw-elements');
            de.html('');
            drawnItems.eachLayer(function (layer) {
               var id = '#draw' + layer._leaflet_id;
               var val = layer.getLatLngs();
               var inner = $('<div class="control-group"><label class="control-label" for="street_line">Координаты:</label><div class="controls"><input type="text" class="textbox street_line" id="' + id + '" name="street_line[]" value="' + val + '" required /></div></div>');
               de.append(inner);
            });*/
            var layers = e.layers;
            layers.eachLayer(function(layer) {
                $('#draw' + layer._leaflet_id).remove();
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
        
        $('#draw-lat').val(glat);
	$('#draw-lng').val(glng);
	$('#draw-zoom').val(gzoom);
    },
    onMapMoveend: function(e)
    {
        $('#map').css({'cursor':'default'});
    }
});

function kootoarr(pos)
{
    var arr = [];
    var arr2 = [];
    var re = /[0-9]+\.[0-9]+\, *[0-9]+\.[0-9]+/ig;
    var re2 = /[0-9]+\.[0-9]+/ig;
    var res = pos.match(re);
    var res2 = [];
    
    if (res.length > 0)
    {
        for(var i=0; i<res.length; i++)
        {
            res2 = res[i].match(re2);
            arr2 = [];
            for(var i2=0; i2<res2.length; i2++) 
            {
                arr2.push(parseFloat(res2[i2]));
            }
            arr.push(arr2);
        }
    }
    
    if (res.length === 1) return arr2;
    return arr;
}

function objToString (obj) {
    var str = '';
    for (var p in obj) {
        if (obj.hasOwnProperty(p)) {
            str += p + '::' + obj[p] + '\n';
        }
    }
    return str;
}