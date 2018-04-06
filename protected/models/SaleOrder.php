<?php

/**
 * This is the model class for table "sale_order".
 *
 * The followings are the available columns in table 'sale_order':
 * @property integer $id
 * @property string $sale_time
 * @property integer $client_id
 * @property integer $employee_id
 * @property integer $location_id
 * @property double $sub_total
 * @property string $payment_type
 * @property string $status
 * @property string $remark
 * @property string $discount_amount
 * @property string $discount_type
 * @property integer $giftcard_id
 * @property integer $empty_flag
 */
class SaleOrder extends CActiveRecord
{
    //private $active_status = 1;
    public $search_client;

    /**
     * @return string the associated database table name
     */
    public function tableName()
    {
        return 'sale_order';
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules()
    {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            array('sale_time', 'required'),
            array(
                'client_id, desk_id, zone_id, group_id, employee_id, location_id, giftcard_id, empty_flag',
                'numerical',
                'integerOnly' => true
            ),
            array('sub_total', 'numerical'),
            array('payment_type', 'length', 'max' => 255),
            array('status', 'length', 'max' => 20),
            array('discount_amount', 'length', 'max' => 15),
            array('discount_type', 'length', 'max' => 2),
            array('remark', 'safe'),
            // The following rule is used by search().
            // @todo Please remove those attributes that should not be searched.
            array(
                'id, sale_time, client_id, desk_id, zone_id, group_id, employee_id, location_id, sub_total, payment_type, status, remark, discount_amount, discount_type, giftcard_id, empty_flag',
                'safe',
                'on' => 'search'
            ),
        );
    }

    public function relations()
    {
        // NOTE: you may need to adjust the relation name and the related
        // class name for the relations automatically generated below.
        return array();
    }

    public function attributeLabels()
    {
        return array(
            'id' => 'ID',
            'sale_time' => 'Sale Time',
            'client_id' => 'Client',
            'desk_id' => 'Desk',
            'zone_id' => 'Zone',
            'group_id' => 'Group',
            'employee_id' => 'Employee',
            'location_id' => 'Location',
            'sub_total' => 'Sub Total',
            'payment_type' => 'Payment Type',
            'status' => 'Status',
            'remark' => 'Remark',
            'discount_amount' => 'Discount Amount',
            'discount_type' => 'Discount Type',
            'giftcard_id' => 'Giftcard',
            'empty_flag' => 'Empty Flag',
        );
    }

    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /* change to get OrerInfo below to remove */
    /*
    public function getOrderId()
    {
        $sql = "SELECT sfunc_order_info(:user_id,:location_id,:status) order_info";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':user_id' => Common::getUserID(),
                ':location_id' => Common::getCurLocationID(),
                ':status' => Yii::app()->params['order_status_ongoing']
            )
        );

        foreach ($result as $record) {
            $id = $record['sale_id'];
        }

        return $id;
    }
    */

