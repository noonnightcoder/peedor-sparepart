<div id="register_container">

    <?php $this->renderPartial('partial/_left_panel',
        array(
            'model' => $model,
            'items' => $items,
            'disable_editprice' => $disable_editprice,
            'disable_discount' => $disable_discount,
        )); ?>

    <?php  $this->renderPartial('partial/_right_panel', array(
        'model' => $model,
        'count_item' => $count_item,
        'account' => $account,
        'total_discount' => $total_discount,
        'count_item' => $count_item,
        'total_mc' => $total_mc,
        'count_payment' => $count_payment,
        'account' => $account,
        'customer_id' => $customer_id,
        'selected_currency' => $selected_currency,
        'total_due'  => $total_due,
        'payments' => $payments,
    )); ?>

    <?php $this->renderPartial('partial/_js', array('first_load' => $first_load)); ?>

</div>
