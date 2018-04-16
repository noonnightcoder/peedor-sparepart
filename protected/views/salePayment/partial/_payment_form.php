<?php $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
    'id' => 'sale-payment-form',
    'enableClientValidation'=>true,
    'clientOptions' => array(
        'validateOnSubmit'=>true,
        'validateOnChange'=>true,
        'validateOnType'=>true,
    ),
    'layout' => TbHtml::FORM_LAYOUT_HORIZONTAL,
    'action' => $this->createUrl('savePayment'),
)); ?>

    <div class="form-group">
        <label class="col-sm-3 control-label" for="SalePayment_created_at"><?= Yii::t('app','Paid Date') ?></label>
        <div class="col-sm-9">
            <div class="input-append">
                <?php $this->widget('yiiwheels.widgets.datetimepicker.WhDateTimePicker', array(
                    'attribute' => 'date_paid',
                    'model' => $model,
                    'pluginOptions' => array(
                        'format' => 'DD-MM-YYYY HH:mm:ss',
                    ),
                ));
                ?>
            </div>
        </div>
    </div>

    <div class="form-group">

        <?php foreach ($currency_type as $id => $currency): ?>
            <tr>
                <td colspan="2">
                    <?php echo $form->textFieldControlGroup($model, "[$currency->code]payment_amount", array(
                        'value' => '',
                        'class' => 'payment-amount-' . $currency->code ,
                        //'id' => 'payment_amount_' . $currency->code,
                        //'data-url' => Yii::app()->createUrl('SaleItem/AddPayment/',array('currency_code' => $currency->code)),
                        'placeholder' => Yii::t('app', 'Payment Amount ' . $currency->currency_symbol),
                        'prepend' => $currency->currency_symbol,
                    ));
                    ?>
                    <?php /*echo $form->textFieldControlGroup($model, 'payment_amount' . '[' . $currency->code . ']' , array(
                        'value' => '',
                        'class' => 'text-right payment-amount-' . $currency->code ,
                        'id' => 'payment_amount_' . $currency->code,
                        //'data-url' => Yii::app()->createUrl('SaleItem/AddPayment/',array('currency_code' => $currency->code)),
                        'placeholder' => Yii::t('app', 'Payment Amount ' . $currency->currency_symbol),
                        'prepend' => $currency->currency_symbol,
                    ));
                    */?>
                </td>
            </tr>

        <?php endforeach; ?>
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