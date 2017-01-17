<?php
$this->breadcrumbs=array(
	'Whole Sale'=>array('index'),
	'Incomplete',
);
?>

<?php
Yii::app()->clientScript->registerScript('search', "
$('.search-form form').submit(function(){
    $.fn.yiiGridView.update('sale-suspended-grid', {
            data: $(this).serialize()
    });
    return false;
});
");
?>

<?php echo $search; ?>

<?php if(Yii::app()->user->hasFlash('success')):?>
    <?php $this->widget('bootstrap.widgets.TbAlert'); ?>
<?php endif; ?>

<?php $this->renderPartial('//layouts/alert/_flash'); ?>
    
<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
              'title' =>Yii::t('app','List Of On-going Sales'),
              'headerIcon' => 'ace-icon fa fa-list',
              'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
));?>

<div class="search-form">
    <?php $this->renderPartial('_suspend_sale_search',array(
            'model'=>$model,
    )); ?>
</div>
    
<?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
	'id'=>'sale-suspended-grid',
        'fixedHeader' => true,
        //'responsiveTable' => true,
        'type'=>TbHtml::GRID_TYPE_HOVER,
	'dataProvider'=>$model->ListSuspendSale(),
        'summaryText' =>'', 
        'htmlOptions'=>array('class'=>'table-responsive panel'),
	'columns'=>array(
		array('name'=>'sale_id',
                      'header'=>Yii::t('app','Invoice ID'),
                      'value'=>'$data["sale_id"]',
                ),
                array('name'=>'client_id',
                      'header'=>Yii::t('app','Customer Name'), 
                      'value'=>'$data["client_id"]',
                ),
                array('name'=>'sale_time',
                      'header'=>Yii::t('app','Sale Time'),
                      'value'=>'$data["sale_time"]',
                ),
                array('name'=>'items',
                      'header'=>Yii::t('app','Items'), 
                      'value'=>'$data["items"]',
                ),
                array('name'=>'Unsuspend',
                      'header'=>Yii::t('app','Action'), 
                      'value'=>'CHtml::link("Continue Sale", Yii::app()->createUrl("wholeSale/UnsuspendSale",array("sale_id"=>$data["sale_id"])), 
                                array("class"=>"btn btn-info btn-xs"))',
                      'type'=>'raw',
                ),
                array('name'=>'Delete',
                      'value'=>'CHtml::link("Delete", Yii::app()->createUrl("wholeSale/DeleteSale",array("sale_id"=>$data["sale_id"])),
                                array("class"=>"btn btn-danger btn-xs"))',
                      'type'=>'raw',
                ),
	)
)); ?>  

<?php $this->endWidget(); ?>