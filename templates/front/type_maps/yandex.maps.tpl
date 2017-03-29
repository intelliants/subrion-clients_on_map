{if $clients_on_map}
    {switch $core.config.clients_on_map_type}
    {case 'google_maps'}
        <script src="//maps.google.com/maps/api/js?sensor=true"></script>
        <script>
            function initialize() {
                var myOptions = {
                    {if $clients_on_map|@count > 1}
                    center: new google.maps.LatLng(0, 0),
                    {else}
                    center: new google.maps.LatLng({$clients_on_map[0].lat}, {$clients_on_map[0].lng}),
                    {/if}
                    zoom: {$core.config.clients_on_map_zoom},
                    styles: {$core.config.clients_on_map_style},
                    scrollwheel: false,
                };
                var map = new google.maps.Map(document.getElementById("map"), myOptions);

                var bounds = new google.maps.LatLngBounds();

                {foreach $clients_on_map as $entry}
                {if empty($entry.address)}
                    {assign var="content" value="<strong>{$entry.client}</strong>"}
                {else}
                    {assign var="content" value="<strong>{$entry.client}</strong><br>{$entry.address}"}
                {/if}
                var item{$entry.id} = new google.maps.LatLng({$entry.lat}, {$entry.lng});
                var marker{$entry.id} = new google.maps.Marker({
                    position: item{$entry.id},
                    map: map,
                    title: '{$entry.client}',
                    icon: '/modules/clients_on_map/templates/front/img/marker.png',
                    info: new google.maps.InfoWindow({
                        content: {json_encode($content)}
                    })
                });
                bounds.extend(item{$entry.id});

                google.maps.event.addListener(marker{$entry.id}, 'click', function() {
                    marker{$entry.id}.info.open(map, marker{$entry.id});
                });
                {/foreach}

                {if $clients_on_map|@count > 1}
                map.fitBounds(bounds);
                {/if}
            }
            initialize();
        </script>
    {/case}


    {/switch}
    <div id="map" style=" width: {$core.config.clients_on_map_width}; height: {$core.config.clients_on_map_height}"></div>


{/if}

{*get map if two or more markers*}
var myCollection = new ymaps.GeoObjectCollection();
myMap = new ymaps.Map("map", {
center: [50, 50], // Начальные значения центра карты
zoom: 15,         // Начальное значение зума карты
controls: ['zoomControl']
});
{foreach $clients_on_map as $key => $entry}
myPlacemark = new ymaps.Placemark([{$entry.lat}, {$entry.lng}], }
hintContent: 'Москва!',
balloonContent: '{$entry.client}'
});
var myPlacemark = new ymaps.Placemark([{$entry.lat}, {$entry.lng}], {
balloonContent: '{$entry.client}'
});
myCollection.add(myPlacemark);
{/foreach}
myMap.geoObjects.add(myPlacemark);
myMap.setBounds( myCollection.getBounds() );

myMap = new ymaps.Map("map", {
{if $clients_on_map|@count > 1}
    {*detect center if two  or more markers*}
    center: [0, 0],

{else}
    {* Detect center if one marker*}
    center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
    zoom: {$core.config.clients_on_map_zoom},
{/if}
});

{if $clients_on_map|@count > 1}


{else}
    {*get map if one marker*}
    myPlacemark = new ymaps.Placemark([{$clients_on_map[0].lat}, {$clients_on_map[0].lng}], {
    hintContent: 'Москва!',
    balloonContent: {json_encode($content)}
    });
    myMap.geoObjects.add(myPlacemark);
{/if}