    public function getOrderInfo()
    {
        $sql = "SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(order_info, ';', 1), ';', -1) sale_id,
                 SUBSTRING_INDEX(SUBSTRING_INDEX(order_info, ';', 2), ';', -1) client_id,
                 SUBSTRING_INDEX(SUBSTRING_INDEX(order_info, ';', 3), ';', -1) location_id,
                 SUBSTRING_INDEX(SUBSTRING_INDEX(order_info, ';', 4), ';', -1) user_id,
                 SUBSTRING_INDEX(SUBSTRING_INDEX(order_info, ';', 5), ';', -1) sale_type
                FROM (
                  SELECT sfunc_order_info(:user_id,:location_id,:status) as order_info
                ) as t1";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':user_id' => Common::getUserID(),
                ':location_id' => Common::getCurLocationID(),
                ':status' => Yii::app()->params['order_status_ongoing']
            )
        );

        $sale_id = NULL;
        $client_id = NULL;
        $location_id = NULL;
        $user_id = NULL;
        $sale_type = NULL;

        foreach ($result as $record) {
            $sale_id = $record['sale_id'];
            $client_id = $record['client_id'];
            $location_id = $record['location_id'];
            $user_id = $record['user_id'];
            $sale_type = $record['sale_type'];
        }

        return array($sale_id, $client_id, $location_id, $user_id,$sale_type);;
    }

    public function getOrderCart()
    {

        $sql = "SELECT item_id,currency_code,currency_symbol,`name`,item_number,quantity,
                 price,price_kh,price_kh price_verify,rate to_val,discount_amount discount,
                 (price*quantity) total,
                 (price_kh*quantity)-IFNULL(discount_amount,0) total_kh,
                 NULL description,sale_type
                FROM v_order_cart
                WHERE user_id=:user_id
                AND location_id=:location_id
                AND `status`=:status
                AND ISNULL(deleted_at)
                AND sale_type=:sale_type
                ORDER BY created_at";

        return Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':user_id' => Common::getUserID(),
                ':location_id' => Common::getCurLocationID(),
                ':status' => Yii::app()->params['order_status_ongoing'],
                ':sale_type' => Common::getSaleType()
            )
        );
    }

    public function getOrderCartById($sale_id,$location_id,$status,$sale_type)
    {

        $sql = "SELECT item_id,currency_code,currency_symbol,`name`,item_number,quantity,
                 price,price_kh,price_kh price_verify,rate to_val,discount_amount discount,
                 (price*quantity) sub_total,(price*quantity)-IFNULL(discount_amount,0)  total,
                 (price_kh*quantity) sub_total_kh,(price_kh*quantity)-IFNULL(discount_amount,0) total_kh,
                 NULL description,sale_type
                FROM v_order_cart
                WHERE sale_id=:sale_id
                AND location_id=:location_id
                and `status`=:status
                AND ISNULL(deleted_at)
                AND sale_type=:sale_type";

        /*
        $sql= "SELECT item_id,currency_code,currency_symbol,`name`,item_number,rate to_val,sale_type,
                 SUM(quantity) quantity,
                 SUM(price) price,
                 SUM(CASE WHEN currency_code=2 THEN price ELSE 0 END) price_khr,
                 SUM(CASE WHEN currency_code=3 THEN price ELSE 0 END) price_thb,
                 SUM(CASE WHEN currency_code=1 THEN price ELSE 0 END) price_usd,
                 SUM(discount_amount) discount,
                 SUM((price*quantity)) total,
                 SUM((price_kh*quantity)) sub_total_kh,
                 SUM((price_kh*quantity)-IFNULL(discount_amount,0)) total_kh
                FROM v_sale_cart
                WHERE sale_id=:sale_id
                AND location_id=:location_id
                AND `status`=:status
                AND ISNULL(deleted_at)
                AND sale_type=:sale_type
                GROUP BY item_id,currency_code,currency_symbol,`name`,item_number,sale_type,rate";
        */

        return Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':sale_id' => $sale_id,
                ':location_id' => $location_id,
                ':status' => $status,
                ':sale_type' => $sale_type
            )
        );
    }

    public function getAllTotal()
    {
        /*$quantity = 0;
        $sub_total = 0;
        $total = 0;
        $discount_amount = 0;*/

        /*$sql="SELECT sale_id,sum(quantity) quantity,
                    SUM(price*quantity) sub_total,
                    SUM(price*quantity) - (SUM(price*quantity)*IFNULL(so.discount_amount,0)/100) total,
                    SUM(price*quantity)*IFNULL(so.discount_amount,0)/100 discount_amount
              FROM v_order_cart oc JOIN sale_order so
                            ON so.id=oc.sale_id 
                            and so.desk_id=oc.desk_id
                            and so.group_id=oc.group_id
                            and so.location_id=oc.location_id
              WHERE so.user_id=:user_id
              AND so.location_id=:location_id
              and so.`status`=:status
              AND ISNULL(oc.deleted_at)
              AND so.sale_type=:sale_type            
              GROUP BY sale_id";*/

        $sql = "SELECT sale_id,currency_code,currency_symbol,
                 SUM(oc.quantity) quantity,
                 SUM(oc.price*oc.quantity) sub_total,
                 SUM(oc.price*oc.quantity) - (SUM(oc.price*oc.quantity)*IFNULL(so.discount_amount,0)/100) total,
                 SUM(oc.price*oc.quantity)*IFNULL(so.discount_amount,0)/100 discount_amount
                FROM v_order_cart oc JOIN sale_order so
                   ON so.id = oc.sale_id 
                    AND so.user_id = oc.user_id
                    AND so.location_id = oc.location_id
                WHERE so.user_id = :user_id
                AND so.location_id = :location_id
                AND so.`status`= :status
                AND ISNULL(oc.deleted_at)
                AND so.sale_type = :sale_type          
                GROUP BY sale_id,currency_code,currency_symbol";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
            ':user_id' => Common::getUserID(),
            ':location_id' => Common::getCurLocationID(),
            ':status' => Yii::app()->params['order_status_ongoing'], // To change to variable
            ':sale_type' => Common::getSaleType()
        ));

        return $result;

        /*
        if ($result) {
            foreach ($result as $record) {
                $quantity = $record['quantity'];
                $sub_total = $record['sub_total'];
                $total = $record['total'];
                $discount_amount = $record['discount_amount'];
            }
        }

        return array($quantity, $sub_total, $total, $discount_amount);
        */
    }

    public function getAllTotalKH()
    {
        /*
        $sql = "SELECT sale_id,
                 SUM(oc.price_kh*oc.quantity) sub_total,
                 SUM(oc.price_kh*oc.quantity) - (SUM(oc.price_kh*oc.quantity)*IFNULL(so.discount_amount,0)/100) total,
                 SUM(oc.price_kh*oc.quantity)*IFNULL(so.discount_amount,0)/100 discount_amount
                FROM v_order_cart oc JOIN sale_order so
                   ON so.id = oc.sale_id 
                    AND so.user_id = oc.user_id
                    AND so.location_id = oc.location_id
                WHERE so.user_id = :user_id
                AND so.location_id = :location_id
                AND so.`status`= :status
                AND ISNULL(oc.deleted_at)
                AND so.sale_type = :sale_type          
                GROUP BY sale_id";
        */

        $sql = "SELECT s.sale_id,s.location_id,s.currency_code,s.currency_symbol,
                SUM(s.sub_total) sub_total,SUM(s.discount_amount) discount_amount,SUM(s.total) total,
                SUM(IFNULL(p.payment_amount,0)) payment_amount,SUM((s.total-IFNULL(p.payment_amount,0))) amount_change,
                p.id payment_id,p.`payment_type`,COUNT(p.`payment_id`) count_payment
                FROM (
                SELECT oc.sale_id,so.location_id,oc.currency_code,oc.currency_symbol,
                      SUM(oc.price_kh*oc.quantity) sub_total,
                      SUM(oc.price_kh*oc.quantity) - (SUM(oc.price_kh*oc.quantity)*IFNULL(so.discount_amount,0)/100) total,
                      SUM(oc.price_kh*oc.quantity) * IFNULL(so.discount_amount,0)/100 discount_amount
                 FROM v_order_cart oc JOIN sale_order so
                    ON so.id = oc.sale_id AND
                    so.user_id = oc.user_id AND
                    so.location_id = oc.location_id
                 WHERE so.user_id = :user_id
                 AND so.location_id = :location_id
                 AND so.`status`= :status
                 AND ISNULL(oc.deleted_at)
                 AND so.sale_type = :sale_type          
                 GROUP BY oc.sale_id,so.location_id,oc.currency_code,oc.currency_symbol
                 ) AS s LEFT JOIN sale_payment p ON 
                   p.`sale_id`=s.sale_id AND
                   p.`location_id`=s.location_id AND
                   ISNULL(p.deleted_at)
                 GROUP BY s.sale_id,s.location_id,p.id,p.`payment_type`,currency_code,currency_symbol";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
            ':user_id' => Common::getUserID(),
            ':location_id' => Common::getCurLocationID(),
            ':status' => Yii::app()->params['order_status_ongoing'], // To change to variable
            ':sale_type' => Common::getSaleType()
        ));

        return $result;

    }

    public function orderAdd($item_id,$quantity,$price, $discount_amount)
    {

        $sql = "SELECT func_order_add(:item_id,:item_number,:quantity,:price_tier_id,:price,:location_id,:client_id,:employee_id,:user_id,:discount_amount,:discount_type,:sale_type) sale_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':item_id' => $item_id,
                ':item_number' => $item_id,
                ':quantity' => $quantity,
                ':price_tier_id' => Common::getPriceTierID(),
                ':price' => $price,
                ':location_id' => Common::getCurLocationID(),
                ':client_id' => Common::getCustomerID(),
                ':employee_id' => Common::getEmployeeID(),
                ':user_id' => Common::getUserID(),
                ':discount_amount' => $discount_amount,
                ':discount_type' => '%',
                ':sale_type' =>  Common::getSaleType()
            )
        );

        foreach ($result as $record) {
            $id = $record['sale_id'];
        }

        return $id;
    }

    public function orderEdit($sale_id, $item_id, $quantity, $price, $discount, $discount_type)
    {
        $sql = "SELECT func_order_edit(:sale_id,:location_id,:item_id,:quantity,:price,:discount,:discount_type,:employee_id,:user_id) result_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':sale_id' => $sale_id,
                ':location_id' => Common::getCurLocationID(),
                ':item_id' => $item_id,
                ':quantity' => $quantity,
                ':price' => $price,
                ':discount' => $discount,
                ':discount_type' => $discount_type,
                ':employee_id' => Common::getEmployeeID(),
                ':user_id' => Common::getUserID()
            )
        );

        foreach ($result as $record) {
            $result_id = $record['result_id'];
        }

        return $result_id;
    }

    public function orderDel($sale_id,$item_id)
    {
        $sql = "SELECT func_order_del(:sale_id,:location_id,:item_id,:employee_id,:user_id) result_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':sale_id' => $sale_id,
                ':location_id' => Common::getCurLocationID(),
                ':item_id' => $item_id,
                ':employee_id' => Common::getEmployeeID(),
                ':user_id' => Common::getUserID()
            )
        );

        foreach ($result as $record) {
            $result_id = $record['result_id'];
        }

        return $result_id;
    }

    public function orderSave($sale_id,$save_status)
    {
        $sql="SELECT func_order_save(:sale_id,:location_id,:client_id,:employee_id,:user_id,:save_status) sale_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':sale_id' => $sale_id,
                ':location_id' => Common::getCurLocationID(),
                ':client_id' => Common::getCustomerID(),
                ':employee_id' => Common::getEmployeeID(),
                ':user_id' => Common::getUserID(),
                ':save_status' => $save_status
            )
        );

        foreach ($result as $record) {
            $sale_id = $record['sale_id'];
        }

        return $sale_id;

    }

    public function orderStatusCH($sale_id,$client_id,$order_status,$order_status_ch)
    {
        $sql="SELECT sfunc_order_status_ch(:sale_id,:location_id,:order_status,:order_status_ch,:cart_status,:client_id,:employee_id,:user_id,:update_timestamp,:del_timestamp) sale_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
                ':sale_id' => $sale_id,
                ':location_id' => Common::getCurLocationID(),
                ':order_status' => $order_status,
                ':order_status_ch' => $order_status_ch,
                ':cart_status' => NULL,
                ':client_id' => $client_id,
                ':employee_id' => Common::getEmployeeID(),
                ':user_id' => Common::getUserID(),
                ':update_timestamp' => NULL,
                ':del_timestamp' => NULL,
            )
        );

        foreach ($result as $record) {
            $sale_id = $record['sale_id'];
        }

        return $sale_id;

    }

    public function orderDiscount($sale_id,$location_id,$discount_amount,$discount_type,$user_id)
    {
        $sql = "SELECT sfunc_order_discount(:sale_id,:location_id,:discount_amount,:discount_type,:user_id) result_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':sale_id' => $sale_id,
                ':location_id' => $location_id,
                ':discount_amount' => $discount_amount,
                ':discount_type' => $discount_type,
                ':user_id' => $user_id
            )
        );

        foreach ($result as $record) {
            $result_id = $record['result_id'];
        }

        return $result_id;
    }

    public function orderUpdatePriceTier($sale_id, $location_id,$price_tier_id,$user_id)
    {
        $sql = "SELECT sfunc_orderitem_upricetier(:sale_id,:location_id,:price_tier_id,:user_id,:cur_timestamp) result_id";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':sale_id' => $sale_id,
                ':location_id' => $location_id,
                ':price_tier_id' => $price_tier_id,
                ':user_id' => $user_id,
                ':cur_timestamp' => date('Y-m-d H:i:s')
            )
        );

        foreach ($result as $record) {
            $result_id = $record['result_id'];
        }

        return $result_id;
    }

    public function newOrdering()
    {
        $sql="SELECT so.desk_id,d.`name` desk_name, concat(hour(so.sale_time), ':',minute(so.sale_time)) sale_time
                FROM sale_order so JOIN desk d ON d.id = so.desk_id
                WHERE so.location_id = :location_id
                AND so.sale_time >= CURDATE()
                AND so.`status`=:status
                AND temp_status <> :str_zero
                AND employee_id <> :employee_id
                ORDER BY so.sale_time desc";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
            ':location_id' => Common::getCurLocationID(),
            ':status' => Yii::app()->params['num_one'],
            ':str_zero' => Yii::app()->params['str_zero'],
            ':employee_id' => Common::getEmployeeID()
        ));

        return $result;
    }

    public function getSaleOrderByDeskId()
    {
        $sale_order = SaleOrder::model()->find('desk_id=:desk_id and group_id=:group_id and location_id=:location_id and status=:status',
            array(
                ':desk_id' => Common::getTableID(),
                ':group_id' => Common::getGroupID(),
                ':location_id' => Common::getCurLocationID(),
                ':status' => Yii::app()->params['num_one']
            ));

        return isset($sale_order) ? $sale_order : null;
    }

    public function getSaleOrderById($sale_id,$location_id)
    {
        $sale_order = SaleOrder::model()->find('id=:sale_id and location_id=:location_id and status=:status',
            array(
                ':sale_id' => $sale_id,
                ':location_id' => $location_id,
                ':status' => Yii::app()->params['num_one']
            ));

        return isset($sale_order) ? $sale_order : null;
    }

    public function updateSaleOrderTempStatus($status)
    {
        $model = $this->getSaleOrderByDeskId();
        if ($model !== null) {
            $model->temp_status = $status;
            $model->save();
        }
    }

    public function getQtyTotal() {

        $sql = "SELECT SUM(oc.quantity) quantity
                FROM v_order_cart oc
                WHERE oc.user_id = :user_id
                AND oc.location_id = :location_id
                AND oc.`status`= :status
                AND ISNULL(oc.deleted_at)
                AND oc.sale_type = :sale_type";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(
            ':user_id' => Common::getUserID(),
            ':location_id' => Common::getCurLocationID(),
            ':status' => '1', // To change to variable
            ':sale_type' => Common::getSaleType()
        ));

        $quantity=0;

        if ($result) {
            foreach ($result as $record) {
                $quantity = $record['quantity'];
            }
        }

        return $quantity;

    }

    public function ListSuspendSale()
    {

        if ($this->search_client !== '') {

            $sql = "SELECT s.id sale_id,s.client_id client_id,
                      (SELECT CONCAT_WS(' ',first_name,last_name) FROM `client` c WHERE c.id=s.client_id) client_name,
                       DATE_FORMAT(s.sale_time,'%d-%m-%Y %H:%i') sale_time,st.items,remark
                    FROM sale_order s INNER JOIN (SELECT si.sale_id, substring_index(group_concat(i.name SEPARATOR ','), ',', 5) items
                                            FROM sale_order_item si INNER JOIN item i ON i.id=si.item_id 
                                            GROUP BY si.sale_id
                                            ) st ON st.sale_id=s.id
                    WHERE status=:status
                    AND sale_type=:sale_type";
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(
                ':status' => Yii::app()->params['order_status_suspend'],
                ':sale_type' => Common::getSaleType()
            ));

        } else {
            $sql = "SELECT sale_id,client_id,client_name,sale_time,items,remark
                    FROM (
                        SELECT s.id sale_id,
                              s.client_id client_id,
                             (SELECT CONCAT_WS(' ',first_name,last_name) FROM `client` c WHERE c.id=s.client_id) client_name,
                             DATE_FORMAT(s.sale_time,'%d-%m-%Y %H:%i') sale_time,st.items,remark
                         FROM sale_order s INNER JOIN (SELECT si.sale_id, GROUP_CONCAT(i.name) items
                                                 FROM sale_order_item si INNER JOIN item i ON i.id=si.item_id 
                                                 GROUP BY si.sale_id
                                                 ) st ON st.sale_id=s.id
                         WHERE status=:status
                         AND sale_type=:sale_type
                    ) as t1
                    WHERE sale_id=:sale_id OR client_id like :client_id";
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(
                ':sale_id' => $this->search_client,
                ':client_id' => '%' . $this->search_client .'%',
                ':status' => Yii::app()->params['order_status_suspend'],
                ':sale_type' => Common::getSaleType()
            ));
        }

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'sale_id',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function getOrderHeader($sale_id,$location_id)
    {
        $sql = "SELECT sale_id,location_id,client_id,user_id,sale_type
                FROM v_sale_invoice
                WHERE sale_id=:sale_id
                AND location_id=:location_id
                ";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true,
            array(
                ':sale_id' => $sale_id,
                ':location_id' => $location_id,
            )
        );

       return $result;
    }

}
