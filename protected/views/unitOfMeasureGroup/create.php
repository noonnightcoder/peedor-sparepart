<?php
/* @var $this UnitOfMeasureGroupController */
/* @var $model UnitOfMeasureGroup */

$this->breadcrumbs=array(
	'Unit Of Measure Groups'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UnitOfMeasureGroup', 'url'=>array('index')),
	array('label'=>'Manage UnitOfMeasureGroup', 'url'=>array('admin')),
);
?>

<h1>Create UnitOfMeasureGroup</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>