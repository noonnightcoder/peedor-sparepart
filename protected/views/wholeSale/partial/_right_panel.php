<!-- #right.panel -->
<div class="col-xs-12 col-sm-4 widget-container-col">

    <!-- #section:right.panel.header -->
    <?php $this->renderPartial('partial/_right_panel_header', array(
        'count_item' => $count_item,
    )); ?>
    <!-- #/section:right.panel.header -->

    <!-- #section:right.panel.client -->
    <?php  $this->renderPartial('partial/_right_panel_client', array(
        'model' => $model,
        'account' => $account,
        'customer_id' => $customer_id,
    )); ?>
    <!-- #/section:right.panel.client -->

    <!-- #section:right.panel.payment -->
    <?php $this->renderPartial('partial/_right_panel_payment', array(
        'model' => $model,
        'count_item' => $count_item,
        'total_discount' => $total_discount,
        'total_mc' => $total_mc,
        'count_payment' => $count_payment,
        'account' => $account,
        'selected_currency' => $selected_currency,
        'total_due'  => $total_due,
        'payments' => $payments,
    )); ?>
    <!-- #/section:right.panel.payment -->

</div> <!-- /right.panel -->
