<?php

/**
 * This is the model class for table "receiving".
 *
 * The followings are the available columns in table 'receiving':
 * @property integer $id
 * @property string $receive_time
 * @property integer $supplier_id
 * @property integer $employee_id
 * @property double $sub_total
 * @property string $payment_type
 * @property string $status
 * @property string $remark
 *
 * The followings are the available model relations:
 * @property Item[] $items
 */
class Receiving extends CActiveRecord
{
	/**
	 * @return string the associated database table name
	 */
    public $currency_id;
	public function tableName()
	{
		return 'receiving';
	}

	/**
	 * @return array validation rules for model attributes.
	 */
	public function rules()
	{
		// NOTE: you should only define rules for those attributes that
		// will receive user inputs.
		return array(
			//array('receive_time', 'required'),
			array('supplier_id, employee_id', 'numerical', 'integerOnly'=>true),
			array('sub_total', 'numerical'),
			array('payment_type', 'length', 'max'=>255),
			array('status', 'length', 'max'=>30),
                        array('receive_time','default','value'=>new CDbExpression('NOW()'),'setOnEmpty'=>true,'on'=>'insert'),
			array('remark', 'safe'),
			// The following rule is used by search().
			// @todo Please remove those attributes that should not be searched.
			array('id, receive_time, supplier_id, employee_id,currency_id, sub_total, payment_type, status, remark', 'safe', 'on'=>'search'),
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
			'items' => array(self::MANY_MANY, 'Item', 'receiving_item(receive_id, item_id)'),
		);
	}

	/**
	 * @return array customized attribute labels (name=>label)
	 */
	public function attributeLabels()
	{
		return array(
			'id' => 'ID',
			'receive_time' => 'Receive Time',
			'supplier_id' => 'Supplier',
			'employee_id' => 'Employee',
			'sub_total' => 'Sub Total',
			'payment_type' => 'Payment Type',
			'status' => 'Status',
			'remark' => 'Remark',
            'currency_id' => 'Currency ID',
		);
	}

	/**
	 * Retrieves a list of models based on the current search/filter conditions.
	 *
	 * Typical usecase:
	 * - Initialize the model fields with values from filter form.
	 * - Execute this method to get CActiveDataProvider instance which will filter
	 * models according to data in model fields.
	 * - Pass data provider to CGridView, CListView or any similar widget.
	 *
	 * @return CActiveDataProvider the data provider that can return the models
	 * based on the search/filter conditions.
	 */
	public function search()
	{
		// @todo Please modify the following code to remove attributes that should not be searched.

		$criteria=new CDbCriteria;

		$criteria->compare('id',$this->id);
		$criteria->compare('receive_time',$this->receive_time,true);
		$criteria->compare('supplier_id',$this->supplier_id);
		$criteria->compare('employee_id',$this->employee_id);
		$criteria->compare('sub_total',$this->sub_total);
		$criteria->compare('payment_type',$this->payment_type,true);
		$criteria->compare('status',$this->status,true);
		$criteria->compare('remark',$this->remark,true);

		return new CActiveDataProvider($this, array(
			'criteria'=>$criteria,
		));
	}

	/**
	 * Returns the static model of the specified AR class.
	 * Please note that you should have this exact method in all your CActiveRecord descendants!
	 * @param string $className active record class name.
	 * @return Receiving the static model class
	 */
	public static function model($className=__CLASS__)
	{
		return parent::model($className);
	}
        
    public function saveRevc($items,$payments,$supplier_id,$employee_id,$trans_mode)
    {
        $message='';
        if(count($items)==0) {
            return '-1';
        }

        if($trans_mode=='physical_count'){
            $supplier_id=0;
        }

        $model=new Receiving;
        $payment_types='';

        foreach($payments as $payment_id=>$payment)
        {
            $payment_types=$payment_types.$payment['payment_type'].': '.$payment['payment_amount'].'<br />';
        }

        $transaction=$model->dbConnection->beginTransaction();
        try
        {
            $model->status=$this->transactionHeader();
            foreach ($items as $line=>$item) {
                $recv_id=$this->SavercTemp($item,$supplier_id,$employee_id,$payment_types,$model->status);
                if (isset($recv_id))
                {
                    $receiving_id=$recv_id;
                    $trans_date=date('Y-m-d H:i:s');
                    $sub_total=$item['cost_price']*$item['quantity'];
                    // Saving & Updating Account and Account Receivable either transaction 'receive' or 'return'
                    $this->saveAccountAR($employee_id, $receiving_id, $supplier_id,$sub_total, $trans_date, $trans_mode,$item['currency_code']);

                    // Saving receiving item to receiving_item table
                    $this->saveReceiveItem($item, $receiving_id, $employee_id,$trans_date,$line);

                    $message=$receiving_id;
                }
            }
            $transaction->commit();
        }catch (Exception $e)
        {
             $transaction->rollback();
             $message = '-1' . $e;
        }

        return $message;

    }

