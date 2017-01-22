<?php

class ReportController extends Controller
{

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    public $layout = '//layouts/column1';

    /**
     * @return array action filters
     */
    public function filters()
    {
        return array(
            'accessControl', // perform access control for CRUD operations
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
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index', 'view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('create', 'update', 'ReportTab', 'SaleInvoiceItem',
                                'SaleReportTab', 'SaleInvoice', 'SaleInvoiceDetail',
                                'Inventory','SaleHourly','SaleItemSummary',),
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

    /**
     * Manages all models.
     */
    public function actionSaleInvoice()
    {

        if (!Yii::app()->user->checkAccess('invoice.index') || !Yii::app()->user->checkAccess('invoice.print') || !Yii::app()->user->checkAccess('invoice.delete') || !Yii::app()->user->checkAccess('invoice.update')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        $grid_id = 'rpt-sale-invoice-grid';
        $title = 'Sale Invoice';

        $data = $this->commonData($grid_id,$title,'show');

        $data['grid_columns'] = ReportColumn::getSaleInvoiceColumns();
        $data['data_provider'] = $data['report']->saleInvoice();

        $this->renderView($data);
    }

    public function actionSaleInvoiceDetail($id)
    {
        if (!Yii::app()->user->checkAccess('invoice.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        $report = new Report;

        $data['advance_search'] = '';
        $data['header_tab'] = '';
        $data['header_view']='_header';
        $data['grid_view']='_grid';

        $data['report'] = $report;
        $data['sale_id'] = $id;

        $data['grid_id'] = 'rpt-sale-invoice-grid';
        $data['title'] = Yii::t('app','Sale Invoice Detail #') .' ' . $id  ;

        $data['grid_columns'] = ReportColumn::getSaleInvoiceDetailColumns();

        $report->sale_id = $id;
        $data['data_provider'] = $report->saleInvoiceDetail();

        $this->renderView($data);

    }

    public function actionSaleReportTab($filter = 'all')
    {
        /*$grid_id = 'rpt-inventory-grid';
        $title = 'Inventory';

        $data = $this->commonData($grid_id,$title,'show','_header_3');
        $data['filter'] = $filter;

        $data['header_tab'] = ReportColumn::getSaleReportTab($filter);
        $data['grid_columns'] = ReportColumn::getInventoryColumns();

        $data['data_provider'] = $data['report']->Inventory($filter);*/

        if (!Yii::app()->user->checkAccess('report.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        $grid_id = 'rpt-inventory-grid';
        $title = 'Inventory';

        $data = $this->commonData($grid_id,$title,'show','_header_3');
        $data['filter'] = $filter;

        $data['header_tab'] = ReportColumn::getSaleReportTab($filter);
        $data['grid_columns'] = ReportColumn::getInventoryColumns();

        $data['data_provider'] = $data['report']->Inventory($filter);

        $this->renderView($data);
    }

    public function actionSaleInvoiceItem($sale_id, $employee_id)
    {
        if (Yii::app()->user->checkAccess('report.index')) {
        
            $model = new SaleItem('search');
            $model->unsetAttributes();  // clear any default values

            $payment = new SalePayment('search');
            //$payment->unsetAttributes();
            //$employee=Employee::model()->findByPk((int)$employee_id);
            //$cashier=$employee->first_name . ' ' . $employee->last_name;

            if (isset($_GET['SaleItem']))
                $model->attributes = $_GET['SaleItem'];

            if (Yii::app()->request->isAjaxRequest) {

                Yii::app()->clientScript->scriptMap['*.js'] = false;
                //Yii::app()->clientScript->scriptMap['*.css'] = false;

                if (isset($_GET['ajax']) && $_GET['ajax'] == 'sale-item-grid') {
                    $this->render('sale_item', array(
                        'model' => $model,
                        'payment' => $payment,
                        'sale_id' => $sale_id,
                        'employee_id' => $employee_id
                    ));
                } else {
                    echo CJSON::encode(array(
                        'status' => 'render',
                        'div' => $this->renderPartial('sale_item', array('model' => $model, 'payment' => $payment, 'sale_id' => $sale_id, 'employee_id' => $employee_id), true, true),
                    ));

                    Yii::app()->end();
                }
            } else {
                $this->render('sale_item', array('model' => $model));
            }
        } else {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
    }

    /**
     * Manages all models.
     */
    public function actionSaleSummary()
    {

        $report = new Report;
        //$report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_summary_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_summary', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Manages all models.
     */
    public function actionSaleDaily()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            /*
              Yii::app()->clientScript->scriptMap['*.js'] = false;
              Yii::app()->clientScript->scriptMap['*.css'] = false;
              $this->renderPartial('sale_daily', array('report' => $report,'from_date'=>$from_date,'to_date'=>$to_date),false,true);
              Yii::app()->end();
             * 
             */
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_daily_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_daily', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    public function actionSaleHourly()
    {
        if (!Yii::app()->user->checkAccess('report.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        $grid_id = 'rpt-sale-hourly-grid';
        $title = 'Sale Hourly';

        $data = $this->commonData($grid_id,$title);

        $data['grid_columns'] = ReportColumn::getSaleHourlyColumns();
        $data['data_provider'] = $data['report']->saleHourly();

        $this->renderView($data);
    }

    public function actionPayment()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            /*
              Yii::app()->clientScript->scriptMap['*.js'] = false;
              Yii::app()->clientScript->scriptMap['*.css'] = false;
              $this->renderPartial('sale_daily', array('report' => $report,'from_date'=>$from_date,'to_date'=>$to_date),false,true);
              Yii::app()->end();
             * 
             */
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('payment_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('payment', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Daily Profit
     */
    public function actionDailyProfit()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('sale_daily_profit_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('sale_daily_profit', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    /**
     * Top Product
     */
    public function actionTopProduct()
    {
        $report = new Report;
        $report->unsetAttributes();  // clear any default values

        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('topproduct_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('topproduct', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }

    public function actionSaleItemSummary()
    {
        if (!Yii::app()->user->checkAccess('report.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }
        
        $grid_id = 'rpt-sale-item-summary-grid';
        $title = 'Sale Item Summary';

        $data = $this->commonData($grid_id,$title);

        $data['grid_columns'] = ReportColumn::getSaleItemSummaryColumns();
        $data['data_provider'] = $data['report']->saleItemSummary();

        $this->renderView($data);
    }

    public function actionInventory($filter = 'all')
    {
        if (!Yii::app()->user->checkAccess('report.index')) {
            throw new CHttpException(403, 'You are not authorized to perform this action');
        }

        $grid_id = 'rpt-inventory-grid';
        $title = 'Inventory';

        $data = $this->commonData($grid_id,$title,'show','_header_3');
        $data['filter'] = $filter;

        $data['header_tab'] = ReportColumn::getInventoryHeaderTab($filter);
        $data['grid_columns'] = ReportColumn::getInventoryColumns();

        $data['data_provider'] = $data['report']->Inventory($filter);

        $this->renderView($data);

    }
    
    public function actionUserLogSummary($period = 'today')
    {
        $report = new Report;
  
        if (isset($_GET['Report'])) {
            $report->attributes = $_GET['Report'];
            $from_date = $_GET['Report']['from_date'];
            $to_date = $_GET['Report']['to_date'];
        } else {
            $from_date = date('d-m-Y');
            $to_date = date('d-m-Y');
        }

        $report->from_date = $from_date;
        $report->to_date = $to_date;

        if (Yii::app()->request->isAjaxRequest) {
            Yii::app()->clientScript->scriptMap['*.js'] = false;
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            echo CJSON::encode(array(
                'status' => 'success',
                'div' => $this->renderPartial('user_log_sum_ajax', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date), true, false),
            ));
        } else {
            $this->render('user_log_sum', array('report' => $report, 'from_date' => $from_date, 'to_date' => $to_date));
        }
    }
    
    public function actionUserLogDt($employee_id,$full_name)
    {
        $model = new UserLog('search');
        $model->unsetAttributes();  // clear any default values

        if (isset($_GET['UserLog']))
            $model->attributes = $_GET['UserLog'];

        if (Yii::app()->request->isAjaxRequest) {

            Yii::app()->clientScript->scriptMap['*.js'] = false;
     
            if (isset($_GET['ajax']) && $_GET['ajax'] == 'user-log-dt-grid') {
                $this->render('user_log_dt', array(
                    'model' => $model,
                    'employee_id' => $employee_id,
                    'full_name' => $full_name,
                ));
            } else {
                echo CJSON::encode(array(
                    'status' => 'render',
                    'div' => $this->renderPartial('user_log_dt', array('model' => $model,'employee_id' => $employee_id,'full_name' => $full_name,), true, true),
                ));

                Yii::app()->end();
            }
        } else {
            $this->render('user_log_dt', array('model' => $model,'employee_id' => $employee_id,'full_name' => $full_name,));
        }
    }

    protected function renderView($data, $view_name='index')
    {
        if (Yii::app()->request->isAjaxRequest && !isset($_GET['ajax']) ) {
            Yii::app()->clientScript->scriptMap['*.css'] = false;
            Yii::app()->clientScript->scriptMap['*.js'] = false;

            $this->renderPartial('partial/_grid', $data);
        } else {
            $this->render($view_name, $data);
        }
    }

    /**
     * @param $grid_id
     * @param $title
     * @param $advance_search :  to indicate whether there is an advance search text box
     * @param $header_view
     * @param $grid_view
     * @return mixed
     */
    protected function commonData($grid_id,$title,$advance_search=null,$header_view='_header',$grid_view='_grid')
    {
        $report = new Report;

        $data['report'] = $report;
        $data['from_date'] = isset($_GET['Report']['from_date']) ? $_GET['Report']['from_date'] : date('d-m-Y');
        $data['to_date'] = isset($_GET['Report']['to_date']) ? $_GET['Report']['to_date'] : date('d-m-Y');
        $data['search_id'] = isset($_GET['Report']['search_id']) ? $_GET['Report']['search_id'] : '';
        $data['advance_search'] = $advance_search;
        $data['header_tab'] = '';

        $data['grid_id'] = $grid_id;
        $data['title'] = Yii::t('app', $title) . ' ' . Yii::t('app',
                'From') . ' ' . $data['from_date'] . '  ' . Yii::t('app', 'To') . ' ' . $data['to_date'];
        $data['header_view'] = $header_view;
        $data['grid_view'] = $grid_view;

        $data['report']->from_date = $data['from_date'];
        $data['report']->to_date = $data['to_date'];
        $data['report']->search_id = $data['search_id'];

        return $data;
    }
    

}
