<?php
/* @var $this UnitOfMeasureGroupController */
/* @var $model UnitOfMeasureGroup */

$this->breadcrumbs=array(
	'Unit Of Measure Groups'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UnitOfMeasureGroup', 'url'=>array('index')),
	array('label'=>'Create UnitOfMeasureGroup', 'url'=>array('create')),
	array('label'=>'Update UnitOfMeasureGroup', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete UnitOfMeasureGroup', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UnitOfMeasureGroup', 'url'=>array('admin')),
);
?>

<h1>View UnitOfMeasureGroup #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'uom_code',
		'uom_name',
		'status',
		'created_at',
		'updated_at',
		'deleted_at',
		'created_by',
		'updated_by',
		'deleted_by',
	),
)); ?>