    public function SavercTemp($item,$supplier_id,$employee_id,$payment_types,$status)
    {
        $model = new Receiving;
        $model->receive_time = date('Y-m-d H:i:s');
        $model->supplier_id = $supplier_id;
        $model->employee_id = $employee_id;
        $model->sub_total = $item['cost_price']*$item['quantity'];
        $model->payment_type = $payment_types;
        $model->status=$status;
        //$model->remark = '';
        $model->currency_id = $item['currency_code'];
        $model->save();

        return $model->id;
    }

    // Updating [account_supplier] table & saving to [account_receivable_supplier] only for either 'receiv' or 'return' transaction
    protected function saveAccountAR($employee_id, $receiving_id, $supplier_id, $sub_total,$trans_date,$trans_mode,$currency_code)
    {
        if ($trans_mode=='receive' || $trans_mode=='return') {
            $sub_total = $trans_mode=='receive' ? $sub_total : -$sub_total;
            // Updating current_balance in account table
            $account=$this->updateAccount($supplier_id, $sub_total,$currency_code);
            if ($account) {
                // Saving to Account Receivable (Payment, Sale Transaction ..)
                $trans_code = $this->transactionCode($trans_mode);
                $this->saveAR($account->id, $employee_id, $receiving_id, $sub_total,$trans_date,$trans_code,$currency_code);
            }
        }
    }

    protected function updateAccount($supplier_id,$purchase_amount,$currency_code)
    {
        $account = AccountSupplier::model()->find('supplier_id=:supplier_id and currency_code=:currency_code',
                                                   array(':supplier_id'=>(int)$supplier_id,':currency_code'=>(int)$currency_code));
        if ($account) {
            $account->current_balance=$account->current_balance + $purchase_amount;
            $account->supplier_id=$supplier_id;
            $account->save();
        }
        return $account;
    }

    protected function saveAR($account_id,$employee_id,$receiving_id,$purchase_amount,$trans_date,$trans_code,$currency_code)
    {
        //Saving Receivng AR Transaction
        $account_receivable = new AccountReceivableSupplier;
        $account_receivable->account_id=$account_id;
        $account_receivable->employee_id=$employee_id;
        $account_receivable->trans_id=$receiving_id;
        $account_receivable->trans_amount=$purchase_amount;
        $account_receivable->trans_code=$trans_code;
        $account_receivable->trans_datetime=$trans_date;
        $account_receivable->currency_code=$currency_code;
        $account_receivable->save();

    }

    protected function saveReceiveItem($item,$receiving_id,$employee_id,$trans_date,$line)
    {
        $item_id=$item['item_id'];
        $cost_price=$item['cost_price'];
        $unit_price=$item['unit_price'];
        $quantity=$item['quantity'];
        $remarks=$this->transactionHeader(). ' ' . $receiving_id;

        $cur_item_info= Item::model()->findbyPk($item_id);
        $qty_in_stock=$cur_item_info->quantity;
        $cur_unit_price=$cur_item_info->unit_price;

        $stock_quantity=$this->stockQuantiy($qty_in_stock,$quantity);
        $discount_arr=Common::Discount($item['discount']);
        $discount_amount=$discount_arr[0];
        $discount_type=$discount_arr[1];

        $receiving_item=new ReceivingItem;

        $receiving_item->receive_id=$receiving_id;
        $receiving_item->item_id=$item_id;
        $receiving_item->line=$line;
        $receiving_item->quantity=$quantity;
        $receiving_item->cost_price=$cost_price;
        $receiving_item->unit_price=$cur_item_info->unit_price;
        $receiving_item->price=$unit_price; // Not used for Receiving Module
        $receiving_item->discount_amount=$discount_amount==null ? 0 : $discount_amount;
        $receiving_item->discount_type=$discount_type;

        $receiving_item->save();

        // Updating Price (Cost & Resell) to item table requested by owner
        $this->updateItem($cur_item_info, $cost_price, $unit_price , $stock_quantity[0]);

        // Product Price (retail price) history
        $this->updateItemPrice($item_id,$cur_unit_price,$unit_price,$employee_id,$trans_date);

        //Ramel Inventory Tracking
        $this->saveInventory($item_id,$employee_id,$stock_quantity[1],$trans_date,$remarks,$quantity,$qty_in_stock,$stock_quantity[0]);

        // Save Item Expire for tracking
        if (!empty($item['expire_date'])) {
            $this->saveItemExpire($item['expire_date'],$receiving_id,$item_id,$employee_id,$quantity,$trans_date,$remarks);
        }
    }

