<?php $this->renderPartial('//layouts/alert/_flash'); ?>
    
<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
              'title' =>Yii::t('app','List Of Suspended ' . Common::saleTitle() ),
              'headerIcon' => 'icon-list fa fa-bookmark ',
              'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
));?>

<?php $this->widget('yiiwheels.widgets.grid.WhGridView', array(
    'id' => 'sale-suspended-grid',
    //'fixedHeader' => true,
    'responsiveTable' => true,
    'type' => TbHtml::GRID_TYPE_HOVER,
    'dataProvider' => $model->ListSuspendSale(),
    'summaryText' => '',
    'columns' => array(
        array('name' => 'sale_id',
            'header' => Yii::t('app', 'Suspended Invoice ID'),
            'value' => '$data["sale_id"]',
        ),
        array('name' => 'sale_time',
            'header' => Yii::t('app', 'Sale Time'),
            'value' => '$data["sale_time"]',
        ),
        array('name' => 'client_name',
            'header' => Yii::t('app', 'Customer Name'),
            'value' => '$data["client_name"]',
        ),
        array('name' => 'items',
            'header' => Yii::t('app', 'Items'),
            'value' => '$data["items"]',
        ),
        array('name' => 'Unsuspend',
            'value' => 'CHtml::link("Unsuspend", Yii::app()->createUrl("SaleItem/UnsuspendSale",array("sale_id"=>$data["sale_id"],"client_id"=>$data["client_id"])),
                                array("class"=>"btn btn-info btn-xs"))',
            'type' => 'raw',
        ),
        array('name' => 'Delete',
            'value' => 'CHtml::link("Delete", Yii::app()->createUrl("SaleItem/DeleteSale",array("sale_id"=>$data["sale_id"])),
                                array("class"=>"btn btn-danger btn-xs"))',
            'type' => 'raw',
        ),
    ),
)); ?>  

<?php $this->endWidget(); ?>