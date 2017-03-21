<!-- #section:left.panel-->
<div class="col-xs-12 col-sm-8 widget-container-col">
    <?php $this->renderPartial('//layouts/alert/_flash'); ?>

    <!-- #section:left.panel.header-->
    <?php $this->renderPartial('partial/_left_panel_header', array('model' => $model,)); ?>
    <!-- /section:left.panel.header-->

    <!-- #section:left.panel.grid.cart-->
    <?php if (Common::getSaleType()=='R') { ?>

        <?php $this->renderPartial('partial/_left_panel_cart_retail', array('model' => $model, 'items' => $items)); ?>

    <?php } else { ?>

        <?php $this->renderPartial('partial/_left_panel_cart_wsale', array('model' => $model, 'items' => $items)); ?>

    <?php } ?>

    <!-- /section:left.panel.grid.cart -->

    <?php $this->renderPartial('//layouts/alert/_keyboard_help') ?>


</div>
<!-- /section:left.panel -->
