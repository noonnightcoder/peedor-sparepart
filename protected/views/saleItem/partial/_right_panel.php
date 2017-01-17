<!-- #right.panel -->
<div class="col-xs-12 col-sm-4 widget-container-col">

    <!-- #section:right.panel.header -->
    <?php $this->renderPartial('partial/_right_panel_header', array(
        'count_item' => $count_item,
    )); ?>
    <!-- #/section:right.panel.header -->

    <!-- #section:right.panel.client -->
    <?php $this->renderPartial('partial/_right_panel_client', array(
        'model' => $model,
        'cust_fullname' => $cust_fullname,
    )); ?>
    <!-- #/section:right.panel.client -->

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
