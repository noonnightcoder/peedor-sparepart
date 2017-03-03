<?php

if (!defined('YII_PATH'))
    exit('No direct script access allowed');

class WShoppingCart extends CApplicationComponent
{

    //private $quantity;

    private $session;

    //private $decimal_place;

    public function getSession()
    {
        return $this->session;
    }

    public function setSession($value)
    {
        $this->session = $value;
    }

    public function getCart()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_cart'])) {
            $this->setCart(array());
        }
        return $this->session['ws_cart'];
    }

    public function setCart($cart_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_cart'] = $cart_data;
        //$session=Yii::app()->session;
        //$session['cart']=$cart_data;
    }

    public function getCustomer()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_customer'])) {
            $this->setCustomer(null);
        }
        return $this->session['ws_customer'];
    }

    public function setCustomer($customer_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_customer'] = $customer_data;
    }

    public function removeCustomer()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_customer']);
    }

    public function getEmployee()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['employee'])) {
            $this->setEmployee(null);
        }
        return $this->session['employee'];
    }

    public function setEmployee($employee_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['employee'] = $employee_data;
    }

    public function removeEmployee()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['employee']);
    }
    
    public function getSaleTime()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['wh_saletime'])) {
            $this->setEmployee(date('d/m/Y h:i:s a'));
        }
        return $this->session['wh_saletime'];
    }

    public function setSaleTime($saletime_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['wh_saletime'] = $saletime_data;
    }

    public function clearSaleTime()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['wh_saletime']);
    }

    public function getSaleId()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_saleid'])) {
            $this->setSaleId(null);
        }
        return $this->session['ws_saleid'];
    }

    public function setSaleId($saleid_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_saleid'] = $saleid_data;
    }

    public function clearSaleId()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_saleid']);
    }
    
    public function getCurrency()
    {

        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_dcurrency'])) {
            $this->setCurrency(CurrencyType::model()->getDefaultCurr()->code);
        }
        return $this->session['ws_dcurrency'];
    }

    public function setCurrency($data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_dcurrency'] = $data;
    }

    public function clearCurrency()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_dcurrency']);
    }
    
    public function getPriceTier()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_pricetier'])) {
            $this->setPriceTier(1);
        }
        return $this->session['ws_pricetier'];
    }

    public function setPriceTier($pricetier_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_pricetier'] = $pricetier_data;
    }

    public function clearPriceTier()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_pricetier']);
    }

    public function getComment()
    {
        $this->setSession(Yii::app()->session);
        return $this->session['ws_comment'];
    }

    public function setComment($comment)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_comment'] = $comment;
    }

    public function clearComment()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_comment']);
    }
    
    public function getPaymentNote()
    {
        $this->setSession(Yii::app()->session);
        return $this->session['paymentnote'];
    }

    public function setPaymentNote($data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['paymentnote'] = $data;
    }

    public function clearPaymentNote()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['paymentnote']);
    }
    
    public function getTotalDiscount()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_totaldiscount'])) {
            $this->setTotalDiscount(null);
        }
        return $this->session['ws_totaldiscount'];
    }

    public function setTotalDiscount($totaldiscount)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_totaldiscount'] = $totaldiscount;
    }

    public function clearTotalDiscount()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_totaldiscount']);
    }

    public function addItem($item_id, $quantity = 1, $discount = '0', $price = null, $description = null, $expire_date = null)
    {
        $this->setSession(Yii::app()->session);
        //Get all items in the cart so far...
        $items = $this->getCart();

        //$items = Cart::addCart($items,$item_id, $quantity,$discount,$this->getPriceTier(),$price, $cost_price, $unit_price,$description,$expire_date);
        //if (!$items) return false;

        $models = Item::model()->getItemPriceTierWS($item_id, $this->getPriceTier());

        if (empty($models)) {
            $models = Item::model()->getItemPriceTierItemNumWS($item_id, $this->getPriceTier());
            foreach ($models as $model) {
                $item_id=$model["id"];
            }
        }
        
        if (!$models) {
            return false;
        }

        foreach ($models as $model) {
        
            $item_data = array((int)$item_id =>
                array(
                    'item_id' => $model["id"],
                    'currency_code' => $model["currency_code"],
                    'currency_id' => $model["currency_id"],
                    'currency_symbol' => $model["currency_symbol"],
                    'name' => $model["name"],
                    'item_number' => $model["item_number"],
                    'quantity' => $quantity,
                    'price' => $price!= null ? round($price, Common::getDecimalPlace()) : round($model["unit_price"], Common::getDecimalPlace()),
                    'to_val' => 1,
                    'discount' => $discount,
                    'expire_date' => $expire_date,
                    'description' => $description!= null ? $description : $model["description"],
                )
            );
        }

        if (isset($items[$item_id])) {
            $items[$item_id]['quantity']+=$quantity;
        } else {
            $items += $item_data;
        }

        $this->setCart($items);
        return true;
    }

    public function editItem($item_id, $quantity, $discount, $price, $description, $expire_date=null)
    {
        $items = $this->getCart();

        if (isset($items[$item_id])) {
            $items[$item_id]['quantity'] = $quantity !=null ? $quantity : $items[$item_id]['quantity'];
            $items[$item_id]['discount'] = $discount !=null ? $discount : $items[$item_id]['discount'];
            $items[$item_id]['price'] = $price !=null ? round($price, Common::getDecimalPlace()) : $items[$item_id]['price'];
            $items[$item_id]['expire_date'] = $expire_date;
            $items[$item_id]['description'] = $description;
            $this->setCart($items);
        }

        return false;
    }

    public function deleteItem($item_id)
    {
        $items = $this->getCart();
        unset($items[$item_id]);
        $this->setCart($items);
    }

    public function f5ItemPriceTier()
    {
        $this->setSession(Yii::app()->session);
        //Get all items in the cart so far...
        $items = $this->getCart();
        
        foreach ($items as $item) {
            $models = Item::model()->getItemPriceTierWS($item['item_id'], $this->getPriceTier());
            foreach ($models as $model) {
               if (isset($items[$item['item_id']])) {
                    $items[$item['item_id']]['price'] = round($model['unit_price'], Common::getDecimalPlace());
               }
            }
        }    
        
        $this->setCart($items);
        return true;
    }

    public function outofStock($item_id)
    {
        if ( ! is_numeric($item_id)) {
            $item_id = 'NULL';
        }
        
        $item = Item::model()->findbyPk($item_id);

        if (!$item)
            return false;

        $quanity_added = $this->getQuantityAdded($item_id);

        if ($item->quantity - $quanity_added < 0) {
            return true;
        }

        return false;
    }

    protected function getQuantityAdded($item_id)
    {
        $items = $this->getCart();
        $quanity_already_added = 0;
        foreach ($items as $item) {
            if ($item['item_id'] == $item_id) {
                $quanity_already_added+=$item['quantity'];
            }
        }

        return $quanity_already_added;
    }

    protected function emptyCart()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_cart']);
    }
    
     /*
     * To get payment session
     * $return $session['payment']
     */
    public function getPayments()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['ws_payments'])) {
            $this->setPayments(array());
        }
        return $this->session['ws_payments'];
    }

    public function setPayments($payments_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['ws_payments'] = $payments_data;
    }

    /*
     * To add payment to payment session $_SESSION['payment']
     * @param string $payment_id as payment type, float $payment_amount amount of payment 
     */

    public function addPayment($currency_code, $payment_amount)
    {
        $this->setSession(Yii::app()->session);
        $payments = $this->getPayments();
        
        $currency_type = CurrencyType::model()->findByPk($currency_code);
        
        $payment = array($currency_code =>
            array(
                'currency_code' => $currency_code,
                'currency_id' => $currency_type->currency_id,
                'currency_symbol' => $currency_type->currency_symbol,
                'payment_amount' => $payment_amount
            )
        );

        //payment_method already exists, add to payment_amount
        if (isset($payments[$currency_code])) {
            $payments[$currency_code]['payment_amount'] += $payment_amount;
        } else {
            $payments += $payment;
        }

        $this->setPayments($payments);
        return true;
    }

    public function deletePayment($currency_code)
    {
        $payments = $this->getPayments();
        unset($payments[$currency_code]);
        $this->setPayments($payments);
    }

    protected function emptyPayment()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['ws_payments']);
    }

    /*
    public function getSubTotal()
    {
        $subtotal_usd = 0;
        $subtotal_khr = 0;
        $subtotal_thb = 0;
                
        foreach ($this->getCart() as $id => $item) {
            
            if ($item['currency_id'] == 'USD') {
                $subtotal_usd+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
            } elseif ($item['currency_id'] == 'KHR' ) {
                $subtotal_khr+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
            } elseif ($item['currency_id'] == 'THB') {
                $subtotal_thb+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
            }
            
        }
        
        //return round($subtotal, Common::getDecimalPlace());
        return array(round($subtotal_usd, Common::getDecimalPlace()), round($subtotal_khr, Common::getDecimalPlace()), round($subtotal_thb, Common::getDecimalPlace()));
    }
     * 
    */

    public function getTotal()
    {
        $total_usd = 0;
        $total_khr = 0;
        $total_thb = 0;
        
        foreach ($this->getCart() as $item) {
            if ($item['currency_id'] == 'USD') {
                $total_usd+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
            } elseif ($item['currency_id'] == 'KHR' ) {
                $total_khr+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
            } elseif ($item['currency_id'] == 'THB') {
                $total_thb+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
            } 
           
        }

        $total_usd = $total_usd - $total_usd*$this->getTotalDiscount()/100;
        $total_khr = $total_khr - $total_khr*$this->getTotalDiscount()/100;
        $total_thb = $total_thb - $total_thb*$this->getTotalDiscount()/100;
        
        return array(round($total_usd, Common::getDecimalPlace()), round($total_khr, Common::getDecimalPlace()), round($total_thb, Common::getDecimalPlace()));
    }
   
    /*
     * Total Multi Currency Mode
     */
    public function getSubTotalMC()
    {
       $currency_type = CurrencyType::model()->getActiveCurrency();
       $total_data = array();
       $total_mc = array();
        
        foreach ($currency_type as $i=>$currency) {
            $total_=0;
            foreach ($this->getCart() as $item) {
                if ( $item['currency_id'] == $currency->currency_id ) {
                    $total_ += Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
                }
            }

            $total_data= array((int)$currency->code=>
                    array(
                        'currency_code' => $currency->code,
                        'currency_id' => $currency->currency_id,
                        'currency_symbol' => $currency->currency_symbol,
                        'total' => $total_
                    )
            );
            
            $total_mc += $total_data;
             
        }
        
        return $total_mc;
    }
    
    /*
     * Total Multi Currency Mode
     */
    public function getTotalMC()
    {
       $currency_type = CurrencyType::model()->getActiveCurrency();
       $total_data = array();
       $total_mc = array();
        
        foreach ($currency_type as $i=>$currency) {
            $total_=0;
            foreach ($this->getCart() as $item) {
                if ( $item['currency_id'] == $currency->currency_id ) {
                    //$total_ . $currency->currency_id+= Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
                    $total_ += Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
                }
            }
            
            $total_ = $total_ - $total_*$this->getTotalDiscount()/100;
            $total_data= array((int)$currency->code=>
                    array(
                        'currency_code' => $currency->code,
                        'currency_id' => $currency->currency_id,
                        'currency_symbol' => $currency->currency_symbol,
                        'total' => $total_ //. $currency->currency_id,
                    )
            );
            
            $total_mc += $total_data;
             
        }
        
        return $total_mc;
    }
    
    /*
     * TotalDue = Outstanding + Hot Bill
    */
    public function getTotalDue()
    {
        $currency_type = CurrencyType::model()->getActiveCurrency();
        $total_data = array();
        $total_mc = array();
        
        foreach ($currency_type as $i=>$currency) {
            $total_=0;
            foreach ($this->getCart() as $item) {
                if ( $item['currency_id'] == $currency->currency_id ) {
                    $total_ += Common::calDiscount($item['discount'],$item['price'],$item['quantity']);
                }
            }
          
            $account = Account::model()->getAccountByCurType($this->getCustomer(),$currency->code);
           
            if ($account) {
                foreach ($account as $acc) {
                    $total_ = $acc['current_balance'] + $total_;
                }
            }
            
            foreach ($this->getPayments() as $payment) {
                if ( $currency->code == $payment["currency_code"] ) {
                    $total_ = $total_ - $total_*$this->getTotalDiscount()/100 - $payment["payment_amount"];
                }
                
            }
            
            //$total_ = $total_ - $total_*$this->getTotalDiscount()/100;
            $total_data= array((int)$currency->code=>
                    array(
                        'currency_code' => $currency->code,
                        'currency_id' => $currency->currency_id,
                        'currency_symbol' => $currency->currency_symbol,
                        'total' => $total_ //. $currency->currency_id,
                    )
            );
            $total_mc += $total_data;
             
        }
        
        return $total_mc;
    }

    //Alain Multiple Payments
    public function getPaymentsTotal()
    {
        $subtotal = 0;
        foreach ($this->getPayments() as $payments) {
            $subtotal+=$payments['payment_amount'];
        }
        //return number_format((float)$subtotal,2);
        return $subtotal;
    }

    //Alain Multiple Payments
    public function getAmountDue()
    {
        //$amount_due=0;
        $sales_total = $this->getTotal()[1];
        $payment_total = $this->getPaymentsTotal();
        $amount_due = $sales_total - $payment_total;
        return $amount_due;
    }

    //get Total Quatity
    public function getQuantityTotal()
    {
        $qtytotal = 0;
        foreach ($this->getCart() as $line => $item) {
            $qtytotal+=$item['quantity'];
        }
        return $qtytotal;
    }

    public function copyEntireSale($sale_id)
    {
        $this->clearAll();
        $sale = Sale::model()->findbyPk($sale_id);
        $sale_item = SaleItem::model()->getSaleItem($sale_id);
        $payments = SalePayment::model()->getPayment($sale_id);

        foreach ($sale_item as $row) {
            if ($row->discount_type == '$') {
                $discount_amount = $row->discount_type . $row->discount_amount;
            } else {
                $discount_amount = $row->discount_amount;
            }
            $this->addItem($row->item_id, $row->quantity, $discount_amount, $row->price, $row->description);
        }
        foreach ($payments as $row) {
            $this->addPayment($row->payment_type, $row->payment_amount);
        }

        $this->setCustomer($sale->client_id);
        $this->setComment($sale->remark);
        $this->setSaleId($sale_id);
        $this->setEmployee($sale->employee_id);
        $this->setSaleTime($sale->sale_time);
        $this->setTotalDiscount($sale->discount_amount);
    }

    public function copyEntireSuspendSale($sale_id)
    {
        $this->clearAll();
        $sale = Sale::model()->findbyPk($sale_id);
        $sale_item = SaleItem::model()->getSaleItem($sale_id);
        $payments = SalePayment::model()->getPayment($sale_id);

        foreach ($sale_item as $row) {
            if ($row->discount_type == '$') {
                $discount_amount = $row->discount_type . $row->discount_amount;
            } else {
                $discount_amount = $row->discount_amount;
            }

            $this->addItem($row->item_id, $row->quantity, $discount_amount, $row->price, $row->description);
        }

        foreach ($payments as $row) {
            $this->addPayment($row->payment_type, $row->payment_amount);
        }

        $this->setCustomer($sale->client_id);
        $this->setComment($sale->remark);
        $this->setTotalDiscount($sale->discount_amount);
        $this->setSaleId($sale_id);
    }

    public function saleClientCookie($client_id)
    {
        //$this->clearAll();
        $sale_item = SaleClientCookie::model()->findAll('client_id=:client_id', array(':client_id' => $client_id));

        if (isset($sale_item)) {
            foreach ($sale_item as $row) {
                $this->addItem($row->item_id, $row->quantity, $row->discount_amount, $row->price, $row->description);
            }
        }
    }
    
    public function setDayInterval($data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['dayinterval'] = $data;
    }
    
    public function getDayInterval()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['dayinterval'])) {
            $this->setTotalDiscount(1);
        }
        return $this->session['dayinterval'];
    }
    
    public function clearDayInterval()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['dayinterval']);
    }
    
    public function clearAll()
    {
        $this->emptyCart();
        $this->emptyPayment();
        $this->removeCustomer();
        $this->clearComment();
        $this->clearSaleId();
        $this->clearSaleTime();
        $this->removeEmployee();
        $this->clearPriceTier();
        $this->clearTotalDiscount();
        $this->clearPaymentNote();
        $this->clearCurrency();
    }

}

