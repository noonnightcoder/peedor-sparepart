<?php

class SalePaymentController extends Controller
{

    public $layout = '//layouts/column2';

    public function filters()
    {
        return array(
            'accessControl', // perform access control for CRUD operations
            'postOnly + delete', // we only allow deletion via POST request
        );
    }

    public function accessRules()
    {
        return array(
            array(
                'allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index', 'view'),
                'users' => array('@'),
            ),
            array(
                'allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array(
                    'create',
                    'update',
                    'Payment',
                    'admin',
                    'PaymentDetail',
                    'savepayment',
                    'SelectCustomer',
                    'RemoveCustomer',
                    'successPayment',
                    'SetCurrencyType',
                    'SelectInvoice',
                    'RemoveInvoice',
                ),
                'users' => array('@'),
            ),
            array(
                'allow', // allow admin user to perform 'admin' and 'delete' actions
                'actions' => array('admin', 'delete'),
                'users' => array('*'),
            ),
            array(
                'deny', // deny all users
                'users' => array('*'),
            ),
        );
    }

    public function actionView($id)
    {
        $this->render('view', array(
            'model' => $this->loadModel($id),
        ));
    }

    public function actionDelete($id)
    {
        if (Yii::app()->request->isPostRequest) {
            // we only allow deletion via POST request
            $this->loadModel($id)->delete();

            // if AJAX request (triggered by deletion via admin grid view), we should not redirect the browser
            if (!isset($_GET['ajax'])) {
                $this->redirect(isset($_POST['returnUrl']) ? $_POST['returnUrl'] : array('admin'));
            }
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionIndex()
    {
        authorized('payment.index');

        $this->reload();
    }

    public function actionAdmin()
    {
        $model = new SalePayment('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['SalePayment'])) {
            $model->attributes = $_GET['SalePayment'];
        }

        $this->render('admin', array(
            'model' => $model,
        ));
    }

    public function loadModel($id)
    {
        $model = SalePayment::model()->findByPk($id);
        if ($model === null) {
            throw new CHttpException(404, 'The requested page does not exist.');
        }

        return $model;
    }

    protected function performAjaxValidation($model)
    {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'sale-payment-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

    public function actionSavePayment()
    {
        authorized('payment.index');

        $model = new SalePayment;
        $result = '';

        $data = $this->sessionInfo();

        $this->performAjaxValidation($model);

        if(isset($_POST['SalePayment'])) {
            $valid = true;

            foreach ($data['currency_type'] as $currency) {
                if (isset($_POST['SalePayment'][$currency->code])) {
                    $model->attributes = $_POST['SalePayment'][$currency->code];

                    $valid = $model->validate() && $valid;
                    $note = $_POST['SalePayment']['note'];
                    $date_paid = $_POST['SalePayment']['date_paid'];

                    if ($valid) {
                        $currency_code = $currency->code;
                        $payment_amount = $_POST['SalePayment'][$currency->code]['payment_amount'];
                        if ($payment_amount > 0) {
                            $result = Sale::model()->payment($data['client_id'], $currency_code, $payment_amount, getEmployeeId(), $date_paid,$note);
                        }

                        Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS, '</strong> Successfully paid <strong>');

                        //$this->renderPartial('partial/_payment_success', $data);
                    }
                }

            }
        }

        loadview('index', 'index', $data);
    }

    public function actionSelectCustomer()
    {
        ajaxRequestPost();

        $id = $_POST['SalePayment']['client_id'];
        $client = Client::model()->findByPk($id);

        if (!$client) {
            Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS, '<strong>Customer not found in the database</strong>');
            $this->redirect(Yii::app()->request->urlReferrer);
        } else {
            Yii::app()->paymentCart->setClientId($client->id);
        }

        $this->reload();

    }

    public function actionRemoveCustomer()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->paymentCart->clearAll();
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionSelectInvoice($sale_id)
    {

        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->paymentCart->setInvoiceId($sale_id);
            $this->reload();
        } else {
            //$this->redirect(array('site/ErrorException', 'err_no' => 400));
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    public function actionRemoveInvoice()
    {
        if ( Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest ) {
            Yii::app()->paymentCart->removeInvoiceId();
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

    private function reload()
    {
        $data = $this->sessionInfo();

        loadview('index','index',$data);

    }

    protected function sessionInfo($data = array())
    {
        $model = new SalePayment;
        $data['model'] = $model;
        $data['model']->date_paid = date('d-m-Y H:i:s');

        $data['cust_fullname'] = 'Not Set';

        $data['client_id'] = Yii::app()->paymentCart->getClientId();
        $data['employee_id'] = Yii::app()->session['employee_id'];
       // $data['currency_code'] = Yii::app()->paymentCart->getCurrency();
        $data['sale_id'] = Yii::app()->paymentCart->getInvoiceId();

        $data['currency_type'] = CurrencyType::model()->getActiveCurrency();
        //$data['selected_currency'] = CurrencyType::model()->getSelectedCurrency($data['currency_code']);
        //$data['sale_invoice'] = SalePayment::model()->singleInvoiceRawData($data['sale_id'],$data['client_id'],'>');
        $data['sale_invoice'] = SalePayment::model()->invoiceRawData($data['client_id'],'>');


        //$data['sale_invoice'] = array();

        if ($data['client_id'] !== null) {
            $data['account'] = Account::model()->getAccountInfo($data['client_id']);
            $data['save_button'] = false;

            foreach ($data['account'] as $acc) {
                //if ($acc['currency_code'] == $data['currency_code'] ) {
                 //   $data['balance'] =  $acc['current_balance'];
                    $data['cust_fullname'] = $acc['name'];
                //}
            }

        } else {
            $data['balance'] = 0;
            $data['save_button'] = true;
        }

        return $data;
    }

    public function actionPaymentDetail($id)
    {
        $model = new SalePayment('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['SalePayment'])) {
            $model->attributes = $_GET['SalePayment'];
        }

        $this->renderPartial('sale_payment', array(
            'model' => $model,
            'id' => $id,
        ));
    }

    public function actionSetCurrencyType()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            $currency_type_id = $_POST['currency_type_id'];
            Yii::app()->paymentCart->setCurrency($currency_type_id);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
    }

}
