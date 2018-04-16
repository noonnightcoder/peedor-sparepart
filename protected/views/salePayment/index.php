<?php
$this->breadcrumbs=array(
	Yii::t('app','Payment')=>array('salePayment/index'),
	Yii::t('app','Index'),
);

?>

<!-- Flash message layouts.partial._flash_message -->
<?php $this->renderPartial('//layouts/alert/_flash'); ?>


<div id="payment_container">

    <?php $this->widget( 'ext.modaldlg.EModalDlg' ); ?>

    <?php $this->renderPartial('partial/_js', array('model' => $model,)); ?>
 
    <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
                  'title' => Yii::t('app','Payment') . ' :  '  ,  //$cust_fullname,
                  'headerIcon' => 'ace-icon fa fa-credit-card',
                  'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
    )); ?>

        <?php $this->renderPartial('//layouts/alert/_flash'); ?>

        <div class="row">
            <div class="sidebar-nav" id="client_cart">
                <?php
                if ($client_id !== null) {
                    $this->renderPartial('partial/_client_selected', array(
                            'model' => $model,
                            'account' => $account,
                            'client_id' => $client_id,
                        )
                    );
                } else {
                    $this->renderPartial('partial/_client', array('model' => $model));
                }
                ?>

                <?php if ($sale_id !== null ) {
                    $this->renderPartial('partial/_invoice_selected', array('sale_id' => $sale_id));
                } ?>

            </div>
        </div>

        <div id="sale_payment_cart">

            <?php $this->renderPartial('partial/_payment_form', array(
                'model' => $model,
                'save_button' => $save_button,
                'sale_invoice' => $sale_invoice,
                'currency_type' => $currency_type,
            ));
            ?>
                
    </div>

    <?php $this->renderPartial('partial/_invoice_payment_sub', array(
        'model' => $model,
        'client_id' => $client_id,
        //'balance' => $balance,
        //'currency_code' => $currency_code
    ));
    ?>

  <?php $this->endWidget(); ?>
    
<?php if ($cust_fullname=='Not Set') { ?>
    <?php Yii::app()->clientScript->registerScript('setFocus', '$("#SalePayment_client_id").focus();'); ?>
<?php } ?>
                
</div><!-- form -->

<div class="waiting"><!-- Place at bottom of page --></div>