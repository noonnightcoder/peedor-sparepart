<!-- PAGE CONTENT ENDS -->
<div id="register_container">
    <!--left.panel-->
    <?php $this->renderPartial('partial/_left_panel',
        array(
            'model' => $model,
            'trans_header' => $trans_header,
            'hide_editcost' => $hide_editcost,
            'hide_editprice' => $hide_editprice,
            'expiredate_class' => $expiredate_class,
            'items' => $items,
            'receive_id' => $receive_id,
            'discount_symbol' => $discount_symbol,
        )); ?>
    <!--/left.panel-->

    <!--right.panel-->
    <?php $this->renderPartial('partial/_right_panel',
        array(
            'model' => $model,
            'supplier' => $supplier,
            'count_item' => $count_item,
            'trans_mode' => $trans_mode,
            'discount_amount' => $discount_amount,
            'total' => $total,
            'total_mc' => $total_mc,
            'items' => $items,
        )); ?>
    <!--/right.panel-->
    <?php //$this->renderPartial('partial/_js'); ?>
<div class="waiting"><!-- Place at bottom of page --></div>

