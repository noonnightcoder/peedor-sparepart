<!-- #right.panel -->
<div class="col-xs-12 col-sm-4 widget-container-col">

    <!-- #section:right.panel.header -->
    <?php $this->renderPartial('partial/_right_panel_header', array(
        'count_item' => $count_item,
    )); ?>
    <!-- #/section:right.panel.header -->

    <?php if (Common::getSaleType()=='W') { ?>
        <!-- #section:right.panel.client -->
        <?php $this->renderPartial('partial/_right_panel_client', array(
            'model' => $model,
            'customer_name' => $customer_name,
            'account' => $account,
        )); ?>
        <!-- #/section:right.panel.client -->
    <?php } ?>

    <!-- #section:right.panel.payment -->
    <?php $this->renderPartial('partial/_right_panel_payment', array(
        'model' => $model,
        'count_item' => $count_item,
        'total_discount' => $total_discount,
        'total_kh' => $total_kh,
        'count_payment' => $count_payment,
        'payments' => $payments,
        'amount_change' => $amount_change,
    )); ?>
    <!-- #/section:right.panel.payment -->

</div> <!-- /right.panel -->
