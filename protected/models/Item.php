<?php

/**
 * This is the model class for table "item".
 *
 * The followings are the available columns in table 'item':
 * @property integer $id
 * @property string $name
 * @property string $item_number
 * @property string $isbn
 * @property integer $unit_id
 * @property integer $currency_code
 * @property integer $author_id
 * @property integer $public_id
 * @property integer $category_id
 * @property integer $supplier_id
 * @property double $cost_price
 * @property double $unit_price
 * @property double $quantity
 * @property double $reorder_level
 * @property string $location
 * @property integer $allow_alt_description
 * @property integer $is_serialized
 * @property string $description
 * @property string $status
 * @property string $created_date
 * @property string $modified_date
 * @property integer $is_expire
 * @property integer $count_interval
 *
 * The followings are the available model relations:
 * @property Inventory[] $inventories
 * @property Category $category
 * @property Supplier $supplier
 * @property Sale[] $sales
 */
class Item extends CActiveRecord
{
    public $inventory;
    public $inv_quantity;
    public $items_add_minus;
    public $inv_comment;
    public $sub_quantity;
    public $unit_id;
    public $image;
    public $promo_price;
    public $promo_start_date;
    public $promo_end_date;
    public $profit_margin;
    public $item_archived;
    public $search;

    /**
     * Returns the static model of the specified AR class.
     * @param string $className active record class name.
     * @return Item the static model class
     */
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /**
     * @return string the associated database table name
     */
    public function tableName()
    {
        return 'item';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules()
    {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('name, cost_price', 'required'),
            array(
                'item_number',
                'unique',
                'message' => '{attribute} {value} already exists or deleted '
                    //'<a class="btn btn-xs btn-info" href="UpdateImage/id/{value}/item_number_flag/1"><span class="glyphicon ace-icon fa fa-edit"></span></a>'
            ),
            array('name', 'unique'),
            array(
                'category_id, author_id, publisher_id,supplier_id, unit_id, currency_code,allow_alt_description, is_serialized, is_expire, count_interval, profit_margin_id',
                'numerical',
                'integerOnly' => true
            ),
            array('cost_price, unit_price, quantity, reorder_level, items_add_minus, promo_price', 'numerical'),
            array('name, isbn', 'length', 'max' => 100),
            array('item_number', 'length', 'max' => 255),
            array('location', 'length', 'max' => 20),
            array('status', 'length', 'max' => 1),
            array('description, inv_comment, promo_end_date, promo_start_date, publish_date', 'safe'),
            array('image', 'file', 'types' => 'jpg, gif, png', 'allowEmpty' => true, 'maxSize' => 5 * 1024 * 1024),
            array('item_number', 'default', 'setOnEmpty' => true, 'value' => null),
            array(
                'created_date,modified_date',
                'default',
                'value' => date('Y-m-d H:i:s'),
                'setOnEmpty' => true,
                'on' => 'insert'
            ),
            array('modified_date', 'default', 'value' => date('Y-m-d H:i:s'), 'setOnEmpty' => false, 'on' => 'update'),
            // The following rule is used by search().
            // Please remove those attributes that should not be searched.
            array(
                'id, author_id,search, isbn,publisher_id, name, item_number,unit_id, category_id, supplier_id, currency_code,cost_price, unit_price, quantity, reorder_level, location, allow_alt_description, is_serialized, description, status, promo_price, is_expore, count_interval, profit_margin, publish_date',
                'safe',
                'on' => 'search'
            ),
        );
    }

    /**
     * @return array relational rules.
     */
    public function relations()
    {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array(
            'inventories' => array(self::HAS_MANY, 'Inventory', 'trans_items'),
            'category' => array(self::BELONGS_TO, 'Category', 'category_id'),
            'supplier' => array(self::BELONGS_TO, 'Supplier', 'supplier_id'),
            'author' => array(self::BELONGS_TO, 'Author', 'author_id'),
            'profit_margin' => array(self::BELONGS_TO, 'ProfitMargin', 'profit_margin_id'),
            'currency' => array(self::BELONGS_TO, 'CurrencyType', 'currency_code'),
            'sales' => array(self::MANY_MANY, 'Sale', 'sale_item(item_id, sale_id)'),
        );
    }

