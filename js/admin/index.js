Ext.onReady(function () {
    var grid = new IntelliGrid(
        {
            columns: [
                'selection',
                {name: 'fullname', title: _t('fullname'), width: 2, editor: 'text'},
                'status',
                'update',
                'delete'
            ],
            sorters: [{direction: 'DESC'}]
        }, false);

    grid.toolbar = Ext.create('Ext.Toolbar', {
        items: [
            {
                emptyText: _t('text'),
                name: 'fullname',
                listeners: intelli.gridHelper.listener.specialKey,
                xtype: 'textfield'
            }, {
                displayField: 'title',
                editable: true,
                emptyText: _t('status'),
                id: 'fltStatus',
                name: 'status',
                store: grid.stores.statuses,
                typeAhead: true,
                valueField: 'value',
                xtype: 'combo'
            }, {
                handler: function () {
                    intelli.gridHelper.search(grid);
                },
                id: 'fltBtn',
                text: '<i class="i-search"></i> ' + _t('search')
            }, {
                handler: function () {
                    intelli.gridHelper.search(grid, true);
                },
                text: '<i class="i-close"></i> ' + _t('reset')
            }]
    });

    grid.init();
});
