Ext.onReady(function()
{
	var grid = new IntelliGrid(
	{
		columns: [
			'selection',
			{name: 'client', title: _t('client'), width: 2, editor: 'text'},
			'status',
			'update',
			'delete'
		],
		sorters: [{direction: 'DESC'}]
	}, false);

	grid.toolbar = Ext.create('Ext.Toolbar', {items:[
	{
		emptyText: _t('text'),
		name: 'text',
		listeners: intelli.gridHelper.listener.specialKey,
		xtype: 'textfield'
	},{
		displayField: 'client',
		editable: false,
		emptyText: _t('status'),
		id: 'fltStatus',
		name: 'status',
		store: grid.stores.statuses,
		typeAhead: true,
		valueField: 'value',
		xtype: 'combo'
	},{
		handler: function(){intelli.gridHelper.search(grid);},
		id: 'fltBtn',
		text: '<i class="i-search"></i> ' + _t('search')
	},{
		handler: function(){intelli.gridHelper.search(grid, true);},
		text: '<i class="i-close"></i> ' + _t('reset')
	}]});
	grid.init();

	var searchStatus = intelli.urlVal('status');
	if (searchStatus)
	{
		Ext.getCmp('fltStatus').setValue(searchStatus);
		intelli.gridHelper.search(grid);
	}
});