    protected function updateItem($cur_item_info,$cost_price,$unit_price,$quantity)
    {
         $cur_item_info->cost_price=$cost_price;
         $cur_item_info->unit_price=$unit_price;
         $cur_item_info->quantity=$quantity;
         $cur_item_info->save();
    }

    protected function updateItemPrice($item_id,$cur_unit_price,$unit_price,$employee_id,$trans_date)
    {
        if ($cur_unit_price <> $unit_price) {
            $item_price = new ItemPrice;
            $item_price->item_id = $item_id;
            $item_price->old_price = $cur_unit_price;
            $item_price->new_price = $unit_price;
            $item_price->employee_id = $employee_id;
            $item_price->modified_date = $trans_date;
            $item_price->save();
        }
    }

    public function saveInventory($item_id,$employee_id,$rev_quantity,$trans_date,$remarks,$trans_qty,$qty_b4_trans,$qty_af_trans)
    {
        $inventory=new Inventory;
        $inventory->trans_items=$item_id;
        $inventory->trans_user=$employee_id;
        $inventory->trans_comment=$remarks;
        $inventory->trans_inventory=$rev_quantity;
        $inventory->trans_date=$trans_date;
        $inventory->trans_qty=$trans_qty;
        $inventory->qty_b4_trans=$qty_b4_trans;
        $inventory->qty_af_trans=$qty_af_trans;
        $inventory->save();
    }

    protected function saveItemExpire($item_expire_date,$receiving_id,$item_id,$employee_id,$quantity,$trans_date,$remarks)
    {
        if (!empty($item_expire_date))
        {
            $item_expire=ItemExpire::model()->find('item_id=:item_id and expire_date=:expire_date',array(':item_id'=>(int)$item_id,':expire_date'=>$item_expire_date));

            if (!$item_expire) {
               $item_expire=new ItemExpire;
               $qty_in_stock=0;
            } else {
               $qty_in_stock=$item_expire->quantity;
            }

            $stock_quantity=$this->stockQuantiy($qty_in_stock,$quantity);

            //Update Item expiry date & quantity
            $item_expire->item_id=$item_id;
            $item_expire->expire_date=$item_expire_date;
            $item_expire->quantity=$stock_quantity[0];
            $item_expire->save();

            $item_expire_dt=new ItemExpireDt;
            $item_expire_dt->item_expire_id=$item_expire->id;
            $item_expire_dt->trans_id=$receiving_id;
            $item_expire_dt->trans_qty=$stock_quantity[0];
            $item_expire_dt->trans_comment=$remarks;
            $item_expire_dt->modified_date=$trans_date;
            $item_expire_dt->employee_id=$employee_id;
            $item_expire_dt->save();
        }
    }

    public function deleteReceiving($receiving_id)
    {
        $model=new Receiving;

        $transaction=$model->dbConnection->beginTransaction();
        try
        {
            $receiving = Receiving::model()->findbyPk($receiving_id);
            $receiving->delete(); // use constraint PK on cascade delete no need to select item & payment table
            $transaction->commit();
        }catch (Exception $e)
        {
            return -1;
            $transaction->rollback();
        }

    }

    public function transactionHeader()
    {
        if (Yii::app()->receivingCart->getMode()==='receive') //+Quantity
        {
            $data['trans_header']='Receive from Supplier';
        } elseif  (Yii::app()->receivingCart->getMode()==='return') //-Quantity
        {
            $data['trans_header']='Return to Supplier';
        } elseif  (Yii::app()->receivingCart->getMode()==='adjustment_in') //+Quantity
        {
            $data['trans_header']='Adjustment In';
        } elseif  (Yii::app()->receivingCart->getMode()==='adjustment_out') // -Quantity
        {
            $data['trans_header']='Adjustment Out';
        }
        elseif  (Yii::app()->receivingCart->getMode()==='physical_count') // Physical count
        {
            $data['trans_header']='Physical Count';
        }
        return $data['trans_header'];
    }

