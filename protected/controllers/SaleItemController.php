<?php

class SaleItemController extends Controller
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
            array(
                'allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('view'),
                'users' => array('@'),
            ),
            array(
                'allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array(
                    'Add',
                    'RemoveCustomer',
                    'SetComment',
                    'DeleteItem',
                    'AddItem',
                    'EditItem',
                    'EditItemPrice',
                    'Index',
                    'IndexPara',
                    'AddPayment',
                    'CancelSale',
                    'CompleteSale',
                    'Complete',
                    'SuspendSale',
                    'DeletePayment',
                    'SelectCustomer',
                    'AddCustomer',
                    'Receipt',
                    'UnsuspendSale',
                    'EditSale',
                    'Receipt',
                    'Suspend',
                    'ListSuspendedSale',
                    'SetPriceTier',
                    'SetTotalDiscount',
                    'DeleteSale'
                ),
                'users' => array('@'),
            ),
            array(
                'allow', // allow admin user to perform 'admin' and 'delete' actions
                'actions' => array('admin', 'delete'),
                'users' => array('admin'),
            ),
            array(
                'deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

    public function actionIndex()
    {
        if (Yii::app()->user->checkAccess('sale.edit') || Yii::app()->user->checkAccess('sale.discount') || Yii::app()->user->checkAccess('sale.editprice')) {
            $sale_type = $_GET['sale_type'];
            Yii::app()->shoppingCart->clearAll(); // Clear previously set session move form Retail to Whole Sale
            //$this->setSaleType($sale_type);
            Yii::app()->shoppingCart->setSaleType($sale_type);

            if ($sale_type=='R') {
                Yii::app()->shoppingCart->setPriceTierId(4);
                Yii::app()->shoppingCart->setCustomerId(1);
            }

            /* Set default customer id for first page load
            if (!isset($customer_id) || $customer_id==NULL) {
             $customer_id = $sale_type=='R'?1:NULL;
             Yii::app()->getsetSession->setCustomerId($customer_id);
            }
            */
            // Looking to change this to set in Shop / System Setting hard code for now
            //$price_tier_id = $sale_type=='R'?4:1;
            //Yii::app()->getsetSession->setPriceTierId($price_tier_id);

            $this->reload();
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionAdd()
    {
        Common::checkPermission('sale.edit');

        Common::accessValidation();

        $data = array();
        $item_id = $_POST['SaleItem']['item_id'];

        $result_id = Yii::app()->shoppingCart->addItem($item_id);
        if ($result_id == -1 )  {
            Yii::app()->user->setFlash('warning', Yii::t('app','Product was not found in the system'));
        } elseif ($result_id == -3 )  {
            Yii::app()->user->setFlash('warning', Yii::t('app','Product was not found, price tier not configure properly'));
        }
        
        $this->reload($data);

    }

    public function actionEditItem($item_id)
    {

        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $data = array();
            $model = new SaleItem;
            $quantity = isset($_POST['SaleItem']['quantity']) ? $_POST['SaleItem']['quantity'] : NULL;
            $price = isset($_POST['SaleItem']['price']) ? $_POST['SaleItem']['price'] : NULL;
            $discount = isset($_POST['SaleItem']['discount']) ? $_POST['SaleItem']['discount'] : NULL;
            //$description = 'test';

            $model->quantity = $quantity;
            $model->price = $price;
            $model->discount = $discount;

            if ($model->validate()) {
                Yii::app()->shoppingCart->editItem($item_id, $quantity,$price,$discount);
            } else {
                $error = CActiveForm::validate($model);
                $errors = explode(":", $error);
                //$data['warning']=  str_replace("}","",$errors[1]);
                $data['warning'] = Yii::t('app', 'Input data type is invalid');
            }

            $this->reload($data);
        } else {
            Yii::app()->user->setFlash('danger', "Invalid request. Please do not repeat this request again.");
        }

    }

    public function actionDeleteItem($item_id)
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->shoppingCart->deleteItem($item_id);
            $this->reload();
        } else {
            Yii::app()->user->setFlash('danger', "Invalid request. Please do not repeat this request again.");
        }
    }

    public function actionAddPayment()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $data = $this->sessionInfo();
            $payment_id = 1;//$_POST['payment_id']; // This should be a reference to payment_history table
            $payment_type = 'Cash';
            $payment_amount = trim($_POST['payment_amount']) == "" ? 0 : $_POST['payment_amount'];
            $payment_note = 'Retail ' . $payment_amount;
            //Yii::app()->shoppingCart->setPaymentNote($payment_note);
            Yii::app()->shoppingCart->addPayment($data['sale_id'], $data['location_id'], $data['currency_code'], $payment_id,
                $payment_type, $payment_amount, $data['user_id'], $payment_note);
            $this->reload($data);
        } else {
            //throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
            Yii::app()->user->setFlash('danger', "Invalid request. Please do not repeat this request again.");
        }
    }

    public function actionDeletePayment($payment_id)
    {
        if (Yii::app()->request->isPostRequest) {
            Yii::app()->shoppingCart->deletePayment($payment_id,Common::getUserID());
            $this->reload();
        } else {
            //throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
            Yii::app()->user->setFlash('danger', "Invalid request. Please do not repeat this request again.");
        }
    }

    public function actionSelectCustomer()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $client_id = $_POST['SaleItem']['client_id'];
            $client = Client::model()->findByPk($client_id);
            Yii::app()->shoppingCart->setCustomerId($client_id);
            Yii::app()->shoppingCart->setPriceTierId($client->price_tier_id);
            $this->changeOrderStatus(Common::getSaleID(),$client_id,Yii::app()->params['order_status_ongoing'],Yii::app()->params['order_status_ongoing']);
            //SaleOrder::model()->orderStatusCH($client_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionRemoveCustomer()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->shoppingCart->clearCustomerId();
            //$this->backIndex();
            $this->reload();
        } else {
            Yii::app()->user->setFlash('danger', "Invalid request. Please do not repeat this request again.");
            //throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionSetComment()
    {
        Yii::app()->shoppingCart->setComment($_POST['comment']);
        echo CJSON::encode(array(
            'status' => 'success',
            'div' => "<div class=alert alert-info fade in>Successfully saved ! </div>",
        ));
    }

    public function actionSetTotalDiscount()
    {
        if (Yii::app()->request->isPostRequest) {
            $data = array();
            $model = new SaleItem;
            $total_discount = $_POST['SaleItem']['total_discount'];
            $model->total_discount = $total_discount;

            if ($model->validate()) {
                Yii::app()->shoppingCart->setTotalDiscount($total_discount);
            } else {
                $error = CActiveForm::validate($model);
                $errors = explode(":", $error);
                $data['warning'] = str_replace("}", "", $errors[1]);
            }

            $this->reload($data);
        }
    }

    public function actionSetPriceTier()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $price_tier_id = $_POST['price_tier_id'];
            Yii::app()->shoppingCart->setPriceTierId($price_tier_id);
            //Yii::app()->shoppingCart->f5ItemPriceTier();
            $this->reload();
        } else {
            Yii::app()->user->setFlash('danger', "Invalid request. Please do not repeat this request again.");
        }

    }

    // To remove after verified
    /*public function actionCancelSale()
    {
        if (Yii::app()->request->isAjaxRequest) {
            $this->layout = '//layouts/column_receipt';

            $data = $this->sessionInfo();
            $action_status = $_GET['action_status'];

            if (empty($data['items'])) {
                $this->backIndex();
            }

            $customer = $this->customerInfo($data['customer_id']);
            $data['customer_name'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : 'General';

            if ($data['sale_type']=='W' && $data['customer_id']==-1) {
                Yii::app()->user->setFlash('warning', Yii::t('app',"This is whole sale, please select customer"));
                $this->backIndex();
                $this->reload($data);
            } elseif ($data['amount_change'] > 0 && $customer == null) {
                Yii::app()->user->setFlash('warning', Yii::t('app',"There is due amount, please select customer"));
                $this->reload($data);
            } elseif (substr($data['sale_id'], 0, 2) == '-1') {
                Yii::app()->user->setFlash('warning', $data['sale_id']);
            } else {
                //Save transaction to db
                $data['sale_id']= SaleOrder::model()->orderSave($data['sale_id'],$action_status);
                //$this->render('partial/_receipt', $data);
                Yii::app()->shoppingCart->clearAll();
                $this->backIndex();
            }
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }

    }*/

    public function actionCompleteSale()
    {

        $this->layout = '//layouts/column_receipt';

        $data = $this->sessionInfo();
        $action_status = $_GET['action_status'];

        if (empty($data['items'])) {
            $this->backIndex();
        }

        $customer = $this->customerInfo($data['customer_id']);
        $data['customer_name'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : 'General';

        if ($data['sale_type'] == 'W' && $data['customer_id'] == -1) {
            Yii::app()->user->setFlash('warning', Yii::t('app', "This is whole sale, please select customer"));
            $this->backIndex();
            $this->reload($data);
        } elseif ($data['amount_change'] > 0 && $customer == null) {
            Yii::app()->user->setFlash('warning', Yii::t('app', "There is due amount, please select customer"));
            $this->reload($data);
        } elseif (substr($data['sale_id'], 0, 2) == '-1') {
            Yii::app()->user->setFlash('warning', $data['sale_id']);
        } else {
            //Save transaction to db
            $data['sale_id'] = SaleOrder::model()->orderSave($data['sale_id'], $action_status);
            if ($data['sale_type'] == 'R') {
                //$data = $this->receiptInfo($data['sale_id'],$data['location_id'],$action_status,$data['sale_type']);
                Yii::app()->session->close();
                //Yii::app()->shoppingCart->clearAll();
                //$this->render('receipt/test');
                if ($action_status == '0') {
                $this->actionReceipt($data['sale_id'], $data['location_id'], $action_status, $data['sale_type']);
                } else {
                  $this->backIndex();
                }
            } else {
                Yii::app()->shoppingCart->clearAll();
                $this->backIndex();
            }
        }
    }

    // To remove after verified
    /*public function actionSuspendSale()
    {
        if (Yii::app()->request->isAjaxRequest) {
            $this->layout = '//layouts/column_receipt';

            $data = $this->sessionInfo();

            if (empty($data['items'])) {
                $this->backIndex();
            }

            $customer = $this->customerInfo($data['customer_id']);
            $data['customer_name'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : 'General';

            if ($data['sale_type']=='W' && $data['customer_id']==-1) {
                Yii::app()->user->setFlash('warning', Yii::t('app',"This is whole sale, please select customer"));
                $this->backIndex();
                $this->reload($data);
            } elseif ($data['amount_change'] > 0 && $customer == null) {
                Yii::app()->user->setFlash('warning', Yii::t('app',"There is due amount, please select customer"));
                $this->reload($data);
            } elseif (substr($data['sale_id'], 0, 2) == '-1') {
                Yii::app()->user->setFlash('warning', $data['sale_id']);
            } else {
                //Save transaction to db
                $data['sale_id']= SaleOrder::model()->orderSave($data['sale_id'],Yii::app()->params['order_status_suspend']);
                //$this->render('partial/_receipt', $data);
                Yii::app()->shoppingCart->clearAll();
                $this->backIndex();
            }
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }*/

    public function actionEditSale($sale_id)
    {
        if (Yii::app()->user->checkAccess('invoice.print')) {
            //if(Yii::app()->request->isPostRequest)
            //{
            Yii::app()->shoppingCart->clearAll();
            Yii::app()->shoppingCart->copyEntireSale($sale_id);
            Yii::app()->session->close(); // preventing session clearing due to page redirecting..
            $this->redirect('index');
            //}
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionReceipt($sale_id,$location_id,$status,$sale_type)
    {
        if (Yii::app()->user->checkAccess('invoice.print')) {

            $this->layout = '//layouts/column_receipt';
            $data = $this->receiptInfo($sale_id,$location_id,$status,$sale_type);
            Yii::app()->shoppingCart->clearAll();
            $this->render($data['view_file'], $data);
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

    }

    public function actionListSuspendedSale()
    {
        $model = new SaleOrder;
        $this->render('suspend/index', array('model' => $model));
    }

    public function actionUnsuspendSale($sale_id,$client_id)
    {
        Yii::app()->shoppingCart->clearAll();
        $this->changeOrderStatus($sale_id,$client_id,Yii::app()->params['order_status_suspend'],Yii::app()->params['order_status_ongoing']);
        $this->backIndex();

        //Yii::app()->shoppingCart->copyEntireSuspendSale($sale_id);
        //Sale::model()->saveUnsuspendSale($sale_id); // Roll back stock cut to original stock
        $this->reload();
    }

    public function actionDeleteSale($sale_id)
    {
        $result_id = Sale::model()->deleteSale($sale_id, 'Cancel Suspended Sale',
            Yii::app()->shoppingCart->getEmployee());

        if ($result_id === -1) {
            Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,
                '<strong>Oh snap!</strong> Change a few things up and try submitting again.');
        } else {
            Yii::app()->shoppingCart->clearAll();
            Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,
                '<strong>Well done!</strong> Invoice Id ' . $sale_id . 'have been deleted successfully!');
            $this->redirect('ListSuspendedSale');
        }

    }

    private function reload($data = array())
    {
        $this->layout = '//layouts/column_sale';

        $model = new SaleItem;

        $data = $this->sessionInfo($data);

        $model->comment = $data['comment'];
        $model->total_discount = $data['total_discount'];

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
                //'EModalDlg.js'=>false,
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
        /* Define Default Variables Value */
        $model = new SaleItem;

        $data['model'] = $model;
        $data['status'] = 'success';
        $data['sale_id'] = null;
        $data['time_go'] = '';
        $data['count_item'] = 0;
        $data['sub_total'] = 0;
        $data['total'] = 0;
        $data['sub_total_kh'] = 0;
        $data['total_kh'] = 0;
        $data['discount_amount'] = 0;
        $data['amount_due'] = 0;
        $data['amount_change'] = 0;
        $data['payments'] = array();
        $data['items'] = array();
        $data['account'] = array();
        $data['comment'] = 'Default Comment';
        $data['customer_id'] = NULL;
        $data['customer_name'] = '';
        $data['account_name'] = '';
        $data['sale_type'] = '';
        $data['transaction_date'] = date('d/m/Y');
        $data['transaction_time'] = date('h:i:s');

        $data['location_id'] = Common::getCurLocationID();
        $data['employee_id'] = Common::getEmployeeID();
        $data['user_id'] = Common::getUserID();
        $data['customer_id'] = Common::getCustomerID();
        $data['sale_type'] = Common::getSaleType();

        $data['count_item'] = SaleOrder::model()->getQtyTotal();
        //$data['all_total'] = SaleOrder::model()->getAllTotal();
        $data['total_discount']=0;
        $data['payments'] = Yii::app()->shoppingCart->getPayments();
        $data['count_payment'] = count(Yii::app()->shoppingCart->getPayments());
        $data['currency_code'] = Common::getCurrencyCode();

        // Retrieving actual data from backend
        $data['items'] = Yii::app()->shoppingCart->getCart();
        $data['sale_id'] = Common::getSaleID();
        $data['employee'] = ucwords(Yii::app()->session['emp_fullname']);
        $data['account'] =  $this->custAccountInfo($data['customer_id']);

        // HTML Table Properties
        $data['colspan'] = Yii::app()->settings->get('sale', 'discount') == 'hidden' ? '2' : '3';

        /*
        $data['count_item'] = Yii::app()->shoppingCart->getQuantityTotal();
        $data['payments'] = Yii::app()->shoppingCart->getPayments();
        $data['count_payment'] = count(Yii::app()->shoppingCart->getPayments());
        $data['payment_received'] = Yii::app()->shoppingCart->getPaymentsTotal();
        //$data['sub_total'] = Yii::app()->shoppingCart->getSubTotal();
        //$data['sub_total_kh'] = Yii::app()->shoppingCart->getSubTotalKH();
        $data['total'] = Yii::app()->shoppingCart->getTotal();
        $data['total_kh'] = Yii::app()->shoppingCart->getTotalKH();
        $data['qtytotal'] = Yii::app()->shoppingCart->getQuantityTotal();
        $data['amount_change'] = Yii::app()->shoppingCart->getAmountDue();
        $data['comment'] = Yii::app()->shoppingCart->getComment();

        $data['transaction_date'] = date('d/m/Y');
        $data['transaction_time'] = date('h:i:s');
        //$data['session_sale_id'] = Yii::app()->shoppingCart->getSaleId();
        //$data['total_discount'] = Yii::app()->shoppingCart->getTotalDiscount();

        $data['disable_editprice'] = Yii::app()->user->checkAccess('sale.editprice') ? false : true;
        $data['disable_discount'] = Yii::app()->user->checkAccess('sale.discount') ? false : true;
        $data['colspan'] = Yii::app()->settings->get('sale', 'discount') == 'hidden' ? '2' : '3';

        $data['discount_amount'] = $data['sub_total'] * $data['total_discount'] / 100;

        // Customer Account Info
        $account = $this->custAccountInfo($data['customer_id']);
        $data['cust_fullname'] = $account !== null ? $account->name : '';
        $data['acc_balance'] = $account !== null ? $account->current_balance : '';
        */

        return $data;
    }

    protected function receiptInfo($sale_id,$location_id,$status,$sale_type) {
        //$data['payments'] = array();
        $data['amount_due'] = 0;
        $data['payment_amount'] = 0;
        $data['col_span'] = 3;

        $data['sale_id'] = $sale_id;
        $data['sale_type'] = $sale_type;
        $data['items'] = SaleOrder::model()->getOrderCartById($sale_id,$location_id,$status,$sale_type);
        $data['currency_type'] = CurrencyType::model()->getActiveCurrency();
        $sale_infos = $sale_type=='R'?Sale::model()->getRetailInfoById($sale_id,$location_id,$status,$sale_type):Sale::model()->getSaleInfoById($sale_id,$location_id,$status,$sale_type);

        $data['sale_infos'] = $sale_infos;

        // View files variable
        $data['view_file'] = $sale_type=='R'?'receipt/index':'receipt/index';
        $data['view_body'] = $sale_type=='R'?'receipt/partial/body':'receipt/partial/body_wsale';

        foreach ($sale_infos as $sale_info) {
            $data['employee_name'] = $sale_info['employee_name'];
            $data['client_name'] = $sale_info['client_name'];
            $data['sale_time'] = $sale_info['sale_time'];
            $data['sub_total'] = $sale_info['sub_total'];
            $data['discount_amount'] = $sale_info['discount_amount'];
            $data['total'] = $sale_info['total'];
            $data['payment_amount'] = $sale_info['paid'];
            $data['amount_due'] = $sale_info['balance'];
        }

        return $data;
    }

    protected function customerInfo($customer_id)
    {
        $model = null;
        if ($customer_id != null) {
            $model = Client::model()->findbyPk($customer_id);
        }

        return $model;
    }

    protected function custAccountInfo($customer_id)
    {
        $model = NULL;
        if ($customer_id !== NULL) {
            $model = Account::model()->getAccountInfo($customer_id);
        }

        return $model;
    }

    protected function setSaleType($sale_type) {
        Yii::app()->shoppingCart->setSaleType($sale_type);
    }

    protected function backIndex()
    {
        $this->redirect(array('saleItem/index?sale_type=' . Common::getSaleType()));
    }

    protected function changeOrderStatus($sale_id,$client_id,$current_status,$to_status) {
        SaleOrder::model()->orderStatusCH($sale_id,$client_id,$current_status,$to_status);
    }

}
