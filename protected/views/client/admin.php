<style>
    .btn-group {
        display: flex !important;
    }
</style>

<?php
$this->breadcrumbs = array(
    Yii::t('app', 'Customer') => array('admin'),
    Yii::t('app', 'Manage'),
);
?>
<div class="row" id="client_cart">
    <div class="col-xs-12 widget-container-col ui-sortable  ">
        <?php
        Yii::app()->clientScript->registerScript('search', "
        $('.search-button').click(function(){
                $('.search-form').toggle();
                return false;
        });
        $('.search-form form').submit(function(){
                $.fn.yiiGridView.update('client-grid', {
                        data: $(this).serialize()
                });
                return false;
        });
        ");
        ?>

        <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
            'title' => Yii::t('app', 'List of Customers'),
            'headerIcon' => 'ace-icon fa fa-user',
            'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
        )); ?>

            <div class="page-header">

                <!-- Admin Header layouts.admin._header -->
                <?php $this->renderPartial('//layouts/admin/_header',array(
                    'model' => $model,
                    'check_access' => 'client.create',
                    'create_url' => 'create',
                    'grid_id' => 'client-grid',
                    'module_name' => 'Client',
                ));?>

                &nbsp;&nbsp;

                <?php echo CHtml::activeCheckBox($model, 'client_archived', array(
                    'value' => 1,
                    'uncheckValue' => 0,
                    'checked' => ($model->client_archived == 'false') ? false : true,
                    'onclick' => "$.fn.yiiGridView.update('client-grid',{data:{archivedClient:$(this).is(':checked')}});"
                )); ?>

                Show archived/deleted Customer

            </div>

            <!-- Flash message layouts.partial._flash_message -->
            <?php $this->renderPartial('//layouts/alert/_flash'); ?>

            <?php
            $pageSizeDropDown = CHtml::dropDownList(
                'pageSize',
                $pageSize = Yii::app()->user->getState('clientpageSize', Common::defaultPageSize()),
                Common::arrayFactory('page_size'),
                array(
                    'class' => 'change-pagesize',
                    'onchange' => "$.fn.yiiGridView.update('client-grid',{data:{pageSize:$(this).val()}});",
                )
            );
            ?>


            <?php $this->widget('yiiwheels.widgets.grid.WhGridView', array(
            'id' => 'client-grid',
            'fixedHeader' => true,
            'type' => TbHtml::GRID_TYPE_HOVER,
            //'headerOffset' => 40,
            //'responsiveTable' => true,
            'template' => "{items}\n{summary}\n{pager}",
            'summaryText' => 'Showing {start}-{end} of {count} entries ' . $pageSizeDropDown . ' rows per page',
            'htmlOptions' => array('class' => 'table-responsive panel'),
            'dataProvider' => $model->search(),
            'columns' => array(
                /*
                array(
                    'class' => 'yiiwheels.widgets.grid.WhRelationalColumn',
                    //'name' => 'sale_id',
                    //'header'=>Yii::t('app','+'),
                    'url' => $this->createUrl('SalePayment/PaymentDetail'),
                    'value' => '$data->first_name',
                ),
                 *
                */
                array(
                    'name' => 'first_name',
                    'value' => '$data->status=="1" ? CHtml::link($data->first_name, Yii::app()->createUrl("client/update",array("id"=>$data->primaryKey))) : "<span class=\"text-muted\">  $data->first_name <span>" ',
                    'type' => 'raw',
                ),
                array(
                    'name' => 'last_name',
                    'value' => '$data->status=="1" ? CHtml::link($data->last_name, Yii::app()->createUrl("client/update",array("id"=>$data->primaryKey))) : "<span class=\"text-muted\">  $data->last_name <span>" ',
                    'type' => 'raw',
                ),
                array(
                    'name' => 'mobile_no',
                    'value' => '$data->status=="1" ? $data->mobile_no : "<span class=\"text-muted\">  $data->mobile_no <span>"',
                    'type' => 'raw',
                ),
                array(
                    'name' => 'address1',
                    'value' => '$data->status=="1" ? $data->address1 : "<span class=\"text-muted\">  $data->address1 <span>"',
                    'type' => 'raw',
                ),
                /*array(
                    'name' => 'balance',
                    'header' => 'Balance',
                    'value' => array($this, "gridBalance"),
                    'visible' => Yii::app()->user->checkAccess("payment.index"),
                    'type' => 'raw',
                ),*/
            ),
        )); ?>

        <?php $this->endWidget(); ?>
    </div>
</div>

<?php $this->renderPartial('//layouts/admin/_footer',array(
    'main_div_id' => 'client_cart',
    'grid_id' => 'client-grid',
));?>