    protected function transactionCode($trans_mode)
    {
        if ($trans_mode == 'receive') {
            $trans_code='CHRECV'; //Charge Receiving
        } else if ($trans_mode == 'return') {
            $trans_code='RERECV'; //Reverse / Debit Receiving
        }

        return $trans_code;
    }

    protected function stockQuantiy($qty_in_stock,$new_quantity)
    {
        if (Yii::app()->receivingCart->getMode()==='receive')
        {
            $quantity=$qty_in_stock+$new_quantity;
            $inv_quantity=$new_quantity;
        } elseif  (Yii::app()->receivingCart->getMode()==='return') //-Quantity
        {
            $quantity=$qty_in_stock-$new_quantity;
            $inv_quantity=-$new_quantity;
        } elseif  (Yii::app()->receivingCart->getMode()==='adjustment_in') //+Quantity
        {
            $quantity=$qty_in_stock+$new_quantity;
            $inv_quantity=$new_quantity;
        } elseif  (Yii::app()->receivingCart->getMode()==='adjustment_out') // -Quantity
        {
            $quantity=$qty_in_stock-$new_quantity;
            $inv_quantity=-$new_quantity;
        } elseif  (Yii::app()->receivingCart->getMode()==='physical_count') // Input Quantity
        {
            $quantity=$new_quantity;
            $inv_quantity=$new_quantity-$qty_in_stock;
        }
        return array($quantity, $inv_quantity);
    }

    //this function may be duplicate with Lux
    public function addItem($item_id,$quantity=1,$price_tier_id = null,$employee_id = null,$user_id = null,$discount_amount=0,$discount_type = null)
    {
        //this is should remove and replace it into the function
        $models = Item::model()->getItemPriceTierWS($item_id, null);
        $trans_mode=Yii::app()->receivingCart->getMode();
        $supplier_id=Yii::app()->receivingCart->getSupplier();
        if (empty($models)) {
            $models = Item::model()->getItemPriceTierItemNumWS($item_id, null);

            foreach ($models as $model) {
                $item_id=$model["id"];
                $item_number=$models['item_number'];
                $cost_price=$models['cost_price'];
                //$supplier_id = $models['supplier_id'];
            }
        }

        $cmd = Yii::app()->db->createCommand("select func_recv_order_add(:item_id,:item_number,:quantity,:price_tier_id,:cost_price,:supplier_id,:employee_id,:user_id,:discount_amount,:discount_type,:trans_mode) from dual");

        $cmd->bindParam(':item_id' , $item_id);
        $cmd->bindParam(':item_number' ,$item_number);
        $cmd->bindParam(':quantity',$quantity);
        $cmd->bindParam(':price_tier_id',$price_tier_id);
        $cmd->bindParam(':cost_price',$cost_price);
        $cmd->bindParam(':supplier_id',$supplier_id);
        $cmd->bindParam(':employee_id',$employee_id);
        $cmd->bindParam(':user_id',$user_id);
        $cmd->bindParam(':discount_amount',$discount_amount);
        $cmd->bindParam(':discount_type',$discount_type);
        $cmd->bindParam(':trans_mode',$trans_mode);
        $results=$cmd->queryAll();

        foreach($results as $result)
            foreach ($result as $k=>$value)

        return $value;
    }

    public function getItem($user_id = null)
    {
        $trans_mode=Yii::app()->receivingCart->getMode();

        $sql="SELECT receive_id,item_id,t2.code,t2.currency_id,t2.currency_symbol,t3.name,t3.item_number,t3.supplier_id,
                round(t1.quantity) quantity,round(t1.cost_price,2) cost_price,t1.unit_price,t1.discount_amount discount,NULL expire_date,t3.description,t3.is_expire
                FROM receiving_item t1
                INNER JOIN receiving t4 ON t1.receive_id=t4.id
                LEFT JOIN currency_type t2 ON t1.currency_code=t2.code
                INNER JOIN item t3 ON t1.item_id=t3.id
                WHERE t4.status='1'
                AND t4.user_id=:user_id
                and t4.trans_mode=:trans_mode
                and t1.deleted_at is null";

        $cmd = Yii::app()->db->createCommand($sql);
        $cmd->bindParam(':user_id' , $user_id);
        $cmd->bindParam(':trans_mode' , $trans_mode);
        return $cmd->queryAll();
    }

