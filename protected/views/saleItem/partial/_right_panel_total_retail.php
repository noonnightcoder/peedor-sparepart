<?php
$form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
    'id' => 'finish_sale_form',
    'action' => Yii::app()->createUrl('saleItem/completeSale/'),
    'enableAjaxValidation' => false,
    'layout' => TbHtml::FORM_LAYOUT_INLINE,
));
?>

<?php foreach (SaleOrder::model()->getAllTotalKH() as $record): ?>
    <?php
        $amount_change = $record['amount_change'];
        $count_payment = $record['count_payment'];
        $amount_change_css = $amount_change <=0 ? 'badge badge-success bigger-120' : 'badge badge-danger bigger-120'
    ?>
    <tr>
        <td><?= Yii::t('app','Sub Total')  ?> </td>
        <td>
            <span class="badge badge-info bigger-120">
                <?= Common::getCurrencySymbol() . number_format($record['sub_total'],0,'.',',') ?>
            </span>
        </td>
    </tr>
    <tr>
        <td><?= Yii::t('app','Discount Amount')  ?> </td>
        <td>
            <span class="badge badge-info bigger-120">
                <?= Common::getCurrencySymbol() . number_format($record['discount_amount'],0,'.',',') ?>
            </span>
        </td>
    </tr>
    <tr>
        <td><?= Yii::t('app','Total')  ?> </td>
        <td>
            <span class="badge badge-info bigger-120">
                <?= Common::getCurrencySymbol() . number_format($record['total'],0,'.',',') ?>
            </span>
        </td>
    </tr>
    <?php if ($count_payment > 0) { ?>
    <tr>
        <td>
            <?= Yii::t('app','Paid Amount') . ' ['  . $record['payment_type'] . ']' ?>
            <?php
            echo TbHtml::linkButton('', array(
                'size' => TbHtml::BUTTON_SIZE_MINI,
                'color' => TbHtml::BUTTON_COLOR_DANGER,
                'icon' => 'glyphicon-remove',
                'url' => Yii::app()->createUrl('SaleItem/DeletePayment', array('payment_id' => $record['payment_id'])),
                'class' => 'delete-payment pull-right',
                'title' => Yii::t('app', 'Delete Payment'),
            ));
            ?>
        </td>
        <td>
            <span class="badge badge-info bigger-120">
                <?= Common::getCurrencySymbol() . number_format($record['payment_amount'],0,'.',',') ?>
            </span>
        </td>
    </tr>
    <tr>
        <td><?= Yii::t('app','Change')  ?> </td>
        <td>
            <span class="<?= $amount_change_css ?>">
                <?= Common::getCurrencySymbol() . number_format($record['amount_change'],0,'.',',') ?>
            </span>
        </td>
    </tr>
    <?php } ?>
<?php endforeach; ?>

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
        <td colspan="2" style='text-align:right'>
            <?php echo TbHtml::linkButton(Yii::t('app', 'Add Payment'), array(
                'color' => TbHtml::BUTTON_COLOR_INFO,
                'size' => TbHtml::BUTTON_SIZE_MINI,
                'icon' => 'glyphicon-plus white',
                'url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
                'class' => 'add-payment',
                'title' => Yii::t('app', 'Add Payment'),
            ));
            ?>
        </td>
    </tr>
<?php } ?>

<?php $this->endWidget(); ?>

<?php if ($amount_change <= 0) { ?>
    <table class="table table-striped table-condensed">
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
    </table>
<?php } ?>



