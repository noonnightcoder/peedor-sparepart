<style>
    .btn-group {
        display: flex !important;
    }
</style>
<?php
$this->breadcrumbs = array(
    Yii::t('menu', 'Item') => array('admin'),
    Yii::t('app', 'Manage'),
);
?>
<div class="row" id="item_cart">
    <div class="col-xs-12 widget-container-col ui-sortable">
        <?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
            'title' => Yii::t('app', 'List of Items'),
            'headerIcon' => 'ace-icon fa fa-list',
            'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
        )); ?>

            <?php
            Yii::app()->clientScript->registerScript('search', "
            $('.search-button').click(function(){
                $('.search-form').toggle();
                return false;
            });
            $('.search-form form').submit(function(){
                $.fn.yiiGridView.update('item-grid', {
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
                    'create_url' => 'createImage',
                    'grid_id' => 'item-grid',
                    'module_name' => 'Item',
                ));?>

                &nbsp;&nbsp;

                <?php echo CHtml::activeCheckBox($model, 'item_archived', array(
                    'value' => 1,
                    'uncheckValue' => 0,
                    'checked' => ($model->item_archived == 'false') ? false : true,
                    'onclick' => "$.fn.yiiGridView.update('item-grid',{data:{archivedItem:$(this).is(':checked')}});"
                )); ?>
                Show archived/deleted Item
            </div>


            <!-- Flash message layouts.partial._flash_message -->
            <?php $this->renderPartial('//layouts/alert/_flash'); ?>

            <?php
            $pageSizeDropDown = CHtml::dropDownList(
                'pageSize',
                Yii::app()->user->getState('pageSize', Common::defaultPageSize()) ,
                Common::arrayFactory('page_size'),
                array(
                    'class' => 'change-pagesize',
                    'onchange' => "$.fn.yiiGridView.update('item-grid',{data:{pageSize:$(this).val()}});",
                )
            );
            ?>

            <?php $this->widget('yiiwheels.widgets.grid.WhGridView', array(
                'id' => 'item-grid',
                'fixedHeader' => true,
                'type' => TbHtml::GRID_TYPE_HOVER,
                'template' => "{items}\n{summary}\n{pager}",
                'summaryText' => 'Showing {start}-{end} of {count} entries ' . $pageSizeDropDown . ' rows per page',
                'htmlOptions' => array('class' => 'table-responsive panel'),
                'dataProvider' => $model->search(),
                'filter' => $model,
                'columns' => array(
                    array(
                        'name' => 'item_number',
                        'value' => '$data->status=="1" ? $data->item_number : "<s class=\"red\">  $data->item_number </s>" ',
                        'filter' => '',
                        'type' => 'raw',
                    ),
                    array(
                        'name' => 'currency',
                        'value' => '$data->currency->currency_symbol',
                        'filter' => '',
                    ),
                    array(
                        'name' => 'name',
                        'value' => '$data->status=="1" ? CHtml::link($data->name, Yii::app()->createUrl("item/updateImage",array("id"=>$data->primaryKey))) : "<s class=\"red\">  $data->name </s>" ',
                        'type' => 'raw',
                    ),
                    array(
                        'name' => 'author_id',
                        'value' => '$data->author_id==null? " " : $data->author->author_name',
                        'filter' =>  CHtml::listData(Author::model()->findAll(array('order'=>'author_name')), 'id', 'author_name'),
                    ),
                    /*
                    array('name'=>'description',
                          'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                          'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                    ),
                     *
                    */
                    array(
                        'name' => 'location',
                        'filter' => '',
                    ),
                    array(
                        'name' => 'category_id',
                        'value' => '$data->category_id==null? " " : $data->category->name',
                        'filter' =>  CHtml::listData(Category::model()->findAll(array('order'=>'name')), 'id', 'name'),
                    ),
                    /*
                    array('name'=>'supplier_id',
                                  'value'=>'($data->supplier_id==null || $data->supplier_id==0)? "N/A" : $data->supplier->company_name'
                            ),
                    */
                    /*
                    array('name'=>'cost_price',
                          'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs hidden-md'),
                          'htmlOptions'=>array('class' => 'hidden-480 hidden-xs hidden-md'),
                    ),
                     *
                    */
                    /*
                    array('name'=>'unit_price',
                          'header'=>'Sell-Price',
                    ),
                     *
                    */
                    array(
                        'name' => 'quantity',
                        'filter' => '',
                        'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs hidden-md'),
                        'htmlOptions'=>array('class' => 'hidden-480 hidden-xs hidden-md'),
                    ),
                    /*array(
                        'name' => 'status',
                        'type' => 'raw',
                        'value' => '$data->status==1 ? TbHtml::labelTb("Active", array("color" => TbHtml::LABEL_COLOR_SUCCESS)) : TbHtml::labelTb("De-Activated", array("color" => TbHtml::LABEL_COLOR_WARNING))',
                        'filter' => '',
                    ),*/
                    array(
                        'class' => 'bootstrap.widgets.TbButtonColumn',
                        'template' => '<div class="btn-group">{detail}{cost}{price}{delete}{undeleted}</div>',
                        'buttons' => array(
                            'detail' => array(
                                'click' => 'updateDialogOpen',
                                'label' => Yii::t('app', 'Stock'),
                                'url' => 'Yii::app()->createUrl("Inventory/admin", array("item_id"=>$data->id))',
                                'options' => array(
                                    'data-toggle' => 'tooltip',
                                    'data-update-dialog-title' => Yii::t('app','Stock History'),
                                    'class' => 'btn btn-xs btn-pink',
                                    'title' => Yii::t('app','Stock History'),
                                ),
                                'visible' => '$data->status=="1"',
                            ),
                            'cost' => array(
                                'click' => 'updateDialogOpen',
                                'label' => Yii::t('app', 'Cost'),
                                'url' => 'Yii::app()->createUrl("Item/CostHistory", array("item_id"=>$data->id))',
                                'options' => array(
                                    'data-update-dialog-title' => Yii::t('app', 'Cost History'),
                                    'class' => 'btn btn-xs btn-info',
                                    'title' => Yii::t('app', 'Cost History'),
                                ),
                                'visible' => '$data->status=="1" && ( Yii::app()->user->checkAccess("item.create") || Yii::app()->user->checkAccess("item.update") )',
                            ),
                            'price' => array(
                                'click' => 'updateDialogOpen',
                                //'label'=>"<span class='text-info'>" . Yii::t('app','Price') . "</span><i class='icon-info-sign'></i> ",
                                'label' => Yii::t('app', 'Price'),
                                'url' => 'Yii::app()->createUrl("Item/PriceHistory", array("item_id"=>$data->id))',
                                'options' => array(
                                    'data-update-dialog-title' => Yii::t('app', 'Price History'),
                                    'class' => 'btn btn-xs btn-success',
                                    'title' => Yii::t('app', 'Price History'),
                                ),
                                'visible' => '$data->status=="1" && ( Yii::app()->user->checkAccess("item.create") || Yii::app()->user->checkAccess("item.update") )',
                            ),
                            /*
                            'edit' => array(
                              'label'=>Yii::t('app','Edit Item'),
                              'url'=>'Yii::app()->createUrl("Item/UpdateImage", array("id"=>$data->id))',
                              'icon'=>'bigger-120 ace-icon fa fa-edit',
                              'visible'=>'Yii::app()->user->checkAccess("item.update")',
                              'options' => array(
                                  'class' => 'btn btn-xs btn-info',
                              )
                            ),
                             *
                            */
                            'delete' => array(
                                'label' => Yii::t('app', 'Delete'),
                                'icon' => 'bigger-120 glyphicon-trash',
                                'options' => array(
                                    'class' => 'btn btn-xs btn-danger',
                                ),
                                'visible' => '$data->status=="1" && Yii::app()->user->checkAccess("item.delete")',
                            ),
                            'undeleted' => array(
                                'label' => Yii::t('app', 'Undo Delete'),
                                'url' => 'Yii::app()->createUrl("Item/UndoDelete", array("id"=>$data->id))',
                                'icon' => 'bigger-120 glyphicon-refresh',
                                'options' => array(
                                    'class' => 'btn btn-xs btn-warning btn-undodelete',
                                    'title' => Yii::t('app', 'Undo Delete'),
                                ),
                                'visible' => '$data->status=="0" && Yii::app()->user->checkAccess("item.delete")',
                            ),
                        ),
                    ),
                ),
            )); ?>

        <?php $this->endWidget(); ?>

    </div>
</div>

<?php $this->renderPartial('//layouts/admin/_footer',array(
    'main_div_id' => 'item_cart',
    'grid_id' => 'item-grid',
));?>
