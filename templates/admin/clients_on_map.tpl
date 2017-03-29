<form method="post" enctype="multipart/form-data" class="sap-form form-horizontal">
    {preventCsrf}

    <div class="wrap-list">
        <div class="wrap-group">
            <div class="wrap-group-heading">
                <h4>{lang key='options'}</h4>
            </div>

            <div class="row">
                <label class="col col-lg-2 control-label" for="input-client">{lang key='client'}</label>
                <div class="col col-lg-4">
                    <input type="text" name="client" value="{if isset($item.client)}{$item.client|escape}{/if}"
                           id="input-client">
                </div>
            </div>

            <div class="row">
                <label class="col col-lg-2 control-label" for="input-address">{lang key='address'}</label>
                <div class="col col-lg-4">
                    <input type="text" name="address"
                           value="{if isset($item.address)}{$item.address|escape}{/if}" id="input-address">
                </div>
            </div>

            <div class="row hidden" id="js-gmap-wrapper">
                <script type="text/javascript"
                        src="https://maps.google.com/maps/api/js?key={$core.config.clients_on_map_key}"></script>
                <div class="gmap-data hidden" id="item-gmap-data">
                    <input type="hidden" name="lng" value="{if isset($item.lng)}{$item.lng}{/if}">
                    <input type="hidden" name="lat" value="{if isset($item.lat)}{$item.lat}{/if}">
                </div>

                <label id="js-gmap-annotation" class="col col-lg-2 control-label">{lang key='location'}</label>
                <div id="js-gmap-renderer" class="col col-lg-8" style="height: 350px;"></div>
            </div>
        </div>

        {include file='fields-system.tpl' noSystemFields=true}

    </div>
</form>

{ia_print_js files='_IA_URL_modules/clients_on_map/js/admin/manage' order='3'}
