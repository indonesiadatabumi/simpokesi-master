 var map, polygon, marker, markers;

function initMap(url, inputLat = null, inputLong = null, parentElement = null) {
    map = L.map('map', {
        maxZoom: 18,
        minZoom: 6,
        zoomControl: false
    }).setView([-6.2742549,106.9535732], 12);

    L.tileLayer('https://cartodb-basemaps-d.global.ssl.fastly.net/light_all/{z}/{x}/{y}{r}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    L.control.zoom({
        position: 'bottomleft'
    }).addTo(map);

    $.getJSON(url, res => {
        res.features = res.features.filter(content => content.properties.bps_kabupaten_kode == 3275)
        polygon = L.geoJSON(res, {
            style: (feature) => {
                return {
                    color: '#666',
                    fillColor: '#f5f5f5',
                    fillOpacity: .6,
                    weight: 1
                }
            },
            onEachFeature: function (feature, layer) {
                layer.bindTooltip(feature.properties.kemendagri_kecamatan_nama);
            }
        });

        map.addLayer(polygon);
        map.fitBounds(polygon.getBounds());
    });

    if (inputLat && inputLong) {
        map.on('click', function (e) {
            if (map.hasLayer(marker)) {
                map.removeLayer(marker);
            }
            marker = new L.marker(e.latlng, {
                icon: L.divIcon({
                        iconAnchor: [20, 51],
                        popupAnchor: [0, -51],
                        className: 'listeo-marker-icon',
                        html: '<div class="marker-container">' +
                            '<div class="marker-card">' +
                            '<div class="front face"><i class="fa fa-hotel"></i></div>' +
                            '<div class="back face"><i class="fa fa-hotel"></i></div>' +
                            '<div class="marker-arrow"></div>' +
                            '</div>' +
                            '</div>'
                    }
                )
            });
            map.addLayer(marker);

            if (parentElement) {
                parentElement.find(inputLat).val(e.latlng['lat']);
                parentElement.find(inputLong).val(e.latlng['lng']);
            } else {
                inputLat.val(e.latlng['lat']);
                inputLong.val(e.latlng['lng']);
            }
        });
    }
}