    /**
     * @return array customized attribute labels (name=>label)
     */
    public function attributeLabels()
    {
        return array(
            'id' => 'ID',
            'name' => Yii::t('app', 'Name'),
            'item_number' => Yii::t('app', 'Item Number'),
            'unit_id' => Yii::t('app', 'Unit ID'),
            'category_id' => Yii::t('app', 'Category'),
            'supplier_id' => Yii::t('app', 'Supplier'),
            'currency_code' => Yii::t('app', 'Currency'),
            'cost_price' => Yii::t('app', 'Buy Price'),
            'unit_price' => Yii::t('app', 'Sell Price'),
            'quantity' => Yii::t('app', 'Quantity'),
            'reorder_level' => Yii::t('app', 'Reorder Level'),
            'location' => Yii::t('app', 'Location'),
            'allow_alt_description' => Yii::t('app', 'Alt Description'),
            'is_serialized' => Yii::t('app', 'Is Serialized'),
            'description' => Yii::t('app', 'Description'),
            'status' => Yii::t('app', 'Status'),
            'items_add_minus' => Yii::t('app', 'Item to add/substract'),
            'inv_quantity' => Yii::t('app', 'Inv Quantity'),
            'inv_comment' => Yii::t('app', 'Inv Comment'),
            'inventory' => Yii::t('app', 'Inventory'),
            'sub_quantity' => Yii::t('app', 'Sub Quantity'),
            'promo_price' => Yii::t('app', 'Promo Price'),
            'promo_start_date' => Yii::t('app', 'Promo Start'),
            'promo_end_date' => Yii::t('app', 'Promo End'),
            'is_expire' => Yii::t('app', 'Is Expire ?'),
            'count_interval' => Yii::t('app', 'Count Interval'),
            'profit_margin' => Yii::t('app', 'Profit Margin'),
            'author_id' => Yii::t('app', 'Author / Brand'),
            'currency' => Yii::t('app','Currency'),
        );
    }

