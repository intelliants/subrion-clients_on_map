<?php
/******************************************************************************
 *
 * Subrion - open source content management system
 * Copyright (C) 2018 Intelliants, LLC <https://intelliants.com>
 *
 * This file is part of Subrion.
 *
 * Subrion is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Subrion is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Subrion. If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * @link https://subrion.org/
 *
 ******************************************************************************/

if (iaView::REQUEST_HTML == $iaView->getRequestType()) {
    if ($iaView->blockExists('clients_on_map')) {
        $stmt = '`status` = :status AND `lang` = :language';
        $iaDb->bind($stmt, array('status' => iaCore::STATUS_ACTIVE, 'language' => $iaView->language));

        $sql = <<<SQL
SELECT SQL_CALC_FOUND_ROWS `id`, `client`, `address`, `lat`, `lng`
  FROM `:table_gmap` 
WHERE :statement
SQL;
        $sql = iaDb::printf($sql, array(
            'table_gmap' => $iaDb->prefix . 'clients_on_map',
            'statement' => $stmt,
            'status' => iaCore::STATUS_ACTIVE,
            'language' => $iaView->language
        ));
        $data = $iaDb->getAll($sql);

        $iaView->assign('clients_on_map', $data);
    }
}
