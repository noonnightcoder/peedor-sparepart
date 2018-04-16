<?php foreach (SaleOrder::model()->getAllTotal() as $record): ?>
    <tr>
        <td><?= Yii::t('app','Total') . ' ' .  $record['currency_symbol'] ?> </td>
        <td><?= $record['currency_symbol'] . ' ' . number_format($record['total'],0,'.',',') ?></td>
    </tr>
<?php endforeach; ?>

<?php
$form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
    'id' => 'finish_sale_form',
    'action' => Yii::app()->createUrl('saleItem/AddPayment/'),
    'enableAjaxValidation' => false,
    'layout' => TbHtml::FORM_LAYOUT_INLINE,
));
?>

<?php /*foreach (CurrencyType::model()->getActiveCurrency() as $id => $currency): */?><!--

        <tr>
            <td colspan="2" style='text-align:right'>
                <?php /*echo $form->textFieldControlGroup($model, 'payment_amount', array(
                    'value' => '', //$amount_change,
                    'class' => 'input-mini text-right payment-amount-' . $currency->code ,
                    'id' => 'payment_amount_' . $currency->code,
                    'data-url' => Yii::app()->createUrl('SaleItem/AddPayment/',array('currency_code' => $currency->code)),
                    'placeholder' => Yii::t('app', 'Payment Amount ' . $currency->currency_symbol),
                    //'prepend' => Yii::app()->settings->get('site', 'currencySymbol'),
                ));
                */?>
            </td>
        </tr>

--><?php /*endforeach; */?>

<?php $this->endWidget(); ?>



<td colspan="3" style='text-align:right'>
    <?php
    echo TbHtml::linkButton(Yii::t('app', 'Complete Sale'), array(
        'color' => TbHtml::BUTTON_COLOR_SUCCESS,
        'icon' => 'glyphicon glyphicon-off white',
        //'url' => Yii::app()->createUrl('SaleItem/CompleteSale/'),
        'class' => 'complete-sale',
        'id' => 'finish_sale_button',
        'title' => Yii::t('app', 'Complete Sale'),
    ));
    ?>
</td>



