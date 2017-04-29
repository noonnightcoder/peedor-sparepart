<?php $this->renderPartial('//layouts/alert/_flash'); ?>
    
<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
              'title' =>Yii::t('app','List Of Suspended Transaction'),
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
        array('name' => 'receive_id',
            'header' => Yii::t('app', 'Suspended Invoice ID'),
            'value' => '$data["receive_id"]',
        ),
        array('name' => 'receive_time',
            'header' => Yii::t('app', 'Receive Time'),
            'value' => '$data["receive_time"]',
        ),
        array('name' => 'supplier_name',
            'header' => Yii::t('app', 'Supplier Name'),
            'value' => '$data["supplier_name"]',
        ),
        array('name' => 'items',
            'header' => Yii::t('app', 'Items'),
            'value' => '$data["items"]',
        ),
        array('name' => 'Unsuspend',
            'value' => 'CHtml::link("Unsuspend", Yii::app()->createUrl("ReceivingItem/UnsuspendRecv",array("receive_id"=>$data["receive_id"],"supplier_id"=>$data["supplier_id"])),
                                array("class"=>"btn btn-info btn-xs"))',
            'type' => 'raw',
        ),
        /*array('name' => 'Delete',
            'value' => 'CHtml::link("Delete", Yii::app()->createUrl("receivingItem/deleteTrans",array("receive_id"=>$data["receive_id"])),
                                array("class"=>"btn btn-danger btn-xs"))',
            'type' => 'raw',
        ),*/
    ),
)); ?>  

<?php $this->endWidget(); ?>