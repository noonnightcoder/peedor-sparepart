<!--<link rel="stylesheet" type="text/css" href="<?/*= Yii::app()->basePath */?>views/layouts/receipt/partial/header.css" />-->

<style>
    #sale_return_policy {
        width: 80%;
        margin: 0 auto;
        text-align: center;
    }

    #receipt_wrapper {
        font-family: Arial;
        width: 92% !important;
        font-size: 11px !important;
        margin: 0 auto !important;
        padding: 0 !important;
    }

    #receipt_items td {
        padding: 3px;
    }
</style>

<div class="container" id="receipt_wrapper">

    <?php $this->renderPartial('receipt/partial/header', array(
            'sale_id' => $sale_id,
            'employee_name' => $employee_name,
            'client_name' => $client_name,
            'sale_time' => $sale_time,
    )); ?>

    <?php $this->renderPartial($view_body, array(
        'items' => $items,
        'sub_total' => $sub_total,
        'discount_amount' => $discount_amount,
        'total' => $total,
        'payment_amount' => $payment_amount,
        //'payments' => $payments,
        'amount_due' => $amount_due,
        'currency_type' => $currency_type,
        'sale_infos' => $sale_infos,
        'col_span' => $col_span,
    )); ?>

</div>

<?php $this->renderPartial('receipt/partial/print_js', array('sale_type'=> $sale_type)); ?>
