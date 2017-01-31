<?php

class WholeSaleController extends Controller
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
                    'DeleteSale',
                    'SetCurrencyType',
                    'NewSale'
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

    public function actionIndex($first_load = 'N')
    {
        if (Yii::app()->user->checkAccess('sale.edit') || Yii::app()->user->checkAccess('sale.discount') || Yii::app()->user->checkAccess('sale.editprice')) {
            $data = array();
            if ($first_load == 'N') {
                $this->reload($data);
            } else {
                Yii::app()->wshoppingCart->clearAll();
                $data["first_load"] = $first_load;
                $this->reload($data);
            }
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionAdd()
    {

        $data = array();
        $item_id = $_POST['SaleItem']['item_id'];

        if (!Yii::app()->wshoppingCart->addItem($item_id)) {
            //$data['warning'] = 'Unable to add item to sale';
            Yii::app()->user->setFlash('warning', "Product was not found in the system");
        }

        if (Yii::app()->wshoppingCart->outofStock($item_id)) {
            Yii::app()->user->setFlash('warning', "Desired Quantity is Insufficient. You can still process the sale, but check your inventory!");
        }

        $this->reload($data);

    }

    public function actionIndexPara($item_id)
    {
        if (Yii::app()->user->checkAccess('sale.edit')) {

            Yii::app()->wshoppingCart->addItem($item_id);

            $this->reload($item_id);
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionNewSale()
    {
        $model = new Sale;
        if (Yii::app()->request->isAjaxRequest) {
            $cs = Yii::app()->clientScript;
            $cs->scriptMap = array(
                //'jquery.js'=>false,
                'bootstrap.js' => false,
                //'jquery.min.js'=>false,
                'bootstrap.notify.js' => false,
                'bootstrap.bootbox.min.js' => false,
            );

            echo CJSON::encode(array(
                'status' => 'render',
                'div' => $this->renderPartial('_new_sale', array('model' => $model), true, true),
            ));

            Yii::app()->end();
        } else {
            $this->render('_new_sale', array('model' => $model));
        }
    }

    public function actionDeleteItem($item_id)
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->wshoppingCart->deleteItem($item_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionEditItem($item_id)
    {

        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $data = array();
            $model = new SaleItem;
            $quantity = isset($_POST['SaleItem']['quantity']) ? $_POST['SaleItem']['quantity'] : null;
            $price = isset($_POST['SaleItem']['price']) ? $_POST['SaleItem']['price'] : null;
            $discount = isset($_POST['SaleItem']['discount']) ? $_POST['SaleItem']['discount'] : null;
            $description = 'test';

            $model->quantity = $quantity;
            $model->price = $price;
            $model->discount = $discount;

            if ($model->validate()) {
                Yii::app()->wshoppingCart->editItem($item_id, $quantity, $discount, $price, $description);
            } else {
                $error = CActiveForm::validate($model);
                $errors = explode(":", $error);
                //$data['warning']=  str_replace("}","",$errors[1]);
                $data['warning'] = Yii::t('app', 'Input data type is invalid');
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
                //$data= array();
                $payment_amount = trim($_POST['payment_amount']) == "" ? 0 : $_POST['payment_amount'];
                Yii::app()->wshoppingCart->addPayment(Yii::app()->wshoppingCart->getCurrency(), $payment_amount);
                $this->reload();
            }
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionDeletePayment($currency_code)
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->wshoppingCart->deletePayment($currency_code);
            Yii::app()->wshoppingCart->setCurrency($currency_code);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionSelectCustomer()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $client_id = $_POST['SaleItem']['client_id'];
            $client = Client::model()->findByPk($client_id);
            Yii::app()->wshoppingCart->setCustomer($client_id);
            Yii::app()->wshoppingCart->setPriceTier($client->price_tier_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionRemoveCustomer()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->wshoppingCart->removeCustomer();
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionSetComment()
    {
        Yii::app()->wshoppingCart->setComment($_POST['comment']);
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
                Yii::app()->wshoppingCart->setTotalDiscount($total_discount);
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
        $price_tier_id = $_POST['price_tier_id'];
        Yii::app()->wshoppingCart->setPriceTier($price_tier_id);
        Yii::app()->wshoppingCart->f5ItemPriceTier();
        $this->reload();
    }

    public function actionSetCurrencyType()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $currency_type_id = $_POST['currency_type_id'];
            Yii::app()->wshoppingCart->setCurrency($currency_type_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    private function reload($data = array())
    {
        $this->layout = '//layouts/column_sale';

        $model = new SaleItem;
        $data['model'] = $model;
        $data['status'] = 'success';

        if (!isset($data['first_load'])) {
            $data['first_load'] = 'N';
        }

        $data = $this->sessionInfo($data);

        //$model->comment = $data['comment'];
        //$model->total_discount= $data['total_discount'];

        /*
        $customer = $this->customerInfo($data['customer_id']);
        $data['cust_fullname'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : '';
        $data['cust_mobile'] = $customer !== null ? $customer->mobile_no : '';
         * 
        */

        if (Yii::app()->request->isAjaxRequest) {

            //Yii::app()->clientScript->scriptMap['*.js'] = false; 
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

    public function actionCancelSale()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->wshoppingCart->clearAll();
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionCompleteSale()
    {
        $this->layout = '//layouts/column_receipt';
        $data = $this->sessionInfo();

        if (empty($data['items'])) {
            $this->redirect(array('wholeSale/index'));
        }

        //Save transaction to db
        $data['sale_id'] = Sale::model()->saveSale($data['session_sale_id'], $data['items'], $data['payments'],
            $data['payment_received'], $data['customer_id'], $data['employee_id'], $data['sub_total'], $data['comment'],
            Yii::app()->params['sale_complete_status'], $data['total_discount'],'W');

        $customer = $this->customerInfo($data['customer_id']);
        $data['cust_fullname'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : 'General';

        if ($customer == null) {
            $data['warning'] = Yii::t('app', 'Plz, Select Customer');
            $this->reload($data);
        } elseif (substr($data['sale_id'], 0, 2) == '-1') {
            $data['warning'] = $data['sale_id'];
        } else {
            $this->render('partial/_receipt', $data);
            Yii::app()->wshoppingCart->clearAll();
        }

    }

    public function actionSuspendSale()
    {
        if (Yii::app()->request->isAjaxRequest) {
            $data = $this->sessionInfo();

            //Save transaction to db
            $data['sale_id'] = Sale::model()->saveSale($data['session_sale_id'], $data['items'], $data['payments'],
                $data['payment_received'], $data['customer_id'], $data['employee_id'], $data['sub_total'],
                $data['comment'], Yii::app()->params['sale_suspend_status'], $data['total_discount']);

            $customer = $this->customerInfo($data['customer_id']);
            $data['cust_fullname'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : 'General';

            if (substr($data['sale_id'], 0, 2) == '-1') {
                //$data['warning'] = $data['sale_id'];
                Yii::app()->user->setFlash('warning', $data['sale_id']);
                $this->reload($data);
                Yii::app()->end();
            } else {
                if (Yii::app()->settings->get('sale', 'receiptPrintDraftSale') == '1') {
                    $this->layout = '//layouts/column_receipt';
                    $this->render('_receipt_suspend', $data);
                    Yii::app()->wshoppingCart->clearAll();
                } else {
                    Yii::app()->wshoppingCart->clearAll();
                }
            }

            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionUnsuspendSale($sale_id)
    {
        Yii::app()->wshoppingCart->clearAll();
        Yii::app()->wshoppingCart->copyEntireSuspendSale($sale_id);
        //Sale::model()->saveUnsuspendSale($sale_id); // Roll back stock cut to original stock
        $this->redirect('index');
        exit;
    }

    public function actionEditSale($sale_id)
    {
        if (Yii::app()->user->checkAccess('invoice.print')) {
            //if(Yii::app()->request->isPostRequest)
            //{
            Yii::app()->wshoppingCart->clearAll();
            Yii::app()->wshoppingCart->copyEntireSale($sale_id);
            Yii::app()->session->close(); // preventing session clearing due to page redirecting..
            $this->redirect('index');
            //}
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    public function actionReceipt($sale_id)
    {
        if (Yii::app()->user->checkAccess('invoice.print')) {

            $this->layout = '//layouts/column_receipt';

            Yii::app()->wshoppingCart->clearAll();
            Yii::app()->wshoppingCart->copyEntireSale($sale_id);

            $data = $this->sessionInfo();

            $data['sale_id'] = $sale_id;

            $customer = $this->customerInfo($data['customer_id']);
            $data['customer'] = $customer !== null ? $customer->first_name . ' ' . $customer->last_name : '';

            if (count($data['items']) == 0) {
                $data['error_message'] = 'Sale Transaction Failed';
            }

            $this->render('_receipt', $data);
            Yii::app()->wshoppingCart->clearAll();
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

    }

    /* 
     * List all of Suspened Sale (Query from [Sale] model where status='2')
     */
    public function actionListSuspendedSale()
    {
        $model = new Sale;
        $model->unsetAttributes();

        $search = '';

        if (isset($_GET['Sale'])) {
            //$model->attributes = $_GET['Sale'];
            $model->search_client = $_GET['Sale']['search_client'];
        }

        $this->render('sale_suspended', array('model' => $model, 'search' => $search));
    }

    public function actionDeleteSale($sale_id)
    {
        $result_id = Sale::model()->deleteSale($sale_id, 'Cancel Suspended Sale',
            Yii::app()->wshoppingCart->getEmployee());

        if ($result_id === -1) {
            Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,
                '<strong>Oh snap!</strong> Change a few things up and try submitting again.');
        } else {
            Yii::app()->wshoppingCart->clearAll();
            Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,
                '<strong>Well done!</strong> Invoice Id ' . $sale_id . 'have been deleted successfully!');
            $this->redirect('ListSuspendedSale');
        }

    }

    protected function sessionInfo($data = array())
    {
        //$data=array();
        $data['cust_fullname'] = '';
        $data['customer_id'] = '';

        $data['items'] = Yii::app()->wshoppingCart->getCart();
        $data['count_item'] = Yii::app()->wshoppingCart->getQuantityTotal();
        $data['qtytotal'] = Yii::app()->wshoppingCart->getQuantityTotal();

        $data['payments'] = Yii::app()->wshoppingCart->getPayments();
        $data['count_payment'] = count(Yii::app()->wshoppingCart->getPayments());
        $data['payment_received'] = Yii::app()->wshoppingCart->getPaymentsTotal();

        $data['sub_total'] = 0;
        $data['sub_total_mc'] = Yii::app()->wshoppingCart->getSubTotalMC();
        //$data['sub_total_usd'] = Yii::app()->wshoppingCart->getSubTotal()[0];
        //$data['sub_total_khr'] = Yii::app()->wshoppingCart->getSubTotal()[1];
        //$data['sub_total_thb'] = Yii::app()->wshoppingCart->getSubTotal()[2];

        //$data['total_usd'] = Yii::app()->wshoppingCart->getTotal()[0];
        //$data['total_khr'] = Yii::app()->wshoppingCart->getTotal()[1];
        //$data['total_thb'] = Yii::app()->wshoppingCart->getTotal()[2];
        $data['total_mc'] = Yii::app()->wshoppingCart->getTotalMC();
        $data['total_due'] = Yii::app()->wshoppingCart->getTotalDue();

        $data['amount_change'] = Yii::app()->wshoppingCart->getAmountDue();

        $data['customer_id'] = Yii::app()->wshoppingCart->getCustomer();
        $data['comment'] = Yii::app()->wshoppingCart->getComment();
        $data['employee_id'] = Yii::app()->session['employeeid'];
        $data['transaction_date'] = date('d/m/Y');
        $data['transaction_time'] = date('h:i:s');
        $data['session_sale_id'] = Yii::app()->wshoppingCart->getSaleId();
        $data['employee'] = ucwords(Yii::app()->session['emp_fullname']);

        $data['total_discount'] = Yii::app()->wshoppingCart->getTotalDiscount();
        //$data['discount_amt_usd'] = $data['sub_total_usd'] * $data['total_discount']/100;
        //$data['discount_amt_khr'] = $data['sub_total_khr'] * $data['total_discount']/100;
        //$data['discount_amt_thb'] = $data['sub_total_thb'] * $data['total_discount']/100;

        $data['disable_editprice'] = Yii::app()->user->checkAccess('sale.editprice') ? false : true;
        $data['disable_discount'] = Yii::app()->user->checkAccess('sale.discount') ? false : true;
        $data['colspan'] = Yii::app()->settings->get('sale', 'discount') == 'hidden' ? '3' : '4';

        // Customer Account Info
        $data['account'] = $this->custAccountInfo($data['customer_id']);
        $data['currency_type'] = CurrencyType::model()->getActiveCurrency();

        $data['selected_currency'] = CurrencyType::model()->getSelectedCurrency(Yii::app()->wshoppingCart->getCurrency());

        //$data['currency_array'] = CurrencyType::model()->getActiveCurArr();

        /*
        foreach($data['currency_type'] as $record) {
            $currency[] = $record->code;
        }
        $data['currency'] = $currency;
         * 
        */

        //$data['cust_fullname'] = $account !== null ? $account->name : '';
        //$data['acc_balance'] = $account !== null ? $account->current_balance : '';

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
        $model = null;
        if ($customer_id != null) {
            $model = Account::model()->getAccountInfo($customer_id);
        }

        return $model;
    }
}
