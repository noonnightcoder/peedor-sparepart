<?php

/**
 * This is the model class for table "sale".
 *
 * The followings are the available columns in table 'sale':
 * @property integer $id
 * @property string $sale_time
 * @property integer $customer_id
 * @property integer $employee_id
 * @property double $sub_total
 * @property string $payment_type
 * @property string $status
 * @property string $remark
 *
 * The followings are the available model relations:
 * @property SaleItem[] $saleItems
 */
class Report extends CFormModel
{

    public $search;
    public $amount;
    public $quantity;
    public $from_date;
    public $to_date;
    public $sale_id;
    public $search_id;
    public $receive_id;
    public $employee_id;
    
     private $item_active = '1';

    /**
     * Returns the static model of the specified AR class.
     * @param string $className active record class name.
     * @return Sale the static model class
     */
    public static function model($className = __CLASS__)
    {
        return parent::model($className);
    }

    /**
     * @return array validation rules for model attributes.
     */
    public function rules()
    {
        // NOTE: you should only define rules for those attributes that
        // will receive user inputs.
        return array(
            //array('sale_time', 'required'),
            array('client_id, employee_id', 'numerical', 'integerOnly' => true),
            array('sub_total', 'numerical'),
            array('status', 'length', 'max' => 25),
            array('payment_type', 'length', 'max' => 255),
            array('sale_time', 'default', 'value' => new CDbExpression('NOW()'), 'setOnEmpty' => true, 'on' => 'insert'),
            array('remark, sale_time', 'safe'),
            // The following rule is used by search().
            // Please remove those attributes that should not be searched.
            array('id, sale_time, client_id, employee_id, sub_total, payment_type,status, remark', 'safe', 'on' => 'search'),
        );
    }

    public function attributeLabels()
    {
        return array(
            'date' => Yii::t('app', 'date'),
        );
    }

