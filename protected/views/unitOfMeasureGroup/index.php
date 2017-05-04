<?php
/* @var $this UnitOfMeasureGroupController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Unit Of Measure Groups',
);

$this->menu=array(
	array('label'=>'Create UnitOfMeasureGroup', 'url'=>array('create')),
	array('label'=>'Manage UnitOfMeasureGroup', 'url'=>array('admin')),
);
?>

<h1>Unit Of Measure Groups</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
