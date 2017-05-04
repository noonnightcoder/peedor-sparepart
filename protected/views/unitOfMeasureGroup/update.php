<?php
/* @var $this UnitOfMeasureGroupController */
/* @var $model UnitOfMeasureGroup */

$this->breadcrumbs=array(
	'Unit Of Measure Groups'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UnitOfMeasureGroup', 'url'=>array('index')),
	array('label'=>'Create UnitOfMeasureGroup', 'url'=>array('create')),
	array('label'=>'View UnitOfMeasureGroup', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage UnitOfMeasureGroup', 'url'=>array('admin')),
);
?>

<h1>Update UnitOfMeasureGroup <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>