    public function saleInvoice()
    {

        if ($this->search_id !== '') {

            $sql = "SELECT sale_id,sale_time,client_name,employee_name,employee_id,client_id,sum(quantity) quantity,sum(sub_total*rate) sub_total,
                      discount_amount,vat_amount,sum(total*rate) total,sum(paid*rate) paid,sum(balance*rate) balance,status,status_f
                    FROM v_sale_invoice
                    WHERE sale_id=:search_id OR (c_first_name like :first_name OR c_last_name like :last_name OR client_name like :full_name )
                    group by sale_id,sale_time,client_name,employee_name,employee_id,client_id,quantity,discount_amount,vat_amount,status,status_f
                    ORDER By sale_time desc";

            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':search_id' => $this->search_id, ':first_name' => '%' . $this->search_id . '%', ':last_name' => '%' . $this->search_id . '%', ':full_name' => '%' . $this->search_id . '%'));

        } else {

            $sql= "SELECT sale_id,sale_time,client_name,employee_name,employee_id,client_id,
                    sum(quantity) quantity,sum(sub_total*rate) sub_total,
                    sum(discount_amount) discount_amount,sum(vat_amount) vat_amount,sum(total*rate) total,sum(paid*rate) paid,sum(balance*rate) balance,status,status_f
                   FROM v_sale_invoice
                   WHERE sale_time>=str_to_date(:from_date,'%d-%m-%Y')
                   AND sale_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
                   GROUP BY sale_id,sale_time,client_name,employee_name,employee_id,client_id,status,status_f
                   ORDER By sale_time desc";

            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));
        }

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'sale_id',
            'sort' => array(
                'attributes' => array(
                    'sale_id', 'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleInvoiceDetail()
    {
        $sql= "SELECT sale_id,sale_time,client_name,
                CASE
                    WHEN client_name IS NULL THEN 'RETAIL'
                    ELSE 'WHOLESALE' 
                END sale_type,employee_name,quantity,
                CONCAT(currency_symbol,FORMAT(total,2)) total,CONCAT('៛',FORMAT(total*rate,2)) total_in_riel,paid,balance,status_f
                FROM v_sale_invoice t1
                INNER JOIN currency_type t2 ON t1.currency_code=t2.code
                WHERE sale_id=:sale_id";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':sale_id' => $this->sale_id));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'sale_id',
            'sort' => array(
                'attributes' => array(
                    'sale_id', 'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }


    public function receiveInvoice()
    {

        if (isset($this->receive_id)) {
            
            $sql="SELECT s.id,
                    DATE_FORMAT(s.receive_time,'%d-%m-%Y %H-%i') receive_time,
                    SUM(sub_total) sub_total,SUM(quantity) quantity,`status`,remark,
                    (SELECT CONCAT_WS(' ',first_name,last_name) FROM employee e WHERE e.id=s.employee_id) employee_id
               FROM v_receiving s , v_receiving_item_sum si 
               WHERE si.`receive_id`=s.id 
               AND s.id=:receive_id
               GROUP BY s.id,DATE_FORMAT(s.receive_time,'%d-%m-%Y %H-%i'),`status`,remark
               ";
            
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':receive_id' => $this->receive_id));
        } else {
          
            $sql="SELECT s.id,
                    DATE_FORMAT(s.receive_time,'%d-%m-%Y %H-%i') receive_time,
                    SUM(sub_total) sub_total,SUM(quantity) quantity,`status`,remark,
                    (SELECT CONCAT_WS(' ',first_name,last_name) FROM employee e WHERE e.id=s.employee_id) employee_id
               FROM v_receiving s , v_receiving_item_sum si 
               WHERE si.`receive_id`=s.id 
               AND s.receive_time>=str_to_date(:from_date,'%d-%m-%Y') 
               AND s.receive_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
               GROUP BY s.id,DATE_FORMAT(s.receive_time,'%d-%m-%Y %H-%i'),`status`,remark
               ";
            
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));
        }

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'id',
            'sort' => array(
                'attributes' => array(
                    'receive_time', 'sub_total',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleDaily()
    {
        $sql = "SELECT DATE_FORMAT(sale_time,'%d-%m-%Y') date_report,
               SUM(sub_total) sub_total,
               currency_id,
               SUM(discount_amount) discount_amount,
               SUM(vat_amount) vat_amount,
	           SUM(total) total,
	           SUM(quantity) quantity
	           FROM v_sale_invoice t1
	           left join currency_type t2 on t1.currency_code=code
	           WHERE sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y')
               AND sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
               AND t1.status=:status
               GROUP BY date_format(sale_time,'%d-%m-%Y'),currency_id";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=> Yii::app()->params['active_status']));

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'date_report',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleDailyTotals()
    {
        $sub_total=0;
        $discount_amount=0;
        $total=0;
        $quantity=0;
        
        $sql="SELECT SUM(s.sub_total) sub_total,
                      SUM(s.discount_amount) discount_amount,
                      SUM(s.sub_total-s.discount_amount) total,
                      SUM(sm.quantity) quantity
            FROM v_sale s, v_sale_item_sum sm
            WHERE s.id=sm.sale_id 
            AND s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y') 
            AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
            AND s.status=:status
            GROUP BY date_format(s.sale_time,'%d-%m-%Y')";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=>Yii::app()->params['_active_status']));

        foreach ($result as $record) {
            $sub_total = $record['sub_total'];
            $total = $record['total'];
            $discount_amount = $record['discount_amount'];
            $quantity = $record['quantity'];
        }

        return array($quantity,$sub_total,$discount_amount,$total);
    }

    public function saleHourly()
    {
        //echo $this->to_date;
        $sql = "SELECT DATE_FORMAT(s.`sale_time`,'%H') hours,sum(quantity) qty,
                  sum(case 
                    when si.discount_type='%' then (quantity*price-(quantity*price*si.discount_amount)/100) 
                    else (quantity*price)-si.discount_amount
                  end) amount  
                  FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id AND IFNULL(s.status,'1')='1'
                            AND DATE_FORMAT(sale_time,'%d-%m-%Y')=str_to_date(:to_date,'%d-%m-%Y')
                  GROUP BY DATE_FORMAT(s.`sale_time`,'%H')";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':to_date' => $this->to_date));

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'hours',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleHourlyTotalAmount()
    {
        $sql = "SELECT sum(case 
                                when si.discount_type='%' then (quantity*price-(quantity*price*si.discount_amount)/100) 
                                else (quantity*price)-si.discount_amount
                         end) amount
                  FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id AND IFNULL(s.status,'1')='1'
                  AND DATE_FORMAT(sale_time,'%d-%m-%Y')=str_to_date(:to_date,'%d-%m-%Y')
                  ";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':to_date' => $this->to_date));

        foreach ($result as $record) {
            $amount = $record['amount'];
        }

        return $amount;
    }

    public function saleHourlyTotalQty()
    {
        $sql = "SELECT sum(quantity) qty
                FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id  AND IFNULL(s.status,'1')='1'
                AND DATE_FORMAT(sale_time,'%d-%m-%Y')=str_to_date(:to_date,'%d-%m-%Y')";
        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':to_date' => $this->to_date));

        foreach ($result as $record) {
            $qty = $record['qty'];
        }

        return $qty;
    }

    public function saleSummary()
    {
        $sql = "SELECT COUNT(id) no_of_invoice,SUM(sm.quantity) quantity,
                SUM(CASE WHEN sm.currency_code=1 THEN sm.quantity*price ELSE 0 END) sub_total_dolar, 
                SUM(CASE WHEN sm.currency_code=2 THEN sm.quantity*price ELSE 0 END) sub_total_riel, 
                SUM(CASE WHEN sm.currency_code=3 THEN sm.quantity*price ELSE 0 END) sub_total_bath, 
                SUM(s.discount_amount) discount_amount, SUM(sm.quantity*price*rate) total_in_riel 
                FROM v_sale s , v_sale_item_sum sm 
                WHERE s.id=sm.sale_id 
                AND s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y') 
                AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
                AND s.status=:status";
        //echo $sql;
        //echo $this->from_date;
        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=>Yii::app()->params['_active_status']));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'no_of_invoice',
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function itemExpiry($filter)
    {
        $sql = "SELECT name,total_qty,quantity,expire_date,n_month_expire
                FROM v_item_expire
                WHERE n_month_expire <= :month_to_expire
                ORDER BY n_month_expire";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':month_to_expire' => $filter));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'name',
            'sort' => array(
                'attributes' => array(
                    'name',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function topItem()
    {

        $sql = "SELECT  @ROW := @ROW + 1 AS rank,item_name,qty,amount
                FROM (
                SELECT (SELECT NAME FROM item i WHERE i.id=si.item_id) item_name,sum(si.quantity) qty,SUM(price*quantity) amount
                FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id 
                     AND sale_time>=str_to_date(:from_date,'%d-%m-%Y') 
                     AND sale_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
                     AND IFNULL(s.status,'1')='1'
                GROUP BY item_name
                ORDER BY qty DESC LIMIT 5
                ) t1, (SELECT @ROW := 0) r";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'rank',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleWeeklyByCustomer() {
        $sql="SELECT client_name,item_name,
             SUM(CASE WHEN week_no=3 THEN amount END) '1',
             SUM(CASE WHEN week_no=3 THEN amount END) '2',
             SUM(CASE WHEN week_no=3 THEN amount END) '3',
             SUM(CASE WHEN week_no=4 THEN amount END) '4',
             SUM(CASE WHEN week_no=5 THEN amount END) '5',
             SUM(CASE WHEN week_no=6 THEN amount END) '6',
             SUM(CASE WHEN week_no=7 THEN amount END) '7',
             SUM(CASE WHEN week_no=8 THEN amount END) '8',
             SUM(CASE WHEN week_no=9 THEN amount END) '9',
             SUM(CASE WHEN week_no=10 THEN amount END) '10',
             SUM(CASE WHEN week_no=11 THEN amount END) '11',
             SUM(CASE WHEN week_no=12 THEN amount END) '12',
             SUM(CASE WHEN week_no=13 THEN amount END) '13',
             SUM(CASE WHEN week_no=14 THEN amount END) '14',
             SUM(CASE WHEN week_no=15 THEN amount END) '15',
             SUM(CASE WHEN week_no=16 THEN amount END) '16',
             SUM(CASE WHEN week_no=17 THEN amount END) '17',
             SUM(CASE WHEN week_no=18 THEN amount END) '18',
             SUM(CASE WHEN week_no=19 THEN amount END) '19',
             SUM(CASE WHEN week_no=20 THEN amount END) '20',
             SUM(CASE WHEN week_no=21 THEN amount END) '21',
             SUM(CASE WHEN week_no=22 THEN amount END) '22',
             SUM(CASE WHEN week_no=23 THEN amount END) '23',
             SUM(CASE WHEN week_no=24 THEN amount END) '24',
             SUM(CASE WHEN week_no=25 THEN amount END) '25',
             SUM(CASE WHEN week_no=26 THEN amount END) '26',
             SUM(CASE WHEN week_no=27 THEN amount END) '27',
             SUM(CASE WHEN week_no=28 THEN amount END) '28',
             SUM(CASE WHEN week_no=29 THEN amount END) '29',
             SUM(CASE WHEN week_no=30 THEN amount END) '30',
             SUM(CASE WHEN week_no=31 THEN amount END) '31',
             SUM(CASE WHEN week_no=32 THEN amount END) '32',
             SUM(CASE WHEN week_no=33 THEN amount END) '33',
             SUM(CASE WHEN week_no=34 THEN amount END) '34',
             SUM(CASE WHEN week_no=35 THEN amount END) '35',
             SUM(CASE WHEN week_no=36 THEN amount END) '36',
             SUM(CASE WHEN week_no=37 THEN amount END) '37',
             SUM(CASE WHEN week_no=38 THEN amount END) '38',
             SUM(CASE WHEN week_no=39 THEN amount END) '39',
             SUM(CASE WHEN week_no=40 THEN amount END) '40',
             SUM(CASE WHEN week_no=41 THEN amount END) '41',
             SUM(CASE WHEN week_no=42 THEN amount END) '42',
             SUM(CASE WHEN week_no=43 THEN amount END) '43',
             SUM(CASE WHEN week_no=44 THEN amount END) '44',
             SUM(CASE WHEN week_no=45 THEN amount END) '45',
             SUM(CASE WHEN week_no=46 THEN amount END) '46',
             SUM(CASE WHEN week_no=47 THEN amount END) '47',
             SUM(CASE WHEN week_no=48 THEN amount END) '48',
             SUM(CASE WHEN week_no=49 THEN amount END) '49',
             SUM(CASE WHEN week_no=50 THEN amount END) '50',
             SUM(CASE WHEN week_no=51 THEN amount END) '51',
             SUM(CASE WHEN week_no=52 THEN amount END) '52'
        FROM
        (
        SELECT
            CONCAT( c.`first_name`,' ', last_name) client_name,i.`name` item_name,
            WEEK(DATE(s.sale_time)) week_no,
            SUM(si.`quantity`) quantity, TRUNCATE(SUM(si.`quantity`*si.`price`*si.`rate`),2) amount
        FROM v_sale s JOIN sale_item si ON si.`sale_id` = s.id
         JOIN `client` c ON c.`id` = s.`client_id`
           JOIN item i ON i.id = si.`item_id`
        WHERE  s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y')
        AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
        AND s.status=:status
        GROUP BY WEEK(DATE(s.sale_time)),i.`name`,CONCAT( c.`first_name`,' ', last_name)
        ) AS t1
        GROUP BY client_name,item_name WITH ROLLUP";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=>Yii::app()->params['sale_complete_status']));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'item_name',
            /*'sort' => array(
                'attributes' => array(
                    'item_name',
                ),
            ),*/
            'pagination' => false,
        ));

        return $dataProvider;
    }

    public function saleDailyProfit()
    {
        
        $sql ="SELECT date_report,sub_total,profit,format((profit/sub_total)*100,2) margin
              FROM (
                SELECT DATE_FORMAT(s.`sale_time`,'%d-%m-%Y') date_report,
                  SUM(s.sub_total) sub_total,SUM(sm.profit) profit
                FROM v_sale s , v_sale_item_sum sm
                WHERE s.id=sm.sale_id 
                AND s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y') 
                AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
                AND s.status=:status
                GROUP BY DATE_FORMAT(s.`sale_time`,'%d-%m-%Y')
             ) as t";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=>Yii::app()->params['_active_status']));

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'date_report',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleDailyProfitTotals()
    {
        $sub_total = 0;
        $total = 0;
        $profit = 0;
        
        $sql ="SELECT SUM(s.sub_total) sub_total,SUM(s.sub_total-s.discount_amount) total,SUM(sm.profit) profit
               FROM v_sale s , v_sale_item_sum sm
               WHERE s.id=sm.sale_id 
               AND s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y') 
               AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
               AND s.status=:status";
    
        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=>Yii::app()->params['_active_status']));

         foreach ($result as $record) {
            $sub_total = $record['sub_total'];
            $total = $record['total'];
            $profit = $record['profit'];
        }

        return array($sub_total,$total,$profit);
    }

    public function saleMonthlyProfit()
    {
         $sql ="SELECT DATE_FORMAT(s.`sale_time`,'%m-%Y') date_report,
	       SUM(s.sub_total) sub_total,SUM(sm.profit) profit,
               SUM(format((profit/sub_total)*100,2)) margin
            FROM v_sale s , v_sale_item_sum sm
            WHERE s.id=sm.sale_id 
            -- AND s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y') 
            -- AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
            AND s.status=:status
            GROUP BY DATE_FORMAT(s.`sale_time`,'%m-%Y')";
        

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(':status'=>Yii::app()->params['_active_status']));

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'date_report',
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleMonthlyProfitTotals()
    {
        $sql ="SELECT SUM(s.sub_total) sub_total,SUM(s.sub_total-s.discount_amount) total,SUM(sm.profit) profit,SUM(format((profit/sub_total)*100,2))  margin
               FROM v_sale s , v_sale_item_sum sm
               WHERE s.id=sm.sale_id 
               AND s.sale_time>=STR_TO_DATE(:from_date,'%d-%m-%Y') 
               AND s.sale_time<=DATE_ADD(STR_TO_DATE(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
               AND s.status=:status";   

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':status'=>Yii::app()->params['_active_status']));

        foreach ($result as $record) {
            $sub_total = $record['sub_total'];
            $total = $record['total'];
            $profit = $record['profit'];
            $margin = $record['margin'];
        }
        return array($sub_total,$total,$profit, $margin);
    }

    public function payment()
    {

        $sql = "SELECT payment_type,COUNT(*) quantity,SUM(payment_amount) amount
                FROM sale_payment	
                WHERE sale_id IN (SELECT id FROM sale  WHERE sale_time>=str_to_date(:from_date,'%d-%m-%Y')
                AND sale_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY))
                GROUP BY payment_type";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'payment_type',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function paymentTotalAmount()
    {
        $sql = "SELECT SUM(payment_amount) amount
                  FROM sale_payment	
                  WHERE sale_id IN (SELECT id FROM sale  WHERE sale_time>=str_to_date(:from_date,'%d-%m-%Y')
                  AND sale_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY))
                  ";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));

        foreach ($result as $record) {
            $amount = $record['amount'];
        }

        return $amount;
    }

    public function paymentTotalQty()
    {
        $sql = "SELECT COUNT(*) qty
                  FROM sale_payment	
                  WHERE sale_id IN (SELECT id FROM sale  WHERE sale_time>=str_to_date(:from_date,'%d-%m-%Y')
                  AND sale_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY))
                  ";

        $result = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));

        foreach ($result as $record) {
            $qty = $record['qty'];
        }

        return $qty;
    }

    public function topProduct()
    {

        $sql = "SELECT  @ROW := @ROW + 1 AS rank,item_name,qty,amount
                FROM (
                SELECT (SELECT NAME FROM item i WHERE i.id=si.item_id) item_name,sum(si.quantity) qty,SUM(price*quantity) amount
                FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id 
                     AND sale_time>=str_to_date(:from_date,'%d-%m-%Y') 
                     AND sale_time<=date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY)
                     AND IFNULL(s.status,'1')='1'
                GROUP BY item_name
                ORDER BY qty DESC LIMIT 5
                ) t1, (SELECT @ROW := 0) r";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'rank',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function inventory($filter)
    {
        switch ($filter) {
            case 'all':
                $condition = '';
                break;
            case 'low':
                $condition = 'WHERE IFNULL(reorder_level,0)>quantity';
                break;
            case 'outstock':
                $condition = 'WHERE quantity=0';
                break;
            case 'onstock':
                $condition = 'WHERE quantity>0';
                break;
            case 'negative':
                $condition = 'WHERE quantity<0';
                break;
        }

        $sql = "SELECT id,name,
                       (select company_name from supplier s where s.id=i.supplier_id) supplier,
                       unit_price,quantity,cost_price,reorder_level
               FROM item i 
               $condition 
               ORDER BY name";
        
        /*$sql ="SELECT id,name,quantity,cost_price,unit_price,reorder_level,GROUP_CONCAT(DISTINCT t2.company_name) supplier
            FROM item t1 LEFT JOIN (
                    SELECT `supplier_id`,`item_id`,s.`company_name`,s.`first_name`,s.`last_name`
                    FROM (
                    SELECT r.`supplier_id`,ri.`item_id`
                    FROM `receiving` r JOIN `receiving_item` ri ON ri.`receive_id`=r.id
                    WHERE r.`supplier_id` IS NOT NULL ) t1 JOIN supplier s ON s.id=t1.supplier_id
                    ) t2 ON t2.item_id=t1.id
            $condition  
            AND status=:status
            GROUP BY id,NAME,quantity,cost_price,reorder_level";*/

        $sql ="SELECT t1.id,t1.name,t3.name category_name,t1.quantity,t1.cost_price,t1.unit_price,t1.reorder_level,GROUP_CONCAT(DISTINCT t2.company_name) supplier
                   FROM item t1 LEFT JOIN v_item_supplier t2
                        ON t2.item_id=t1.id LEFT JOIN category t3 on t3.id = t1.category_id
                   $condition
                   AND t1.status=:status
                   GROUP BY t1.id,t1.name,t1.quantity,t1.cost_price,t1.unit_price,t1.reorder_level,t3.name";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(':status' => $this->item_active));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'id',
            'sort' => array(
                'attributes' => array(
                    'quantity','name'
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }
    
    public function stockCount($interval)
    {
 
        if ($interval=='all') {
            $sql="SELECT id,`name`,quantity 
                  FROM item
                  WHERE status=:status";
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(':status'=>$this->item_active));
        } else {
            $sql ="SELECT id,`name`,quantity
                   FROM item
                   WHERE count_interval=:interval
                   AND status=:status";
            
            $sql="SELECT i.id,i.`name`,i.quantity,null actual_qty,
                    date_format(ic.modified_date,'%d-%m-%Y') modified_date,
                    date_format(ic.next_count_date,'%d-%m-%Y') next_count_date,
                    upper(concat_ws(' - ',last_name,first_name)) employee
                  FROM item i,item_count_schedule ic,employee e 
                  WHERE i.id=ic.item_id 
                  AND i.status=:status 
                  AND e.id=ic.employee_id
                  AND ic.count_interval=:interval
                  -- AND DATE(ic.next_count_date) = CURRENT_DATE()";
            
            $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(':interval'=>$interval,':status'=>$this->item_active));
        }
        
        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'id',
            'sort' => array(
                'attributes' => array(
                    'quantity',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function dashtopProduct()
    {

        $sql = "SELECT  @ROW := @ROW + 1 AS rank,item_name,qty,amount
                FROM (
                SELECT (SELECT NAME FROM item i WHERE i.id=si.item_id) item_name,SUM(si.quantity) qty,SUM(price*quantity) amount
                FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id 
                     AND sale_time between DATE_FORMAT(NOW() ,'%Y') AND NOW()
                     AND IFNULL(s.status,'1')='1'
                GROUP BY item_name
                ORDER BY qty DESC LIMIT 10
                ) t1, (SELECT @ROW := 0) r";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true);

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'rank',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function dashtopProductbyAmount()
    {

        $sql = "SELECT  @ROW := @ROW + 1 AS rank,item_name,qty,amount
                FROM (
                SELECT (SELECT NAME FROM item i WHERE i.id=si.item_id) item_name,SUM(si.quantity) qty,SUM(price*quantity) amount
                FROM sale_item si INNER JOIN sale s ON s.id=si.sale_id 
                     AND sale_time between DATE_FORMAT(NOW() ,'%Y') AND NOW()
                     AND IFNULL(s.status,'1')='1'
                GROUP BY item_name
                ORDER BY amount DESC LIMIT 10
                ) t1, (SELECT @ROW := 0) r";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true);

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'rank',
            'sort' => array(
                'attributes' => array(
                    'sale_time',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function itemAsset()
    {
        $sql = "SELECT SUM(quantity) total_qty,SUM(cost_price*quantity) total_amount
                  FROM item
                  WHERE quantity>0
                  and status=:status";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true,array(":status"=>$this->item_active));

        $dataProvider = new CArrayDataProvider($rawData, array(
            'keyField' => 'total_qty',
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

    public function saleDailyChart()
    {
        $sql = "SELECT date_format(s.sale_time,'%d/%m%y') date,sum(quantity) quantity,
                   SUM(case when si.discount_type='%' then (quantity*price-(quantity*price*si.discount_amount)/100) 
                                else (quantity*price)-si.discount_amount
                    end) amount
                   FROM sale s INNER JOIN sale_item si ON si.sale_id=s.id 
                   WHERE ( s.sale_time between DATE_FORMAT(NOW() ,'%Y-%m-01') and NOW() )
                   AND IFNULL(s.status,'1')='1'
                   GROUP BY date_format(s.sale_time,'%d/%m/%y')
                   ORDER BY 1";

        return Yii::app()->db->createCommand($sql)->queryAll(true);
    }

    public function saleItemSummary()
    {
        /*$sql="SELECT sm.item_id,MIN(DATE_FORMAT(s.sale_time,'%d-%m-%Y')) from_date, MAX(DATE_FORMAT(s.sale_time,'%d-%m-%Y')) to_date,
		SUM(sm.quantity) quantity,
		case when sm.currency_code=1 then SUM(sm.price*quantity) else 0 end sub_total_dolar,
		case when sm.currency_code=2 then SUM(sm.price*quantity) else 0 end sub_total_riel,
		case when sm.currency_code=3 then SUM(sm.price*quantity) else 0 end sub_total_bath
              FROM v_sale s , sale_item sm
              WHERE s.id=sm.sale_id
              AND s.sale_time>=str_to_date(:from_date,'%d-%m-%Y')  
              AND s.sale_time<date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY) 
              AND s.status=:status
              GROUP BY sm.item_id";*/
        
        $sql="SELECT i.name item_name,CONCAT_WS(' - ', from_date, to_date) date_report,sub_total_dolar,sub_total_riel,sub_total_bath,t1.quantity
            FROM (
            SELECT sm.item_id,MIN(DATE_FORMAT(s.sale_time,'%d-%m-%Y')) from_date, MAX(DATE_FORMAT(s.sale_time,'%d-%m-%Y')) to_date,
            SUM(sm.quantity) quantity,
            sum(case when sm.currency_code=1 then sm.price*quantity else 0 end) sub_total_dolar,
		    sum(case when sm.currency_code=2 then sm.price*quantity else 0 end) sub_total_riel,
		    sum(case when sm.currency_code=3 then sm.price*quantity else 0 end) sub_total_bath
            FROM v_sale s , sale_item sm
            WHERE s.id=sm.sale_id
            AND s.sale_time>=str_to_date(:from_date,'%d-%m-%Y')  
            AND s.sale_time<date_add(str_to_date(:to_date,'%d-%m-%Y'),INTERVAL 1 DAY) 
            AND s.status=:status
            GROUP BY sm.item_id
            ) t1 JOIN item i ON i.id=t1.item_id";

        $rawData = Yii::app()->db->createCommand($sql)->queryAll(true, array(':from_date' => $this->from_date, ':to_date' => $this->to_date,':status'=>Yii::app()->params['sale_complete_status']));

        $dataProvider = new CArrayDataProvider($rawData, array(
            //'id'=>'saleinvoice',
            'keyField' => 'item_name',
            'sort' => array(
                'attributes' => array(
                    'date_report',
                ),
            ),
            'pagination' => false,
        ));

        return $dataProvider; // Return as array object
    }

}
