<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
    {preventCsrf}

    {capture name='general' append='fieldset_after'}
        <div class="row hidden" id="js-gmap-wrapper">
            <script type="text/javascript"
                    src="https://maps.google.com/maps/api/js?key={$core.config.maps_api_key}">
            </script>

            <label id="js-gmap-annotation" class="col col-lg-2 control-label">{lang key='location'}</label>
            <div id="js-gmap-renderer" class="col col-lg-8" style="height: 350px;"></div>
        </div>
    {/capture}

    {include 'field-type-content-fieldset.tpl' isSystem=true}
</form>

{ia_print_js files='_IA_URL_modules/clients_on_map/js/admin/manage' order='3'}
