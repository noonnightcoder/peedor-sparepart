<?php
/* @var $this UnitOfMeasureController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Unit Of Measures',
);

$this->menu=array(
	array('label'=>'Create UnitOfMeasure', 'url'=>array('create')),
	array('label'=>'Manage UnitOfMeasure', 'url'=>array('admin')),
);
?>

<h1>Unit Of Measures</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
