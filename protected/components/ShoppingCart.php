<?php

if (!defined('YII_PATH'))
    exit('No direct script access allowed');

class ShoppingCart extends CApplicationComponent
{
    private $session;

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
        $cart = SaleOrder::model()->getOrderCart();

        $this->settingOrderInfo();

        return $cart;
    }

    public function setCart($cart_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['cart'] = $cart_data;
    }

    public function getPayments()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['payments'])) {
            $this->setPayments(array());
        }
        return $this->session['payments'];
    }

    public function setPayments($payments_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['payments'] = $payments_data;
    }

    // Change to Common.php
    /*public function getSaleId()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['sale_id'])) {
            $this->setSaleId(null);
        }
        return $this->session['sale_id'];
    }

    public function setSaleId()
    {
        $this->setSession(Yii::app()->session);
        $this->session['sale_id'] = SaleOrder::model()->getOrderId();
    }

    public function clearSaleId()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['sale_id']);
    }*/

    // Move to GetsetSessoin.php to remove after testing done
    /*
    public function getPriceTier()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['pricetier'])) {
            $this->setPriceTier(4); // set default price book as default "General Price"
        }
        return $this->session['pricetier'];
    }

    public function setPriceTier($pricetier_data)
    {
        $this->setSession(Yii::app()->session);
        $this->session['pricetier'] = $pricetier_data;
    }

    public function clearPriceTier()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['pricetier']);
    }
    */

    public function getComment()
    {
        $this->setSession(Yii::app()->session);
        return $this->session['comment'];
    }

    public function setComment($comment)
    {
        $this->setSession(Yii::app()->session);
        $this->session['comment'] = $comment;
    }

    public function clearComment()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['comment']);
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

    public function addItem($item_id, $quantity = 1, $price=NULL, $discount_amount='0')
    {
        return SaleOrder::model()->orderAdd($item_id, $quantity, $price, $discount_amount);
    }

    public function editItem($item_id, $quantity, $price, $discount, $discount_type='%')
    {
        SaleOrder::model()->orderEdit(Common::getSaleID(),$item_id, $quantity, $price, $discount, $discount_type);
    }

    public function deleteItem($item_id)
    {
        SaleOrder::model()->orderDel(Common::getSaleID(),$item_id);
    }

    public function f5ItemPriceTier()
    {
        $this->setSession(Yii::app()->session);
        //Get all items in the cart so far...
        $items = $this->getCart();
        
        foreach ($items as $item) {
            $models = Item::model()->getItemPriceTierRS($item['item_id'], $this->getPriceTier());
            foreach ($models as $model) {
               if (isset($items[$item['item_id']])) {
                    $items[$item['item_id']]['price_kh'] = round($model['price_kh'], Common::getDecimalPlace());
                    $items[$item['item_id']]['price_verify'] = $model['price_verify'];
               }
            }
        }    
        
        $this->setCart($items);
        return true;
    }

    protected function emptyCart()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['cart']);
    }

    public function addPayment($sale_id, $location_id, $currency_code, $payment_id, $payment_type, $payment_amount, $user_id, $note)
    {
        return SalePayment::model()->paymentAdd($sale_id, $location_id, $currency_code, $payment_id, $payment_type, $payment_amount, $user_id, $note);

        /*
         *
        $this->setSession(Yii::app()->session);

        $payments = $this->getPayments();
        $payment = array($payment_id =>
            array(
                'payment_type' => $payment_id,
                'payment_amount' => $payment_amount
            )
        );

        //payment_method already exists, add to payment_amount
        if (isset($payments[$payment_id])) {
            $payments[$payment_id]['payment_amount'] += $payment_amount;
        } else {
            //add to existing array
            $payments += $payment;
        }

        $this->setPayments($payments);
        return true;
        */
    }

    public function deletePayment($payment_id,$user_id)
    {
        return salePayment::model()->paymentDel($payment_id,$user_id);

    }

    protected function emptyPayment()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['payments']);
    }

    public function getSubTotalKH()
    {
        $subtotal = 0;
        $items = $this->getCart();
        foreach ($items as $id => $item) {
            $subtotal+= Common::calDiscount( $item['discount'],$item['price_kh'],$item['quantity']);

        }

        return round(Common::rielRoundUp($subtotal), Common::getDecimalPlace());
    }

    public function getTotalKH()
    {
        $total = 0;
        foreach ($this->getCart() as $item) {
            $total+= Common::calDiscount( $item['discount'],$item['price_kh'],$item['quantity']);

        }

        $total= Common::rielRoundUp($total - $total*$this->getTotalDiscount()/100);

        return round($total, Common::getDecimalPlace());
    }

    public function getSubTotal()
    {
        $subtotal = 0;
        $items = $this->getCart();
        foreach ($items as $id => $item) {
            $subtotal+= Common::calDiscount( $item['discount'],$item['price'],$item['quantity']);
        }
        
        return round($subtotal, Common::getDecimalPlace());
    }

    public function getTotal()
    {
        $total = 0;
        foreach ($this->getCart() as $item) {
            $total+= Common::calDiscount( $item['discount'],$item['price'],$item['quantity']);

        }
        
        $total=$total - $total*$this->getTotalDiscount()/100;

        return round($total, Common::getDecimalPlace());
    }

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
        $amount_due = $this->getTotalKH() - $this->getPaymentsTotal();
        return $amount_due;
    }

    //get Total Quantity
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

        //$this->setCustomer($sale->client_id);
        $this->setComment($sale->remark);
        $this->setSaleId($sale_id);
        //$this->setEmployee($sale->employee_id);
        $this->setSaleTime($sale->sale_time);
        //$this->setTotalDiscount($sale->discount_amount);
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

        //$this->setCustomer($sale->client_id);
        $this->setComment($sale->remark);
        //$this->setTotalDiscount($sale->discount_amount);
        $this->setSaleId($sale_id);
    }

    public function getSaleId()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['sale_id'])) {
            $this->setSaleId(NULL);
        }
        return $this->session['sale_id'];
    }

    public function setSaleId($sale_id)
    {
        $this->setSession(Yii::app()->session);
        $this->session['sale_id'] = $sale_id;
    }

    public function clearSaleId()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['sale_id']);
    }

    public function getSaleType()
    {
        $this->setSession(Yii::app()->session);
        return $this->session['sale_type'];
    }

    public function setSaleType($sale_type)
    {
        $this->setSession(Yii::app()->session);
        $this->session['sale_type'] = $sale_type;
    }

    public function getCustomerId()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['customer_id'])) {
            $this->setCustomerId(NULL);
        }
        return $this->session['customer_id'];
    }

    public function setCustomerId($customer_id)
    {
        $this->setSession(Yii::app()->session);
        $this->session['customer_id'] = $customer_id;
    }

    public function clearCustomerId()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['customer_id']);
    }

    public function getPriceTierId()
    {
        $this->setSession(Yii::app()->session);
        if (!isset($this->session['price_tier_id'])) {
            $this->setPriceTierId($this->defaultPriceTierId());
        }
        return $this->session['price_tier_id'];
    }

    public function setPriceTierId($price_tier_id)
    {
        $this->setSession(Yii::app()->session);
        $this->session['price_tier_id'] = $price_tier_id;
    }

    public function clearPriceTierId()
    {
        $this->setSession(Yii::app()->session);
        unset($this->session['price_tier_id']);
    }

    public function settingSaleSum()
    {
        $all_total = SaleOrder::model()->getAllTotal($this->getTableId(),$this->getGroupId(),Common::getCurLocationID());

        $this->setSaleQty($all_total[0]);
        $this->setSaleSubTotal($all_total[1]);
        $this->setSaleTotal($all_total[2]);
        $this->setSaleDiscount($all_total[3]);
    }

    public function settingOrderInfo()
    {
        $order_infos = SaleOrder::model()->getOrderInfo();
        $this->setSaleId($order_infos[0]);
        $this->setCustomerId($order_infos[1]);
    }

    /*protected function defaultCustomerId()
    {
        return Common::getSaleType()=='R'?1:NULL;
    }*/

    protected function defaultPriceTierId()
    {
        return Common::getSaleType()=='R'?4:1;
    }

    public function clearAll()
    {
        $this->clearCustomerId();
        $this->clearPriceTierId();
        $this->clearSaleId();

        /*
        $this->emptyCart();
        $this->emptyPayment();
       // $this->removeCustomer();
        $this->clearComment();
        $this->clearSaleId();
        $this->clearSaleTime();
        //$this->removeEmployee();
        $this->clearPriceTier();
        //$this->clearTotalDiscount();
        $this->clearPaymentNote();
        */
    }

}
