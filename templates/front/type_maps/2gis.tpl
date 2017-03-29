<script src="//maps.api.2gis.ru/2.0/loader.js?pkg=full"></script>
<script type="text/javascript">
    var map;

    {if $clients_on_map|@count > 1}
    DG.then(function(){
        var markers = DG.featureGroup(),
                coordinates = [];
        map = DG.map('map', {
            center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
            zoom: {$core.config.clients_on_map_zoom},
        });
        {foreach $clients_on_map as $entry}
        var myIcon = DG.icon({
            iconUrl: '/modules/clients_on_map/templates/front/img/marker.png',
            iconRetinaUrl: 'my-icon@2x.png',
            iconSize: [30, 39],
        });
        coordinates[0] = {$entry.lat};
        coordinates[1] = {$entry.lng};
        DG.marker(coordinates, {literal}{icon: myIcon}{/literal}).addTo(markers).bindPopup('<strong>{$entry.client}</strong>{if $entry.address}<p>{$entry.address}</p>{/if}');;
        {/foreach}
        markers.addTo(map);
        map.fitBounds(markers.getBounds());
    });
    {else}

    DG.then(function () {
        var myIcon = DG.icon({
            iconUrl: '/modules/clients_on_map/templates/front/img/marker.png',
            iconRetinaUrl: 'my-icon@2x.png',
            iconSize: [30, 39],
        });
        map = DG.map('map', {
            center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
            zoom: {$core.config.clients_on_map_zoom}
        });

        DG.marker([{$clients_on_map[0].lat}, {$clients_on_map[0].lng}], {literal}{icon: myIcon}{/literal}).addTo(map).bindPopup('<strong>{$clients_on_map[0].client}</strong>{if $clients_on_map[0].address}<p>{$clients_on_map[0].address}</p>{/if}');
    });
    {/if}
</script>