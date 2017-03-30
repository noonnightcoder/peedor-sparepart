<?php
$form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
    'id' => 'finish_sale_form',
    'action' => Yii::app()->createUrl('saleItem/completeSale/'),
    'enableAjaxValidation' => false,
    'layout' => TbHtml::FORM_LAYOUT_INLINE,
));
?>

<?php if ($count_payment > 0) { ?>

    <?php if ($amount_change <= 0) { ?>
        <tr>
            <td>
                <?php echo Yii::t('app', 'Change Due'); ?>:
            </td>
            <td>
                <span class="badge badge-info bigger-120">
                    <?php echo  number_format($amount_change, Common::getDecimalPlaceRS(), '.', ','); ?>
                </span>
            </td>
        </tr>
    <?php } else { ?>
        <tr>
            <td>
                <span class="label label-danger">
                    <?php echo TbHtml::b(Yii::t('app', 'Change Owe')); ?>
                </span>
            </td>
            <td>
                <span class="badge badge-important bigger-120">
                    <strong>
                        <?php echo number_format($amount_change, Common::getDecimalPlaceRS(), '.', ','); ?>
                    </strong>
                </span>
            </td>
        </tr>
    <?php } ?>
<?php } ?>


<?php if ($count_payment == 0) { ?>
    <tr>
        <td colspan="2" style='text-align:right'>
            <?php echo $form->textFieldControlGroup($model, 'payment_amount', array(
                'value' => '', //$amount_change,
                'class' => 'input-mini text-right payment-amount-txt',
                'id' => 'payment_amount_id',
                'data-url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
                'placeholder' => Yii::t('app', 'Payment Amount'),
                //'prepend' => Yii::app()->settings->get('site', 'currencySymbol'),
            ));
            ?>
        </td>
    </tr>
    <tr>
        <td colspan="2" style='text-align:right'><?php
            echo TbHtml::linkButton(Yii::t('app', 'Add Payment'), array(
                'color' => TbHtml::BUTTON_COLOR_INFO,
                'size' => TbHtml::BUTTON_SIZE_MINI,
                'icon' => 'glyphicon-plus white',
                'url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
                'class' => 'add-payment',
                //'title' => Yii::t('app', 'Add Payment'),
            ));
            ?>
        </td>
    </tr>
<?php } ?>

<?php $this->endWidget(); ?>
