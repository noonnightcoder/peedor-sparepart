<?php
/* @var $this GroupDefinitionController */
/* @var $model GroupDefinition */

$this->breadcrumbs=array(
	'Group Definitions'=>array('index'),
	$model->id,
);

$this->menu=array(
	array('label'=>'List GroupDefinition', 'url'=>array('index')),
	array('label'=>'Create GroupDefinition', 'url'=>array('create')),
	array('label'=>'Update GroupDefinition', 'url'=>array('update', 'id'=>$model->id)),
	array('label'=>'Delete GroupDefinition', 'url'=>'#', 'linkOptions'=>array('submit'=>array('delete','id'=>$model->id),'confirm'=>'Are you sure you want to delete this item?')),
	array('label'=>'Manage GroupDefinition', 'url'=>array('admin')),
);
?>

<h1>View GroupDefinition #<?php echo $model->id; ?></h1>

<?php $this->widget('zii.widgets.CDetailView', array(
	'data'=>$model,
	'attributes'=>array(
		'id',
		'alt_qty',
		'alt_uom_id',
		'base_qty',
		'base_uom_id',
		'created_at',
		'updated_at',
		'deleted_at',
		'created_by',
		'updated_by',
		'deleted_by',
	),
)); ?>
