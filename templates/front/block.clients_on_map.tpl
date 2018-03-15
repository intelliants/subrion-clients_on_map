{if $clients_on_map}
    <div id="map" style=" width: {$core.config.clients_on_map_width}; height: {$core.config.clients_on_map_height}"></div>
    {switch $core.config.clients_on_map_type}
        {case 'google_maps'}
            <script type="text/javascript" src="https://maps.google.com/maps/api/js?key={$core.config.maps_api_key}"></script>
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
                        scrollwheel: false
                    };

                    var map = new google.maps.Map(document.getElementById("map"), myOptions);
                    var bounds = new google.maps.LatLngBounds();

                    {foreach $clients_on_map as $entry}
                        {if empty($entry.address)}
                            {assign var="content" value="<strong>{$entry.fullname}</strong>"}
                        {else}
                            {assign var="content" value="<strong>{$entry.fullname}</strong><br>{$entry.address}"}
                        {/if}
                        var item{$entry.id} = new google.maps.LatLng({$entry.lat}, {$entry.lng});
                        var marker{$entry.id} = new google.maps.Marker({
                            position: item{$entry.id},
                            map: map,
                            title: '{$entry.fullname}',
                            icon: '{$smarty.const.IA_CLEAR_URL}modules/clients_on_map/templates/front/img/marker.png',
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

        {case 'yandex_maps'}

            <script src="https://api-maps.yandex.ru/2.1/?lang=ru_RU" type="text/javascript"></script>
            <script type="text/javascript">
                ymaps.ready(init);

                var myMap,
                    myPlacemark;

                function init(){
                    var optionsMarkerImage;
                    optionsMarkerImage =
                    {
                        iconLayout: 'default#image',
                        iconImageHref: '{$smarty.const.IA_CLEAR_URL}modules/clients_on_map/templates/front/img/marker.png',
                        iconImageSize: [30, 39],

                    };
                    {if $clients_on_map|@count > 1}
                        var myCollection = new ymaps.GeoObjectCollection();
                        myMap = new ymaps.Map("map", {
                            center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
                            zoom: {$core.config.clients_on_map_zoom},
                            controls: ['zoomControl']
                            });
                        {foreach $clients_on_map as $key => $entry}
                            myPlacemark = new ymaps.Placemark([{$entry.lat}, {$entry.lng}], {

                                hintContent: '{$entry.fullname}',
                                balloonContent: '<strong>{$entry.fullname}</strong>{if $entry.address}<p>{$entry.address}</p>{/if}'}, optionsMarkerImage
                                );
                            myCollection.add(myPlacemark);

                        {/foreach}
                        myMap.geoObjects.add(myCollection);
                        myMap.setBounds( myCollection.getBounds() );
                    {else}
                        myMap = new ymaps.Map("map", {
                            center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
                            zoom: {$core.config.clients_on_map_zoom},
                        });
                        myPlacemark = new ymaps.Placemark([{$clients_on_map[0].lat}, {$clients_on_map[0].lng}], {
                            hintContent: '{$clients_on_map[0].fullname}',
                            balloonContent: '<strong>{$clients_on_map[0].fullname}</strong>{if $clients_on_map[0].address}<p>{$clients_on_map[0].address}</p>{/if}'},	optionsMarkerImage
                        );
                        myMap.geoObjects.add(myPlacemark);
                    {/if}
                }
            </script>
        {/case}

        {case '2gis'}
            <script src="http://maps.api.2gis.ru/2.0/loader.js?pkg=full"></script>
            <script type="text/javascript">
                var map,
                    optionsMarker;

                optionsMarker =
                {
                    iconUrl: '{$smarty.const.IA_CLEAR_URL}modules/clients_on_map/templates/front/img/marker.png',
                    iconSize: [30, 39],
                }

                {if $clients_on_map|@count > 1}
                    DG.then(function(){
                        var markers = DG.featureGroup(),
                            coordinates = [];
                        map = DG.map('map', {
                            center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
                            zoom: {$core.config.clients_on_map_zoom},
                        });
                        {foreach $clients_on_map as $entry}

                            var myIcon = DG.icon(optionsMarker);
                            coordinates[0] = {$entry.lat};
                            coordinates[1] = {$entry.lng};
                            DG.marker(coordinates, {literal}{icon: myIcon}{/literal}).addTo(markers).bindPopup('<strong>{$entry.fullname}</strong>{if $entry.address}<p>{$entry.address}</p>{/if}');;

                        {/foreach}

                        markers.addTo(map);
                        map.fitBounds(markers.getBounds());
                    });
                {else}
                    DG.then(function () {
                        var myIcon = DG.icon(optionsMarker);

                        map = DG.map('map', {
                            center: [{$clients_on_map[0].lat}, {$clients_on_map[0].lng}],
                            zoom: {$core.config.clients_on_map_zoom}
                        });

                        DG.marker([{$clients_on_map[0].lat}, {$clients_on_map[0].lng}], {literal}{icon: myIcon}{/literal}).addTo(map).bindPopup('<strong>{$clients_on_map[0].fullname}</strong>{if $clients_on_map[0].address}<p>{$clients_on_map[0].address}</p>{/if}');
                    });
                {/if}
            </script>
        {/case}
    {/switch}
{/if}
