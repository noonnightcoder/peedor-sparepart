<style>
.btn-group {
  display: flex !important;
}
</style>

<?php
    $this->breadcrumbs=array(
    Yii::t('app','Price Tier')=>array('admin'),
    Yii::t('app','Manage'),
    );
?>

<div class="row" id="pricetier_cart">

    <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
                  'title' => Yii::t('app','List of Price Tier'),
                  'headerIcon' => 'ace-icon fa fa-list',
                  'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
    )); ?>

        <?php

        Yii::app()->clientScript->registerScript('search', "
        $('.search-button').click(function(){
                $('.search-form').toggle();
                return false;
        });
        $('.search-form form').submit(function(){
                $('#price-tier-grid').yiiGridView('update', {
                        data: $(this).serialize()
                });
                return false;
        });
        ");
        ?>

        <?php $this->widget('ext.modaldlg.EModalDlg'); ?>

        <div class="page-header">
            <!-- Admin Header layouts.admin._header -->
            <?php $this->renderPartial('//layouts/admin/_header',array(
                'model' => $model,
                'check_access' => 'item.create',
                'create_url' => 'create',
                'class' => 'update-dialog-open-link',
                'grid_id' => 'price-tier-grid',
                'modal_title' => 'New Price Tier',
            ));?>

            &nbsp;&nbsp;

            <?php echo CHtml::activeCheckBox($model, 'archived', array(
                'value' => 1,
                'uncheckValue' => 0,
                'checked' => ($model->archived == 'false') ? false : true,
                'onclick' => "$.fn.yiiGridView.update('price-tier-grid',{data:{archived:$(this).is(':checked')}});"
            )); ?>
            Show archived/deleted <?= Yii::t('app','Price Tier'); ?>
        </div>


        <!-- Flash message layouts.partial._flash_message -->
        <?php $this->renderPartial('//layouts/alert/_flash'); ?>


        <?php
        $pageSizeDropDown = CHtml::dropDownList(
            'pageSize',
            Yii::app()->user->getState('pageSizePriceTier', Common::defaultPageSize()) ,
            Common::arrayFactory('page_size'),
            array(
                'class' => 'change-pagesize',
                'onchange' => "$.fn.yiiGridView.update('price-tier-grid',{data:{pageSize:$(this).val()}});",
            )
        );
        ?>


        <?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
                'id'=>'price-tier-grid',
                'type' => TbHtml::GRID_TYPE_HOVER,
                'fixedHeader' => true,
                'template' => "{items}\n{summary}\n{pager}",
                'summaryText' => 'Showing {start}-{end} of {count} entries ' . $pageSizeDropDown . ' rows per page',
                'htmlOptions' => array('class' => 'table-responsive panel'),
                'dataProvider'=>$model->search(),
                //'filter'=>$model,
                'columns'=>array(
                        //'id',
                        'tier_name',
                        array('name'=>'status',
                            'type'=>'raw',
                            'value'=>'$data->status==1 ? TbHtml::labelTb("Activated", array("color" => TbHtml::LABEL_COLOR_SUCCESS)) : TbHtml::labelTb("De-Activated", array("color" => TbHtml::LABEL_COLOR_WARNING))',
                        ),
                        'description',
                        'sort_order',
                        'created_at',
                        array(
                            'class'=>'bootstrap.widgets.TbButtonColumn',
                            'header'=> Yii::t('app','Edit'),
                            'template'=>'<div class="btn-group">{update}{delete}{undeleted}</div>',
                            //'htmlOptions'=>array('class'=>'btn-group'),
                            'buttons' => array(
                                'update' => array(
                                  'click' => 'updateDialogOpen',
                                  'label'=>'Update Price Tier',
                                  'icon'=>'ace-icon fa fa-edit',
                                  'options' => array(
                                      'data-update-dialog-title' => Yii::t('app','Update Price Tier'),
                                      'data-refresh-grid-id'=>'supplier-grid',
                                      'class'=>'btn btn-xs btn-primary',
                                    ),
                                ),
                                'delete' => array(
                                    'label'=>Yii::t('app','Delete Price Tier'),
                                    'options' => array(
                                        'data-update-dialog-title' => Yii::t('app','Update Item'),
                                        'titile'=>'Edit Item',
                                        'class'=>'btn btn-xs btn-danger',
                                    ),
                                    'visible'=>'$data->status=="1" && Yii::app()->user->checkAccess("item.delete")',
                                ),
                                'undeleted' => array(
                                    'label'=>Yii::t('app','Restore Price Tier'),
                                    'url'=>'Yii::app()->createUrl("PriceTier/UndoDelete", array("id"=>$data->id))',
                                    'icon'=>'bigger-120 glyphicon-refresh',
                                    'options' => array(
                                        'class'=>'btn btn-xs btn-warning btn-undodelete',
                                    ),
                                    'visible'=>'$data->status=="0" && Yii::app()->user->checkAccess("item.delete")',
                                ),
                             ),
                        ),
                ),
        )); ?>

    <?php $this->endWidget(); ?>

</div>

<?php $this->renderPartial('//layouts/admin/_footer',array(
    'main_div_id' => 'pricetier_cart',
    'grid_id' => 'price-tier-grid',
));?>
