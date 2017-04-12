<?php /*if ($total_discount !== null && $total_discount > 0) { */?><!--
    <tr>
        <td><?php /*echo Yii::t('app', 'Sub Total'); */?> :</td>
        <td><span class="badge badge-info bigger-120">
                                <?php /*number_format($sub_total_kh, 0, '.', ','); */?>
                            </span>
        </td>
    </tr>
    <tr>
        <td><?php /*echo $total_discount . '% ' . Yii::t('app', 'Discount'); */?> :</td>
        <td>
                            <span class="badge badge-info bigger-120">
                                <?php /*echo number_format($discount_amount, 0, '.', ','); */?>
                            </span>
        </td>
    </tr>
<?php /*} */?>
<tr>
    <td><?php /*echo Yii::t('app', 'Total'); */?> :</td>
    <td>
                        <span class="badge badge-info bigger-120">
                            <?php /*echo number_format($total_kh, 0, '.', ','); */?>
                        </span>
    </td>
</tr>-->

<?php foreach (SaleOrder::model()->getAllTotalKH() as $record): ?>
    <tr>
        <td><?= Yii::t('app','Total')  ?> </td>
        <td><?= number_format($record['total'],0,'.',',') ?></td>
    </tr>
<?php endforeach; ?>

<?php
$form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
    'id' => 'finish_sale_form',
    'action' => Yii::app()->createUrl('saleItem/completeSale/'),
    'enableAjaxValidation' => false,
    'layout' => TbHtml::FORM_LAYOUT_INLINE,
));
?>

<?php //if ($count_payment == 0) { ?>
<!--<tr>
    <td colspan="2" style='text-align:right'>
        <?php /*echo $form->textFieldControlGroup($model, 'payment_amount', array(
            'value' => '', //$amount_change,
            'class' => 'input-mini text-right payment-amount-txt',
            'id' => 'payment_amount_id',
            'data-url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
            'placeholder' => Yii::t('app', 'Payment Amount'),
            //'prepend' => Yii::app()->settings->get('site', 'currencySymbol'),
        ));
        */?>
    </td>
</tr>
<tr>
    <td colspan="2" style='text-align:right'><?php
/*        echo TbHtml::linkButton(Yii::t('app', 'Add Payment'), array(
            'color' => TbHtml::BUTTON_COLOR_INFO,
            'size' => TbHtml::BUTTON_SIZE_MINI,
            'icon' => 'glyphicon-plus white',
            'url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
            'class' => 'add-payment',
            //'title' => Yii::t('app', 'Add Payment'),
        ));
        */?>
    </td>
</tr>-->
<?php //} ?>

<?php $this->endWidget(); ?>

<?php //if ($count_payment > 0) { ?>
    <table class="table table-striped table-condensed">
        <td colspan="3" style='text-align:right'>
            <?php
            echo TbHtml::linkButton(Yii::t('app', 'Complete Sale'), array(
                'color' => TbHtml::BUTTON_COLOR_SUCCESS,
                'icon' => 'glyphicon glyphicon-off white',
                //'url' => Yii::app()->createUrl('SaleItem/CompleteSale/'),
                'class' => 'complete-sale',
                'id' => 'finish_sale_button',
                //'title' => Yii::t('app', 'Complete Sale'),
            ));
            ?>
        </td>
    </table>
<?php //} ?>



