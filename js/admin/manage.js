$(function () {
    intelli.marker = null;
    var mapInfo = $('#item-gmap-data');

    var itemPosition = {
        lat: $('input[name="lat"]', mapInfo).val(),
        lng: $('input[name="lng"]', mapInfo).val()
    };

    $('#address_fieldzone').parent().append($('#js-gmap-wrapper'));
    $('#js-gmap-wrapper').removeClass('hidden');


    var map = new google.maps.Map(document.getElementById('js-gmap-renderer'), {mapTypeId: google.maps.MapTypeId.ROADMAP});
    var geocoder = new google.maps.Geocoder();

    if (itemPosition.lat !== '0' && itemPosition.lng !== '0') {
        map.setZoom(11);
        geooptions = {latLng: new google.maps.LatLng(parseFloat(itemPosition.lat), parseFloat(itemPosition.lng))};
    }
    else {
        map.setZoom(3);
        geooptions = {address: 'USA'};
    }

    console.log(itemPosition.lat);

    geocoder.geocode(geooptions, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            intelli.marker = new google.maps.Marker(
                {
                    map: map,
                    position: results[0].geometry.location,
                    draggable: true
                });

            map.setCenter(results[0].geometry.location);

            google.maps.event.addListener(
                intelli.marker,
                'drag',
                function () {
                    $('input[name="lng"]', mapInfo).val(intelli.marker.position.lng());
                    $('input[name="lat"]', mapInfo).val(intelli.marker.position.lat());
                }
            );
        }
    });

    intelli.geocoder = geocoder;
    intelli.map = map;

    google.maps.event.trigger(intelli.map, 'resize');
    if (intelli.marker !== null) {
        intelli.map.setCenter(intelli.marker.getPosition());
    }


    $('#input-address').on('input', function () {
        var fullAddress = '';

        if ('' != $(this).val()) {
            fullAddress += ' ' + $(this).val();
        }

        intelli.geocoder.geocode({address: fullAddress}, function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                intelli.marker.setPosition(results[0].geometry.location);
                map.setCenter(results[0].geometry.location);

                $('input[name="lng"]', mapInfo).val(intelli.marker.position.lng());
                $('input[name="lat"]', mapInfo).val(intelli.marker.position.lat());
            }
        });
    });
});