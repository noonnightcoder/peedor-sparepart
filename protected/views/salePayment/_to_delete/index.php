<?php
$this->breadcrumbs=array(
	Yii::t('app','Payment')=>array('salePayment/index'),
	Yii::t('app','Index'),
);

?>

<div id="payment_container">
    
    <?php $this->renderPartial('_js', array('model' => $model,)); ?>
 
    <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
                  'title' => Yii::t('app','Payment') . ' :  '  ,  //$cust_fullname,
                  'headerIcon' => 'ace-icon fa fa-credit-card',
                  'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
    )); ?>    

        <?php
        if (isset($warning)) {
            echo TbHtml::alert(TbHtml::ALERT_COLOR_INFO, $warning);
        }
        ?>

        <div class="row">
            <div class="sidebar-nav" id="client_cart">
                <?php
                if ($client_id !== null) {
                    $this->renderPartial('_client_selected', array(
                            'model' => $model,
                            'account' => $account,
                            'client_id' => $client_id,
                        )
                    );
                } else {
                    $this->renderPartial('_client', array('model' => $model));
                }
                ?>
            </div>
        </div>

        <div id="sale_payment_cart">

            <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                    'id'=>'sale-payment-form',
                    'enableAjaxValidation'=>false,
                    'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
                    'action' => $this->createUrl('SavePayment'),
            )); ?>

                    <?php //echo $form->errorSummary($model); ?>

                    <?php //echo TbHtml::alert(TbHtml::ALERT_COLOR_ERROR,''); ?>

                    <?php //echo $form->textFieldControlGroup($model,'total_due',array('class'=>3,'disabled'=>true,'value'=>$balance)); ?>

                    <?php //echo $form->textFieldControlGroup($model,'payment_amount',array('class'=>'3 payment-amount-txt','autocomplete'=>'off')); ?>

                    <div class="form-group">
                        <div class="col-sm-3">
                            <?php echo $form->dropDownList($model,'payment_type', CurrencyType::model()->getCurrency(),array(
                                    'id'=>'currency_type_id',
                                    'options'=>array($selected_currency->code=>array('selected'=>true)),
                                    //'class'=>'col-xs-10 col-sm-8'
                                )
                            ); ?>
                        </div>
                        <div class="col-sm-9">
                             <span class="input-icon">
                                <?php echo $form->textField($model, 'payment_amount', array(
                                    'class' => 'input-large payment-amount-txt',
                                    'id' => 'payment_amount_id',
                                    //'data-url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                    'placeholder' => Yii::t('app', 'Payment Amount') . ' ' . $selected_currency->currency_symbol,
                                ));
                                ?>
                                 <i class="ace-icon fa fa-money green"><?php //echo $selected_currency->currency_symbol; ?></i>
                                 <span class="help-block"><?= $form->error($model,'payment_amount'); ?></span>
                             </span>
                        </div>
                    </div>

                    <?php echo $form->textAreaControlGroup($model,'note',array('rows'=>1,'class'=>2)); ?>

                    <div class="form-group form-actions">
                        <label class="col-sm-3 control-label required" for="SalePayment_payment_amount"> </label>
                        <div class="col-sm-9">    
                            <?php
                                echo TbHtml::linkButton(Yii::t('app', 'Save'), array(
                                    'color' => TbHtml::BUTTON_COLOR_PRIMARY,
                                    //'icon' => 'glyphicon glyphicon-off white',
                                    //'url' => Yii::app()->createUrl('SaleItem/CompleteSale/'),
                                    'class' => 'save-payment',
                                    'id' => 'save_payment_button',
                                    'disabled' => $save_button,
                                    'title' => Yii::t('app', 'Save Payment'),
                            )); ?> 
                        </div>
                    </div>

            <?php $this->endWidget(); ?>
                
    </div>
    
    <?php $this->widget('bootstrap.widgets.TbTabs', array(
        'type'=>'tabs',
        'placement'=>'above', // 'above', 'right', 'below' or 'left'
        'tabs'=>array(
            array('label'=>Yii::t('app','Outstanding Invoice'),'id'=>'tab_1', 'content'=>$this->renderPartial('_invoice', array('model'=>$model,'client_id'=>$client_id,'balance'=>$balance,'currency_code'=>$currency_code) ,true),'active'=>true),
            array('label'=>Yii::t('app','Paid Invoice'),'id'=>'tab_2', 'content'=>$this->renderPartial('_invoice_his', array('model'=>$model,'client_id'=>$client_id,'balance'=>$balance,'currency_code'=>$currency_code),true)),
            array('label'=>Yii::t('app','Payment History'),'id'=>'tab_3', 'content'=>$this->renderPartial('_sale_payment', array('model'=>$model,'client_id'=>$client_id,'balance'=>$balance,'currency_code'=>$currency_code),true)),
        ),
        //'events'=>array('shown'=>'js:loadContent')
    )); ?>
        
  <?php $this->endWidget(); ?>
    
<!--    --><?php //if ($cust_fullname=='') { ?><!--     -->
<!--        --><?php //Yii::app()->clientScript->registerScript('setFocus', '$("#SalePayment_client_id").focus();'); ?>
<!--    --><?php //} ?>
                
</div><!-- form -->

<div class="waiting"><!-- Place at bottom of page --></div>