<?php

class SalePaymentController extends Controller
{

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    public $layout = '//layouts/column2';

    /**
     * @return array action filters
     */
    public function filters()
    {
        return array(
            'accessControl', // perform access control for CRUD operations
            'postOnly + delete', // we only allow deletion via POST request
        );
    }

    /**
     * Specifies the access control rules.
     * This method is used by the 'accessControl' filter.
     * @return array access control rules
     */
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

    /**
     * Displays a particular model.
     * @param integer $id the ID of the model to be displayed
     */
    public function actionView($id)
    {
        $this->render('view', array(
            'model' => $this->loadModel($id),
        ));
    }

    /**
     * Deletes a particular model.
     * If deletion is successful, the browser will be redirected to the 'admin' page.
     * @param integer $id the ID of the model to be deleted
     */
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

    /**
     * Lists all models.
     */
    public function actionIndex()
    {
        if (Yii::app()->user->checkAccess('payment.index')) {
            $this->reload();
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    /**
     * Manages all models.
     */
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

        if (!Yii::app()->user->checkAccess('payment.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        $data = $this->sessionInfo();

        if (isset($_POST['SalePayment'])) {
            $data['model']->attributes = $_POST['SalePayment'];
            if ($data['model']->validate()) {
                $paid_amount = $_POST['SalePayment']['payment_amount'];
                $note = $_POST['SalePayment']['note'];

                $payments = array($data['currency_code'] =>
                    array(
                        'currency_code' => $data['currency_code'],
                        'payment_amount' => $paid_amount
                    )
                );

                if ($paid_amount <= $data['balance']) {

                    Sale::model()->payment($data['client_id'],$payments,$data['employee_id'],$note);
                    $data['warning'] = $data['cust_fullname'] . ' Successfully paid ';
                    $this->renderPartial('_payment_success', $data);
                    exit;

                    /*
                    $data['payment_id'] = Salepayment::model()->batchPayment($data['client_id'],
                        $data['employee_id'], $data['account'], $paid_amount, $paid_date, $note);
                    if (substr($data['payment_id'], 0, 2) == '-1') {
                        $data['warning'] = $data['payment_id'];
                    } else {
                        $data = $this->sessionInfo();
                        $data['warning'] = $data['cust_fullname'] . ' Successfully paid ';
                        $this->renderPartial('_payment_success', $data);
                        //$this->redirect(array('salePayment/successPayment','cust_fullname'=>$data['cust_ful']));
                        //Yii::app()->paymentCart->clearAll();
                        exit;
                    }
                    */
                } else {
                    $data['model']->addError('payment_amount', Yii::t('app',
                            'Total amount to paid is only') . ' <strong>' . number_format($data['balance'],
                            Common::getDecimalPlace()) . '</strong>');
                }
            }
        }

        //$this->reload($data);
        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['jquery-ui.css'] = false;
            Yii::app()->clientScript->scriptMap['box.css'] = false;
            $this->renderPartial('index', $data, false, true);
        } else {
            $this->render('index', $data);
        }
    }

    public function actionSelectCustomer()
    {
        if (Yii::app()->request->isPostRequest && Yii::app()->request->isAjaxRequest) {
            Yii::app()->paymentCart->setClientId($_POST['SalePayment']['client_id']);
            $this->reload();
        } else {
            throw new CHttpException(400, 'Invalid request. Please do not repeat this request again.');
        }
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

        /*
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
                'jquery.yiigridview.js' => false,
                'jquery.ba-bbq.min.js' => false,
                'jquery.stickytableheaders.min.js' => false,
            );

            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['jquery-ui.css'] = false;
            Yii::app()->clientScript->scriptMap['box.css'] = false;
            $this->renderPartial('index', $data, false, true);
        } else {
            $this->render('index', $data);
        }
        */

    }

    protected function sessionInfo($data = array())
    {
        $model = new SalePayment;
        $data['model'] = $model;

        $data['cust_fullname'] = 'Not Set';

        $data['client_id'] = Yii::app()->paymentCart->getClientId();
        $data['employee_id'] = Yii::app()->session['employeeid'];
        $data['currency_code'] = Yii::app()->paymentCart->getCurrency();
        $data['sale_id'] = Yii::app()->paymentCart->getInvoiceId();

        $data['currency_type'] = CurrencyType::model()->getActiveCurrency();
        $data['selected_currency'] = CurrencyType::model()->getSelectedCurrency($data['currency_code']);

        $data['sale_invoice'] = SalePayment::model()->singleInvoiceRawData($data['sale_id'],$data['client_id'],'>');


        if ($data['client_id'] !== null) {
            $data['account'] = Account::model()->getAccountInfo($data['client_id']);
            $data['save_button'] = false;

            foreach ($data['account'] as $acc) {
                if ($acc['currency_code'] == $data['currency_code'] ) {
                    $data['balance'] =  $acc['current_balance'];
                    $data['cust_fullname'] = $acc['name'];
                }
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
