<?php
/* @var $this PublisherController */
/* @var $dataProvider CActiveDataProvider */
?>

<?php
$this->breadcrumbs=array(
	'Publishers',
);

$this->menu=array(
	array('label'=>'Create Publisher','url'=>array('create')),
	array('label'=>'Manage Publisher','url'=>array('admin')),
);
?>

<h1>Publishers</h1>

<?php $this->widget('\TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>