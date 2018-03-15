<?php

class iaBackendController extends iaAbstractControllerModuleBackend
{
    protected $_name = 'clients_on_map';

    protected $_table = 'clients_on_map';

    protected $_itemName = 'client';

    protected $_gridFilters = ['fullname' => self::LIKE, 'status' => self::EQUAL];

    protected $_gridColumns = ['fullname', 'date_added', 'date_modified', 'status'];

    public function init()
    {
        $this->_path = IA_ADMIN_URL . $this->getName() . IA_URL_DELIMITER;
    }

    protected function _indexPage(&$iaView)
    {
        $iaView->grid('_IA_URL_modules/' . $this->getModuleName() . '/js/admin/index');
    }
    protected function _entryAdd(array $entryData)
    {
        $entryData['date_added'] = date(iaDb::DATETIME_FORMAT);

        return parent::_entryAdd($entryData);
    }

    protected function _entryUpdate(array $entryData, $entryId)
    {
        $entryData['date_modified'] = date(iaDb::DATETIME_FORMAT);

        return parent::_entryUpdate($entryData, $entryId);
    }

    protected function _assignValues(&$iaView, array &$entryData)
    {
        parent::_assignValues($iaView, $entryData);

        unset($entryData['date_added']);
    }

    protected function _setDefaultValues(array &$entry)
    {
        $entry = [
            'lat'  => 37.09024,
            'lng'  => -95.71289100000001,
            'featured' => false,
            'status' => iaCore::STATUS_ACTIVE,
        ];
    }

}