    public function editItem($receive_id,$item_id, $quantity = null, $discount = null, $cost_price = null, $unit_price, $description = null, $expire_date = null)
    {
        $user_id=Common::getUserID();
        $employee_id=Common::getEmployeeID();
        $discount_type='';

        $sql="select func_recv_edit(:receive_id,:item_id,:quantity,:cost_price,:discount_amount,:discount_type,:employee_id,:user_id) from dual";
        $cmd = Yii::app()->db->createCommand($sql);

        $cmd->bindParam(':receive_id' , $receive_id);
        $cmd->bindParam(':item_id' , $item_id);
        $cmd->bindParam(':quantity',$quantity);
        $cmd->bindParam(':cost_price',$cost_price);
        $cmd->bindParam(':employee_id',$employee_id);
        $cmd->bindParam(':user_id',$user_id);
        $cmd->bindParam(':discount_amount',$discount);
        $cmd->bindParam(':discount_type',$discount_type);
        $results=$cmd->queryAll();

        foreach($results as $result)
            foreach ($result as $k=>$value)

                return $value;
    }

    public function deleteItem($receive_id,$item_id)
    {
        $user_id=Common::getUserID();
        $employee_id=Common::getEmployeeID();

        $sql="select func_recv_del(:receive_id,:item_id,:employee_id,:user_id) from dual";
        $cmd = Yii::app()->db->createCommand($sql);

        $cmd->bindParam(':receive_id' , $receive_id);
        $cmd->bindParam(':item_id' , $item_id);
        $cmd->bindParam(':employee_id',$employee_id);
        $cmd->bindParam(':user_id',$user_id);

        $results=$cmd->queryAll();

        foreach($results as $result)
            foreach ($result as $k=>$value)

                return $value;
    }

    public function cancelItem($receive_id)
    {
        $receive_status=1;
        $receive_status_ch=2;
        $receive_cart_status='';
        $user_id=Common::getUserID();
        $employee_id=Common::getEmployeeID();
        $cur_timestamp=date('Y-m-d H:i:s');
        $sql="SELECT sfunc_recv_status_ch(:receive_id,:receive_status,:receive_status_ch,:receive_cart_status,:employee_id,:user_id,:cur_timestamp,:cur_timestamp) from dual";

        $cmd = Yii::app()->db->createCommand($sql);

        $cmd->bindParam(':receive_id' , $receive_id);
        $cmd->bindParam(':receive_status' , $receive_status);
        $cmd->bindParam(':receive_status_ch' , $receive_status_ch);
        $cmd->bindParam(':receive_cart_status' , $receive_cart_status);
        $cmd->bindParam(':employee_id',$employee_id);
        $cmd->bindParam(':user_id',$user_id);
        $cmd->bindParam(':cur_timestamp',$cur_timestamp);
        $cmd->bindParam(':cur_timestamp',$cur_timestamp);

        $results=$cmd->queryAll();
        //print_r($results);

        foreach($results as $result)
            foreach ($result as $k=>$value)

                return $value;
    }

    public function completedSave($receive_id,$trans_mode)
    {
        $supplier_id=Yii::app()->receivingCart->getSupplier();
        $user_id=Common::getUserID();
        $employee_id=Common::getEmployeeID();
        $save_status =0;

        $sql="SELECT func_recv_save(:receive_id,:trans_mode,:employee_id,:user_id,:save_status,:supplier_id) from dual";

        $cmd = Yii::app()->db->createCommand($sql);

        $cmd->bindParam(':receive_id' , $receive_id);
        $cmd->bindParam(':trans_mode' , $trans_mode);
        $cmd->bindParam(':employee_id',$employee_id);
        $cmd->bindParam(':user_id',$user_id);
        $cmd->bindParam(':save_status',$save_status);
        $cmd->bindParam(':supplier_id',$supplier_id);

        $results=$cmd->queryAll();

        foreach($results as $result)
            foreach ($result as $k=>$value)

                return $value;
    }
}
