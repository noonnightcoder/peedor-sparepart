<?php
Class Common 
{
    public static function Discount($discount) {
        if (substr($discount, 0, 1) == '$') {
            $discount_amount = substr($discount, 1);
            $discount_type = '$';
        } else {
            $discount_amount = $discount;
            $discount_type = '%';
        }
        
        return array($discount_amount, $discount_type);
    }
    
    public static function calDiscount($discount,$price,$quantity) {
        if (substr($discount, 0, 1) == '$') {
            $total=round($price * $quantity - substr($discount, 1), Common::getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        } else {
            $total=round($price * $quantity - $price * $quantity * $discount / 100, Common::getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        }
        return $total;
    }

    public static function calTotalAfterDiscount($discount,$price,$qty=1) {
        $total = 0;
        if (substr($discount, 0, 1) == '$') {
            $total+=round($price * $qty - substr($discount, 1), Common::getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        } else {
            $total+=round($price * $qty - $price * $qty * $discount / 100, Common::getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        }
        return $total;
    }

    /*
    * To Calculate actual discount amount comparing to Total Value
    */
    public static function calDiscountAmount($discount,$price) {
        //$total = 0;
        if (substr($discount, 0, 1) == '$') {
            $total=round(substr($discount, 1), Common::getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        } else {
            $total=round($price * $discount / 100, Common::getDecimalPlace(), PHP_ROUND_HALF_DOWN);
        }
        return $total;
    }

    public static function arrayFactory($type, $code = null)
    {

        $_items = array(
            'day' => array(
                '01' => '01',
                '02' => '02',
                '03' => '03',
                '04' => '04',
                '05' => '05',
                '06' => '06',
                '07' => '07',
                '08' => '08',
                '09' => '09',
                '10' => '10',
                '11' => '11',
                '12' => '12',
                '13' => '13',
                '14' => '14',
                '15' => '15',
                '16' => '16',
                '17' => '17',
                '18' => '18',
                '19' => '19',
                '20' => '20',
                '21' => '21',
                '22' => '22',
                '23' => '23',
                '24' => '24',
                '25' => '25',
                '26' => '26',
                '27' => '27',
                '28' => '28',
                '29' => '29',
                '30' => '30',
                '31' => '31',
            ),
            'month' => array(
                '01' => Yii::t('app','January'),
                '02' => Yii::t('app','February'),
                '03' => Yii::t('app','March'),
                '04' => Yii::t('app','April'),
                '05' => Yii::t('app','May'),
                '06' => Yii::t('app','June'),
                '07' => Yii::t('app','July'),
                '08' => Yii::t('app','August'),
                '09' => Yii::t('app','September'),
                '10' => Yii::t('app','October'),
                '11' => Yii::t('app','November'),
                '12' => Yii::t('app','December'),
            ),
            'year' => array_combine(range(date("Y"), 1910), range(date("Y"), 1910)),  //http://stackoverflow.com/questions/2807394/php-years-array
            'page_size' => array(
                10 => 10,
                20 => 20,
                50 => 50,
                100 => 100,
                200 => 200,
                500 => 500,
                1000 => 1000,
            ),
            'auth_item' => array(
                'item' => Yii::t('app', 'Item'),
                'sale' => Yii::t('app', 'Sale'),
                'invoice' => Yii::t('app', 'Invoice'),
                'employee' => Yii::t('app', 'Employee'),
                'client' => Yii::t('app', 'Client'),
                'supplier' => Yii::t('app', 'Supplier'),
                'transaction' => Yii::t('app', 'Transaction'),
                'payment' => Yii::t('app', 'Payment'),
                'report' => Yii::t('app', 'Report'),
                'setting' => Yii::t('app', 'Setting')
            )
        );

        if (isset($code)) {
            return isset($_items[$type][$code]) ? $_items[$type][$code] : false;
        } else {
            return isset($_items[$type]) ? $_items[$type] : false;
        }
    }

    public static function defaultPageSize()
    {
        return Yii::app()->user->getState('pageSize', Yii::app()->settings->get('item', 'itemNumberPerPage'));
    }

    public static function getDecimalPlace()
    {
        return Yii::app()->settings->get('system', 'decimalPlace') == '' ? 2 : Yii::app()->settings->get('system', 'decimalPlace');
    }

    public static function getDecimalPlaceRS()
    {
        return 0;
    }

    public static function getDecimalPlaceQty()
    {
        return 0;
    }

    public static function rielRoundUp($amount)
    {
        return  ceil($amount/100-0.1)*100;
    }

    public static function checkPermission($access_name)
    {
        if (!Yii::app()->user->checkAccess($access_name)) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public static function accessValidation() {
        if (!Yii::app()->request->isPostRequest && !Yii::app()->request->isAjaxRequest ) {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    /**
     * Added on : 13-Mar-2017 13:50
     */
    public static function getCurLocationID()
    {
        return Yii::app()->getsetSession->getLocationId();
    }

    public static function getEmployeeID()
    {
        return Yii::app()->session['employee_id'];
    }

    public static function getUserID()
    {
        return Yii::app()->session['user_id'];
    }

    public static function getSaleType()
    {
        return  Yii::app()->shoppingCart->getSaleType();
    }

    public static function getSaleID()
    {
        return Yii::app()->shoppingCart->getSaleId();
    }

    public static function getCustomerID()
    {
        return Yii::app()->shoppingCart->getCustomerId();
    }

    public static function getPriceTierID()
    {
        return Yii::app()->shoppingCart->getPriceTierId();
    }

    public static function priceTierDisable()
    {
        return Common::getSaleType()=='R'?TRUE:FALSE;
    }

    public static function saleTitle() {
        return Common::getSaleType()=='R'?'Retail':'Whole Sale';
    }

    public static function saleIcon() {
        return Common::getSaleType()=='R'?'fa fa-shopping-basket':'fa fa-cart-plus';
    }

}