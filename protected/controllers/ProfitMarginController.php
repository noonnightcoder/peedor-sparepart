<?php

class ProfitMarginController extends Controller {

    /**
     * @var string the default layout for the views. Defaults to '//layouts/column2', meaning
     * using two-column layout. See 'protected/views/layouts/column2.php'.
     */
    public $layout = '//layouts/column2';

    /**
     * @return array action filters
     */
    public function filters() {
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
    public function accessRules() {
        return array(
            array('allow', // allow all users to perform 'index' and 'view' actions
                'actions' => array('index', 'view'),
                'users' => array('*'),
            ),
            array('allow', // allow authenticated user to perform 'create' and 'update' actions
                'actions' => array('create', 'update', 'admin', 'delete'),
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
     * Displays a particular model.
     * @param integer $id the ID of the model to be displayed
     */
    public function actionView($id)
    {
        if (Yii::app()->request->isAjaxRequest) {

            Yii::app()->clientScript->scriptMap['*.js'] = false;

            echo CJSON::encode(array(
                'status' => 'render',
                'div' => $this->renderPartial('view', array('model' => $this->loadModel($id)), true, false),
            ));

            Yii::app()->end();
        } else {
            $this->render('view', array(
                'model' => $this->loadModel($id),
            ));
        }
    }

    /**
     * Creates a new model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     */
    public function actionCreate() {
        $model = new ProfitMargin;
        $price_tiers = PriceTier::model()->getListPriceTier();

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['ProfitMargin'])) {
            $model->attributes = $_POST['ProfitMargin'];
            $model->modified_by = Yii::app()->session['employeeid'];
            if ($model->validate()) {
                $transaction = Yii::app()->db->beginTransaction();
                try {
                    if ($model->save()) {
                        ProfitPriceTier::model()->saveProfitPriceTier($model->id, $price_tiers);
                        $transaction->commit();
                        Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,'Item Id : <strong>' . $model->name . '</strong> have been saved successfully!' );
                        $this->redirect(array('admin'));
                    }
                } catch (Exception $e) {
                    $transaction->rollback();
                    Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_WARNING, 'Oop something wrong : <strong>' . $e);
                }
            }
        }

        $this->render('create', array(
            'model' => $model,
            'price_tiers' => $price_tiers,
        ));
    }

    /**
     * Updates a particular model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id the ID of the model to be updated
     */
    public function actionUpdate($id) {
        $model = $this->loadModel($id);
        $price_tiers = PriceTier::model()->getProfitPriceTierUpdate($id);

        // Uncomment the following line if AJAX validation is needed
        // $this->performAjaxValidation($model);

        if (isset($_POST['ProfitMargin'])) {
            $model->attributes = $_POST['ProfitMargin'];
            $model->modified_by = Yii::app()->session['employeeid'];
            if ($model->validate()) {
                $transaction = Yii::app()->db->beginTransaction();
                try {
                    if ($model->save()) {
                        ProfitPriceTier::model()->saveProfitPriceTier($model->id, $price_tiers);
                        $transaction->commit();
                        Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_SUCCESS,'Profit Margin : <strong>' . $model->name . '</strong> have been saved successfully!' );
                        $this->redirect(array('admin'));
                    }
                } catch (Exception $e) {
                    $transaction->rollback();
                    Yii::app()->user->setFlash(TbHtml::ALERT_COLOR_WARNING, 'Oop something wrong : <strong>' . $e);
                }
            }
        }

        $this->render('update', array(
            'model' => $model,
            'price_tiers' => $price_tiers,
        ));
    }

    /**
     * Deletes a particular model.
     * If deletion is successful, the browser will be redirected to the 'admin' page.
     * @param integer $id the ID of the model to be deleted
     */
    public function actionDelete($id) {
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
    public function actionIndex() {
        $dataProvider = new CActiveDataProvider('ProfitMargin');
        $this->render('index', array(
            'dataProvider' => $dataProvider,
        ));
    }

    /**
     * Manages all models.
     */
    public function actionAdmin() {
        $model = new ProfitMargin('search');
        $model->unsetAttributes();  // clear any default values
        if (isset($_GET['ProfitMargin'])) {
            $model->attributes = $_GET['ProfitMargin'];
        }

        $this->render('admin', array(
            'model' => $model,
        ));
    }

    /**
     * Returns the data model based on the primary key given in the GET variable.
     * If the data model is not found, an HTTP exception will be raised.
     * @param integer $id the ID of the model to be loaded
     * @return ProfitMargin the loaded model
     * @throws CHttpException
     */
    public function loadModel($id) {
        $model = ProfitMargin::model()->findByPk($id);
        if ($model === null) {
            throw new CHttpException(404, 'The requested page does not exist.');
        }
        return $model;
    }

    /**
     * Performs the AJAX validation.
     * @param ProfitMargin $model the model to be validated
     */
    protected function performAjaxValidation($model) {
        if (isset($_POST['ajax']) && $_POST['ajax'] === 'profit-margin-form') {
            echo CActiveForm::validate($model);
            Yii::app()->end();
        }
    }

}