    /**
     * Retrieves a list of models based on the current search/filter conditions.
     * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
     */
    public function search()
    {
        // Warning: Please modify the following code to remove attributes that
        // should not be searched.

        $criteria = new CDbCriteria;

        //$criteria->with = array('category');
        //$criteria->with = array('author');
        $criteria->with = array(
            'category' => array('alias'=> 't1', 'together' => true, ),
            'author' => array('alias'=> 't2', 'together' => true, ),
        );

        if  ( Yii::app()->user->getState('archived', Yii::app()->params['defaultArchived'] ) == 'true' ) {
            $criteria->condition = 't.name LIKE :name OR t.item_number LIKE :name';
            $criteria->params = array(
                ':name' => '%' . $this->search . '%',
                ':item_number' => $this->search . '%'
            );
        } else {
            $criteria->condition = 't.status=:active_status AND (t.name LIKE :name OR t.item_number like :name)';
            $criteria->params = array(
                ':active_status' => Yii::app()->params['active_status'],
                ':name' => '%' . $this->search . '%',
                ':item_number' => $this->search . '%'
            );
        }

        $criteria->compare('t.name',$this->name,true);
        $criteria->compare('category_id',$this->category_id);
        $criteria->compare('author_id',$this->author_id);
        $criteria->compare('t.quantity',$this->quantity);
        $criteria->compare('t.location',$this->location,true);


        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
            'pagination' => array(
                'pageSize' => Yii::app()->user->getState('pageSize',Yii::app()->settings->get('item', 'itemNumberPerPage')),
            ),
            'sort' => array('defaultOrder' => 't.modified_date desc')
        ));
    }

    /**
     * Retrieves a list of models based on the current search/filter conditions.
     * @return CActiveDataProvider the data provider that can return the models based on the search/filter conditions.
     */
    public function lowStock()
    {
        // Warning: Please modify the following code to remove attributes that
        // should not be searched.

        $criteria = new CDbCriteria;

        $criteria->compare('id', $this->id);
        $criteria->compare('name', $this->name, true);
        $criteria->compare('item_number', $this->item_number, true);
        $criteria->compare('category_id', $this->category_id);
        $criteria->compare('supplier_id', $this->supplier_id);
        $criteria->compare('location', $this->location, true);
        $criteria->compare('description', $this->description, true);
        //$criteria->compare('status',$this->status);

        $criteria->condition = "quantity<reorder_level and quantity<>0";

        //$criteria->condition="quantity<>0";

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
            'pagination' => false,
            'sort' => array('defaultOrder' => 'name')
        ));
    }

    // Item out of stock or zero stock
    public function outStock()
    {
        // Warning: Please modify the following code to remove attributes that
        // should not be searched.

        $criteria = new CDbCriteria;

        $criteria->compare('id', $this->id);
        $criteria->compare('name', $this->name, true);
        $criteria->compare('item_number', $this->item_number, true);
        $criteria->compare('category_id', $this->category_id);
        $criteria->compare('supplier_id', $this->supplier_id);

        $criteria->condition = "quantity=0";

        return new CActiveDataProvider($this, array(
            'criteria' => $criteria,
            'pagination' => false,
            'sort' => array('defaultOrder' => 'name')
        ));
    }

    /*
     * Look up item(s)
     */
    public static function getItem($name = '')
    {

        // Recommended: Secure Way to Write SQL in Yii
        $sql = 'SELECT id ,concat_ws(" : ",name,unit_price) AS text
                FROM item
                WHERE name LIKE :item_name
                AND status=:status
                UNION ALL
                SELECT id ,concat_ws(" : ",name,unit_price) AS text
                FROM item
                WHERE item_number=:item_number
                AND status=:status';

        $item_name = '%' . $name . '%';
        $item_number = $name;

        return Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':item_name' => $item_name,
                ':item_number' => $item_number,
                ':status' => Yii::app()->params['active_status']
            )
        );
    }

    public function getItemInfo($item_id)
    {
        $model = Item::model()->findByPk($item_id);

        return $model;
    }

    public function costHistory($item_id)
    {
        $sql = "SELECT
                    r.id,
                    r.receive_time,
                    IFNULL((SELECT company_name FROM supplier s WHERE s.id=r.supplier_id),'N/A') supplier_id,
                    r.employee_id,
                    r.remark,
                    ri.cost_price,
                    ri.quantity
                  FROM receiving r INNER JOIN receiving_item ri ON r.id=ri.receive_id
                            AND ri.item_id=:item_id
                  ORDER BY r.receive_time";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':item_id' => $item_id));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'id',
            'pagination' => array(
                'pageSize' => 30,
            ),
        ));

        return $dataProvider; // Return as array object
    }

    public function avgCost($item_id)
    {
        $sql = "SELECT AVG(cost_price) avg_cost FROM receiving_item WHERE item_id=:item_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':item_id' => (int)$item_id));

        foreach ($result as $record) {
            $cost = $record['avg_cost'];
        }

        return $cost;
    }

    public function avgPrice($item_id)
    {
        $sql = "SELECT AVG(new_price) avg_cost FROM item_price WHERE item_id=:item_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':item_id' => (int)$item_id));

        foreach ($result as $record) {
            $cost = $record['avg_cost'];
        }

        return $cost;
    }

    public function getItemPriceTier($item_id, $price_tier_id)
    {
        $sql = "SELECT i.id,i.name,i.item_number,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price
                        ELSE i.unit_price
                    END unit_price,
                    i.description
            FROM item i LEFT JOIN item_price_tier ipt ON ipt.item_id=i.id
                    AND ipt.price_tier_id=:price_tier_id
            WHERE i.id=:item_id
            AND status=:status";

        if (!is_numeric($item_id)) {
            $item_id = 'NULL';
        }

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':item_id' => $item_id,
                ':price_tier_id' => $price_tier_id,
                ':status' => Yii::app()->params['active_status'],
            )
        );

        return $result;
    }

    /* Retail Sale Item Cart */
    public function getItemPriceTierRS($item_id, $price_tier_id)
    {
        $sql = "SELECT i.id,i.name,i.item_number,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price
                        ELSE i.unit_price
                    END unit_price,
                    concat(i.currency_symbol,
                    CASE WHEN ipt.price IS NOT NULL THEN FORMAT(ipt.price,2)
                        ELSE FORMAT(i.unit_price,2)
                    END,' * ',FORMAT(i.to_val,0)) price_verify,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price * i.to_val
                        ELSE i.unit_price * i.to_val
                    END price_kh,
                    i.to_val,
                    i.description,i.description,i.currency_code,i.currency_id,i.currency_symbol
                FROM v_item_kh i LEFT JOIN item_price_tier ipt ON ipt.item_id=i.id
                        AND ipt.price_tier_id=:price_tier_id
                WHERE i.id=:item_id
                AND status=:status";

        if (!is_numeric($item_id)) {
            $item_id = 'NULL';
        }

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':item_id' => $item_id,
                ':price_tier_id' => $price_tier_id,
                ':status' => Yii::app()->params['active_status'],
            )
        );

        return $result;
    }

    public function getItemPriceTierItemNumRS($item_id, $price_tier_id)
    {
        $sql = "SELECT i.id,i.name,i.item_number,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price
                        ELSE i.unit_price
                    END unit_price,
                    concat(i.currency_symbol,
                    CASE WHEN ipt.price IS NOT NULL THEN FORMAT(ipt.price,2)
                        ELSE FORMAT(i.unit_price,2)
                    END,' * ',FORMAT(i.to_val,0)) price_verify,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price * i.to_val
                        ELSE i.unit_price * i.to_val
                    END price_kh,
                    i.to_val,
                    i.description,i.description,i.currency_code,i.currency_id,i.currency_symbol
            FROM v_item_kh i LEFT JOIN item_price_tier ipt ON ipt.item_id=i.id
                    AND ipt.price_tier_id=:price_tier_id
            WHERE i.item_number=:item_id
            AND status=:status";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':item_id' => $item_id,
                ':price_tier_id' => $price_tier_id,
                ':status' => Yii::app()->params['active_status'],
            )
        );

        return $result;
    }

    public function getItemPriceTierWS($item_id, $price_tier_id)
    {
        $sql = "SELECT i.id,i.name,i.item_number,i.cost_price,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price
                        ELSE i.unit_price
                    END unit_price,
                    i.description,i.currency_code,i.currency_id,i.currency_symbol,i.is_expire,i.supplier_id
                FROM (
                SELECT i.id,i.name,i.item_number,i.cost_price,i.unit_price,i.description,
                  i.currency_code,c.currency_id,c.currency_symbol,i.is_expire,i.supplier_id
                FROM item i, currency_type c 
                WHERE c.code = i.currency_code
                AND i.status=:status ) i LEFT JOIN item_price_tier ipt ON ipt.item_id=i.id
                    AND ipt.price_tier_id=:price_tier_id
                WHERE i.id=:item_id
                ";

        if (!is_numeric($item_id)) {
            $item_id = 'NULL';
        }

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':item_id' => $item_id,
                ':price_tier_id' => $price_tier_id,
                ':status' => Yii::app()->params['active_status'],
            )
        );

        return $result;
    }

    public function getItemPriceTierItemNumWS($item_id, $price_tier_id)
    {
        $sql = "SELECT i.id,i.name,i.item_number, i.cost_price,
                    CASE WHEN ipt.price IS NOT NULL THEN ipt.price
                        ELSE i.unit_price
                    END unit_price,
                    i.description,i.currency_code,i.currency_id,i.currency_symbol,i.is_expire,i.supplier_id
                FROM (
                SELECT i.id,i.name,i.item_number,i.cost_price,i.unit_price,i.description,
                  i.currency_code,c.currency_id,c.currency_symbol,i.is_expire,i.supplier_id
                FROM item i, currency_type c 
                WHERE c.code = i.currency_code
                AND i.status=:status ) i LEFT JOIN item_price_tier ipt ON ipt.item_id=i.id
                    AND ipt.price_tier_id=:price_tier_id
                WHERE i.item_number=:item_id
                ";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':item_id' => $item_id,
                ':price_tier_id' => $price_tier_id,
                ':status' => Yii::app()->params['active_status'],
            )
        );

        return $result;
    }

    public function deleteItem($id)
    {
        Item::model()->updateByPk((int)$id, array('status' => Yii::app()->params['inactive_status']));
    }

    public function undodeleteItem($id)
    {
        Item::model()->updateByPk((int)$id, array('status' => Yii::app()->params['active_status']));
    }

    /**
     * Suggests a list of existing values matching the specified keyword.
     * @param string the keyword to be matched
     * @param integer maximum number of names to be returned
     * @return array list of matching lastnames
     */
    public function suggest($keyword, $limit = 20)
    {
        $models = $this->findAll(array(
            'condition' => '(name LIKE :keyword or item_number=:item_number) and status=:status',
            //'condition' => 'item_number=:item_number and status=:status',
            'order' => 'name',
            'limit' => $limit,
            'params' => array(
                ':keyword' => "%$keyword%",
                ':item_number' => $keyword,
                ':status' => Yii::app()->params['active_status']
            )
        ));

        $suggest = array();
        foreach ($models as $model) {
            $suggest[] = array(
                'label' => $model->name . ' - ' . $model->unit_price,
                'value' => $model->name,
                'id' => $model->id,
                'unit_price' => $model->unit_price,
                'quantity' => $model->quantity,
            );
        }

        return $suggest;
    }

    public function saveStockCount($interval)
    {
        $sql = "SELECT func_stock_count(:interval)";
        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':interval' => $interval,
            )
        );

        return $result;
    }

    public function stockItem($interval)
    {
        $sql1 = "SELECT item_id,name,quantity,null actual_qty,
                    date_format(modified_date,'%d-%m-%Y') count_datetime,
                    date_format(next_count_date,'%d-%m-%Y') next_count_date,upper(concat_ws(' - ',last_name,first_name)) employee
                   FROM item_count_schedule ic ,employee e 
                   WHERE e.id=ic.employee_id
                   AND count_interval=:interval";

        $rawData = Yii::app()->db->createCommand($sql1)->queryAll(true, array(':interval' => $interval));

        return $rawData;
    }

    public function stockItemDash()
    {
        $daily_qty = 0;
        $weekly_qty = 0;
        $biweekly_qty = 0;
        $monthly_qty = 0;
        $all_qty = 0;

        $sql = "SELECT
                        IFNULL(SUM(CASE WHEN count_interval=1 THEN nitem END),0) daily,
                        IFNULL(SUM(CASE WHEN count_interval=7 THEN nitem END),0) weekly,
                        IFNULL(SUM(CASE WHEN count_interval=14 THEN nitem END),0) biweekly,
                        IFNULL(SUM(CASE WHEN count_interval=14 THEN nitem END),0) monthly,
                        IFNULL(SUM(CASE WHEN count_interval=999 THEN nitem END),0) all_qty
                   FROM (
                           SELECT count_interval,COUNT(*) nitem
                           FROM item_count_schedule
                           WHERE DATE(next_count_date) = CURRENT_DATE()
                           GROUP BY count_interval
                           UNION ALL
                           SELECT 999,COUNT(*) nitem
                           FROM item_count_schedule
                           WHERE DATE(next_count_date) = CURRENT_DATE()
                   ) AS t1";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true);

        if ($result) {
            foreach ($result as $record) {
                $daily_qty = $record['daily'];
                $weekly_qty = $record['weekly'];
                $biweekly_qty = $record['biweekly'];
                $monthly_qty = $record['monthly'];
                $all_qty = $record['all_qty'];
            }
        }

        return array($daily_qty, $weekly_qty, $biweekly_qty, $monthly_qty, $all_qty);

    }

    protected function beforeSave()
    {
        //if ($this->publish_date !== '') {
            $this->publish_date = date('Y-m-d', strtotime($this->publish_date));
        //}

        return parent::beforeSave();
    }

    protected function afterFind()
    {

        $this->cost_price = round($this->cost_price, Common::getDecimalPlace());
        $this->unit_price = round($this->unit_price, Common::getDecimalPlace());
        $this->publish_date = date('d/m/Y', strtotime($this->publish_date));

        parent::afterFind(); //To raise the event
    }


}