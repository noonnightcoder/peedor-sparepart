<?php

class ReceivingItemController extends Controller
{
    //public $layout='//layouts/column1';

    /**
     * @return array action filters
     */
    public function filters()
    {
        return array(
            'accessControl', // perform access control for CRUD operations
        );
    }

    public function accessRules()
    {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('RemoveSupplier','SetComment', 'DeleteItem',
                                    'Add', 'EditItem', 'EditItemPrice', 'Index',
                                    'IndexPara', 'AddPayment', 'CancelRecv',
                                    'CompleteRecv', 'Complete', 'SuspendSale','SuspendRecv',
                                    'DeletePayment', 'SelectSupplier', 'AddSupplier',
                                    'Receipt', 'SetRecvMode', 'EditReceiving','UnsuspendRecv',
                                    'SetTotalDiscount','Return','ListSuspendedSale'),
                'users' => array('@'),
            ),
            array('allow', // allow admin user to perform 'admin' and 'delete' actions
                'actions' => array('admin', 'delete'),
                'users' => array('admin'),
            ),
            array('deny', // deny all users
                'users' => array('*'),
            ),
        );
    }
    
    public function actionIndex($trans_mode = 'receive') 
    {  
        Yii::app()->receivingCart->setMode($trans_mode);
        
        /* To check on performance issue here */
        if ( Yii::app()->user->checkAccess('transaction.receive') && Yii::app()->receivingCart->getMode()=='receive' )  {
            $this->reload(); 
        } else if (Yii::app()->user->checkAccess('transaction.return') && Yii::app()->receivingCart->getMode()=='return') {
            $this->reload(); 
        } elseif (Yii::app()->user->checkAccess('transaction.adjustin') && Yii::app()->receivingCart->getMode()=='adjustment_in') {
            $this->reload(); 
        } elseif (Yii::app()->user->checkAccess('transaction.adjustout') && Yii::app()->receivingCart->getMode()=='adjustment_out') {
            $this->reload();    
        } elseif (Yii::app()->user->checkAccess('transaction.count') && Yii::app()->receivingCart->getMode()=='physical_count') {
            $this->reload(); 
        }  else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionAdd()
    {   
        //$data=array();
        $item_id = $_POST['ReceivingItem']['item_id'];
        if (Yii::app()->user->checkAccess('transaction.receive') && Yii::app()->receivingCart->getMode()=='receive') {    
            $data['warning']=$this->addItemtoCart($item_id);
        } else if (Yii::app()->user->checkAccess('transaction.return') && Yii::app()->receivingCart->getMode()=='return') {
           $data['warning']=$this->addItemtoCart($item_id);
        } else if (Yii::app()->user->checkAccess('transaction.adjustin') && Yii::app()->receivingCart->getMode()=='adjustment_in') {
           $data['warning']=$this->addItemtoCart($item_id);  
        } else if (Yii::app()->user->checkAccess('transaction.adjustout') && Yii::app()->receivingCart->getMode()=='adjustment_out') {
           $data['warning']=$this->addItemtoCart($item_id);   
        } else if (Yii::app()->user->checkAccess('transaction.count') && Yii::app()->receivingCart->getMode()=='physical_count') {
            $data['warning']=$this->addItemtoCart($item_id);     
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        Yii::app()->user->setFlash('warning', $data['warning']);
        //print_r(Yii::app()->receivingCart->getItem());
        $this->reload($data);
    }

    protected function custAccountInfo($customer_id)
    {
        $model = null;
        if ($customer_id != null) {
            $model = Account::model()->getAccountInfo($customer_id);
        }

        return $model;
    }
    
    protected function addItemtoCart($item_id)
    {
        $msg=null;
        if (!Yii::app()->receivingCart->addItem($item_id)) {
            $msg = 'Unable to add item to receiving';
        } 
        return $msg;
    }

    public function actionIndexPara($item_id)
    {
        if (Yii::app()->user->checkAccess('transaction.receive') && Yii::app()->receivingCart->getMode()=='receive') {
            //$recv_mode = Yii::app()->receivingCart->getMode();
            //$quantity = $recv_mode=="receive" ? 1:1; // Change as immongo we will place minus or plus when saving to database
            Yii::app()->receivingCart->addItem($item_id);
            $this->reload($item_id);
        } else if (Yii::app()->user->checkAccess('transaction.return') && Yii::app()->receivingCart->getMode()=='return') {
            Yii::app()->receivingCart->addItem($item_id);
            $this->reload($item_id);
        } else if (Yii::app()->user->checkAccess('transaction.adjustin') && Yii::app()->receivingCart->getMode()=='adjustment_in') {
            Yii::app()->receivingCart->addItem($item_id);
            $this->reload($item_id);
        } else if (Yii::app()->user->checkAccess('transaction.adjustout') && Yii::app()->receivingCart->getMode()=='adjustment_out') {
            Yii::app()->receivingCart->addItem($item_id);
            $this->reload($item_id);  
        } else if (Yii::app()->user->checkAccess('transaction.count') && Yii::app()->receivingCart->getMode()=='physical_count') { 
            Yii::app()->receivingCart->addItem($item_id);
            $this->reload($item_id);
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }    
    }

    public function actionDeleteItem($receive_id,$item_id)
    {
        if ( Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest ) {
            Yii::app()->receivingCart->deleteItem($receive_id,$item_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        } 
    }

    public function actionEditItem($receive_id,$item_id)
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {

            $data = array();
            $model = new ReceivingItem;

            $quantity = isset($_POST['ReceivingItem']['quantity']) ? $_POST['ReceivingItem']['quantity'] : null;
            $unit_price = isset($_POST['ReceivingItem']['unit_price']) ? $_POST['ReceivingItem']['unit_price'] : null;
            $cost_price = isset($_POST['ReceivingItem']['cost_price']) ? $_POST['ReceivingItem']['cost_price'] : null;
            $discount = isset($_POST['ReceivingItem']['discount']) ? $_POST['ReceivingItem']['discount'] : null;
            $expire_date = isset($_POST['ReceivingItem']['expire_date']) ? $_POST['ReceivingItem']['expire_date'] : null;
            $description = 'test';

            $model->quantity = $quantity;
            $model->unit_price = $unit_price;
            $model->cost_price = $cost_price;
            $model->discount = $discount;
            $model->expire_date = $expire_date;

            if ($model->validate()) {
                Yii::app()->receivingCart->editItem($receive_id,$item_id, $quantity, $discount, $cost_price, $unit_price,
                    $description, $expire_date);
            } else {
                $error = CActiveForm::validate($model);
                $errors = explode(":", $error);
                $data['warning'] = str_replace("}", "", $errors[1]);
                Yii::app()->user->setFlash('danger',$data['warning']);
            }
            $this->reload($data);
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionAddPayment()
    {
        if (Yii::app()->request->isPostRequest) {
            if (Yii::app()->request->isAjaxRequest) {
                $payment_id = $_POST['payment_id'];
                $payment_amount = $_POST['payment_amount'];
                //$this->addPaymentToCart($payment_id, $payment_amount);
                Yii::app()->receivingCart->addPayment($payment_id, $payment_amount);
                $this->reload();
            }
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }    
    }

    public function actionDeletePayment($payment_id)
    {
        if (Yii::app()->request->isPostRequest) {
            Yii::app()->receivingCart->deletePayment($payment_id);
            $this->reload();
        } else
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
    }

    public function actionSelectSupplier()
    {        
         if ( Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest ) {
            $supplier_id = $_POST['ReceivingItem']['supplier_id'];
            Yii::app()->receivingCart->setSupplier($supplier_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionRemoveSupplier()
    {
        if ( Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest ) {
            Yii::app()->receivingCart->removeSupplier();
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionSetComment()
    {
        Yii::app()->receivingCart->setComment($_POST['comment']);
        echo CJSON::encode(array(
            'status' => 'success',
            'div' => "<div class=alert alert-info fade in>Successfully saved ! </div>",
        ));
    }

    public function actionSetTotalDiscount()
    {
        if (Yii::app()->request->isPostRequest) {
            $data = $this->sessionInfo();
            $model = new ReceivingItem;
            $total_discount =$_POST['ReceivingItem']['total_discount'];
            $discount_type = '%'; // To change to support fixed discount $ and %
            $model->total_discount=$total_discount;

            if ($model->validate()) {
                Yii::app()->receivingCart->setTotalDiscount($data['receive_id'],$total_discount,$discount_type,$data['user_id']);
            } else {
                $error=CActiveForm::validate($model);
                $errors = explode(":", $error);
                $data['warning']=  str_replace("}","",$errors[1]);
            }

            $this->reload($data);
        }
    }

    public function actionSetRecvMode()
    {
        Yii::app()->receivingCart->setMode($_POST['recv_mode']);
        echo CJSON::encode(array(
            'status' => 'success',
            'div' => "<div class=alert alert-info fade in>Successfully saved ! </div>",
        ));
    }

    public function actionCancelRecv($receive_id='')
    {
        if($receive_id!='')
        {
            $receive_id=$receive_id;
        }else{
            $items = Yii::app()->receivingCart->getCart();
            foreach ($items as $item)
                $receive_id= $item['receive_id'];
        };

        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->receivingCart->cancelItem($receive_id,Yii::app()->params['order_status_suspend'],Yii::app()->params['order_status_ongoing']);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionCompleteRecv($receive_id = '',$trans_mode='',$save_status='')
    {
        $data = $this->sessionInfo();
        if (!isset($data['supplier_id']) && $data['trans_mode']!='physical_count') {
            Yii::app()->user->setFlash('warning',Yii::t('app','Please select supplier...!'));
            $this->redirect(array('receivingItem/index', 'trans_mode' => $data['trans_mode']));
        }else{
            if (empty($data['items'])) {
                $this->redirect(array('receivingItem/index'));
            } else {
                //Save transaction to db
                $data['receiving_id'] = Receiving::model()->completedSave($receive_id,$trans_mode,$save_status);

                if (substr($data['receiving_id'], 0, 2) == '-1') {
                    $data['warning'] = $data['receiving_id'];
                } else {
                    $trans_mode = Yii::app()->receivingCart->getMode();
                    Yii::app()->receivingCart->clearAll();
                    $this->redirect(array('receivingItem/index', 'trans_mode' => $data['trans_mode']));
                }
            }
        }
        //$this->reload();
    }

    public function actionSuspendRecv()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $data = $this->sessionInfo();

            $items = Yii::app()->receivingCart->getCart();
            if (!empty($items)) {
                foreach ($items as $item)
                    $receive_id = $item['receive_id'];

                $save_status = 2;
                $trans_mode = $data['trans_mode'];

                //Save transaction to db
                $data['receiving_id'] = Receiving::model()->completedSave($receive_id, $trans_mode, $save_status);
            }
        }
    }

    public function actionListSuspendedSale()
    {
        $model = new Receiving;

        $model->search_client = isset($_GET['SaleOrder']['search_client']) ? $_GET['SaleOrder']['search_client'] : '';

        if (Yii::app()->request->isAjaxRequest && !isset($_GET['ajax']) ) {
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            Yii::app()->clientScript->scriptMap['*.js'] = false;

            $this->renderPartial('suspend/partial/suspend_sale', array('model' => $model));
        } else {
            $this->render('suspend/index', array('model' => $model));
        }
    }

    public function actionUnsuspendRecv($receive_id)
    {
        Yii::app()->shoppingCart->clearAll();
        //$this->changeOrderStatus($receive_id,$client_id,Yii::app()->params['order_status_suspend'],Yii::app()->params['order_status_ongoing']);
        Receiving::model()->cancelItem($receive_id,Yii::app()->params['order_status_ongoing'],Yii::app()->params['order_status_suspend']);
        $this->reload();

    }

    public function actionEditReceiving($receiving_id)
    {
        if(Yii::app()->request->isPostRequest)
        {
            Yii::app()->receivingCart->clearAll();
            Yii::app()->receivingCart->copyEntireReceiving($receiving_id);
            Receiving::model()->deleteReceiving($receiving_id);
            //$this->reload();
            $this->redirect('index');
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
        
    }

    private function reload($data = array())
    {
        $this->layout = '//layouts/column_sale';

        $model = new ReceivingItem;
        $data['model'] = $model;
        $data = $this->sessionInfo($data);

        //echo $data['trans_header']; die();
        //$data['n_item_expire']=ItemExpire::model()->count('item_id=:item_id and quantity>0',array('item_id'=>(int)$item_id));

        $model->comment = $data['comment'];
        $model->total_discount = $data['total_discount'];

        if ($data['supplier_id'] != null) {
            $supplier = Supplier::model()->findbyPk($data['supplier_id']);
            $data['supplier'] = $supplier;
            //$data['company_name'] = $supplier->company_name;
            //$data['full_name'] = $supplier->first_name . ' ' . $supplier->last_name;
            //$data['mobile_no'] = $supplier->mobile_no;
        }

        if (Yii::app()->request->isAjaxRequest) {
            $cs = Yii::app()->clientScript;
            $cs->scriptMap = array(
                'jquery.js' => false,
                'bootstrap.js' => false,
                'jquery.min.js' => false,
                'bootstrap.notify.js' => false,
                'bootstrap.bootbox.min.js' => false,
                'bootstrap.min.js' => false,
                'jquery-ui.min.js' => false,
                //'jquery.mask.js' => false,
                'EModalDlg.js' => false,
            );

            Yii::app()->clientScript->scriptMap['jquery-ui.css'] = false;
            Yii::app()->clientScript->scriptMap['box.css'] = false;
            $this->renderPartial('index', $data, false, true);
        } else {
            $this->render('index', $data);
        }
    }

    protected function sessionInfo($data = array())
    {
        $receive_id='';
        $data['items'] = Yii::app()->receivingCart->getCart();
        foreach ($data['items'] as $item) $receive_id= $item['receive_id'];

        $data['supplier'] = null;
        $data['receive_id'] = $receive_id;
        $data['trans_mode'] = Yii::app()->receivingCart->getMode();
        $data['trans_header'] = Receiving::model()->transactionHeader();
        $data['status'] = 'success';

        $data['payments'] = Yii::app()->receivingCart->getPayments();
        $data['payment_total'] = Yii::app()->receivingCart->getPaymentsTotal();
        $data['count_item'] = Yii::app()->receivingCart->getQuantityTotal();
        $data['count_payment'] = count(Yii::app()->receivingCart->getPayments());
        $data['sub_total'] = Yii::app()->receivingCart->getSubTotal();
        $data['total'] = Yii::app()->receivingCart->getTotal();
        $data['amount_due'] = Yii::app()->receivingCart->getAmountDue();
        $data['comment'] = Yii::app()->receivingCart->getComment();
        $data['supplier_id'] = Yii::app()->receivingCart->getSupplier();
        $data['employee_id'] = Common::getEmployeeID();
        $tm_discount=Receiving::model()->findByPk($receive_id);
        $data['total_discount'] = number_format(@$tm_discount->discount_amount,Common::getDecimalPlace(), '.', ',');

        $data['discount_amount']=0;
        $data['total_mc'] = Yii::app()->receivingCart->getTotalMC($receive_id); //get total by currency
        $data['employee_id'] = Common::getEmployeeID();
        $data['user_id'] = Common::getUserID();

        $discount_arr = Common::Discount($data['total_discount']);
        $data['discount_amt'] = $discount_arr[0];
        $data['discount_symbol'] = $discount_arr[1];

        $data['hide_editprice'] = Yii::app()->user->checkAccess('transaction.editprice') ? '' : 'hidden';
        $data['hide_editcost'] = Yii::app()->user->checkAccess('transaction.editcost') ? '' : 'hidden';

        $data['disable_discount'] = Yii::app()->user->checkAccess('sale.discount') ? false : true;

        if (Yii::app()->settings->get('item', 'itemExpireDate') == '1') {
            $data['expiredate_class'] = '';
        } else {
            $data['expiredate_class'] = 'hidden';
        }

        return $data;
    }
}
