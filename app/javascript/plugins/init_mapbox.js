import mapboxgl from 'mapbox-gl';


const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(map);
  });
};

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 1 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('map');
  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const attributes = {
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    }

    const map = new mapboxgl.Map(attributes);

    //const markers = JSON.parse(mapElement.dataset.markers);

    //addMarkersToMap(map, markers)

    //fitMapToMarkers(map, markers);

  }
};

// exportar a função
export { initMapbox };

