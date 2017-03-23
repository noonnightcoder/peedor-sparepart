<div id="register_container">
    <?php echo 'Customer ID : ' . Common::getCustomerID() .  "<br>" ?>
    <?php echo' Price Tier HTML Value : ' . Common::priceTierDisable() . "<br>" ?>

    <?php $this->renderPartial('partial/_left_panel',
        array(
            'model' => $model,
            'items' => $items,
        )); ?>

    <?php $this->renderPartial('partial/_right_panel', array(
        'model' => $model,
        'count_item' => $count_item,
        'customer_name' => $customer_name,
        'account' => $account,
        'total_discount' => $total_discount,
        'total_kh' => $total_kh,
        'count_payment' => $count_payment,
        'payments' => $payments,
        'amount_change' => $amount_change,
    ));?>

    <?php $this->renderPartial('partial/_js'); ?>

</div>
