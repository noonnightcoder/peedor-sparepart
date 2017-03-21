<div id="register_container">

    <?= Common::getPriceTierID() . ' Sale Type : ' . Common::getSaleType() . ' Price Tier HTML Value ' . Common::priceTierDisable() ?>

    <?php $this->renderPartial('partial/_left_panel',
        array(
            'model' => $model,
            'items' => $items,
        )); ?>

    <?php $this->renderPartial('partial/_right_panel', array(
        'model' => $model,
        'count_item' => $count_item,
        'cust_fullname' => $cust_fullname,
        'acc_balance' => $acc_balance,
        'total_discount' => $total_discount,
        'total_kh' => $total_kh,
        'count_payment' => $count_payment,
        'payments' => $payments,
        'amount_change' => $amount_change,
    ));?>

    <?php $this->renderPartial('partial/_js'); ?>

</div>
