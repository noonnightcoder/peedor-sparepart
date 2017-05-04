<?php
/* @var $this UnitOfMeasureController */
/* @var $model UnitOfMeasure */

$this->breadcrumbs=array(
	'Unit Of Measures'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List UnitOfMeasure', 'url'=>array('index')),
	array('label'=>'Manage UnitOfMeasure', 'url'=>array('admin')),
);
?>

<h1>Create UnitOfMeasure</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>