<!-- #section:left.panel-->
<div class="col-xs-12 col-sm-8 widget-container-col">
    <?php $this->renderPartial('//layouts/alert/_flash'); ?>
    <!-- #section:left.panel.header-->
    <?php $this->renderPartial('partial/_left_panel_header', array(
        'model' => $model,
        'items' => $items,
        'receive_id' => $receive_id,
        'trans_header' => Yii::t('menu', $trans_header)
    )); ?>
    <!-- /section:left.panel.header-->

    <!-- #section:left.panel.grid.cart-->
    <?php $this->renderPartial('partial/_left_panel_grid_cart',
        array(
            'model' => $model,
            'items' => $items,
            'hide_editcost' => $hide_editcost,
            'hide_editprice' => $hide_editprice,
        )); ?>
    <!-- /section:left.panel.grid.cart -->

</div>
<!-- /section:left.panel -->
