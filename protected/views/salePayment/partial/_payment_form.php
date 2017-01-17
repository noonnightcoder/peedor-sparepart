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

        <?php foreach ($sale_invoice as $invoice ) { ?>

        <div class="col-sm-3">
            <?php echo $form->dropDownList($model,'payment_type', CurrencyType::model()->getCurrency(),array(
                    'id'=>'currency_type_id',
                    'options'=>array($invoice['currency_code']=>array('selected'=>true)),
                    'class'=>'col-xs-12 col-sm-12'
                )
            ); ?>
        </div>
        <div class="col-sm-9">
             <span class="input-icon">
                    <?php echo $form->textField($model, 'payment_amount', array(
                        'class' => 'input-large payment-amount-txt',
                        'id' => 'payment_amount_id',
                        'placeholder' => Yii::t('app', 'Payment Amount'),
                        'value' => $invoice['balance'],
                        'prepend' => $invoice['currency_symbol'],
                    ));
                    ?>
                    <span class="help-block"><?= $form->error($model,'payment_amount'); ?></span>
             </span>
        </div>

        <?php } ?>
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