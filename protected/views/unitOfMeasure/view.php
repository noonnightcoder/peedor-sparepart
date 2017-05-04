<?php
/* @var $this UnitOfMeasureController */
/* @var $model UnitOfMeasure */

$this->breadcrumbs=array(
	'Unit Of Measures'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List UnitOfMeasure', 'url'=>array('index')),
	array('label'=>'Create UnitOfMeasure', 'url'=>array('create')),
	array('label'=>'Update UnitOfMeasure', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete UnitOfMeasure', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage UnitOfMeasure', 'url'=>array('admin')),
);
?>

<h1>View UnitOfMeasure #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'uom_code',
		'uom_name',
		'length',
		'width',
		'height',
		'volume',
		'volume_uom',
		'weight',
		'status',
		'created_at',
		'updated_at',
		'deleted_at',
		'created_by',
		'updated_by',
		'deleted_by',
	),
)); ?>
