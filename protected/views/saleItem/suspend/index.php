<?php
$this->breadcrumbs = array(
    Common::saleTitle() => array('index?sale_type=' . Common::getSaleType()),
    'Suspended Sales',
);
?>

<?php $this->renderPartial('partial/search', array(
    'model' => $model,
));
?>

<?php $this->renderPartial('partial/suspend_sale', array(
        'model' => $model,
)); ?>
