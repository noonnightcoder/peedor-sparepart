<?php
/* @var $this ProfitMarginController */
/* @var $dataProvider CActiveDataProvider */
?>

<?php
$this->breadcrumbs=array(
	'Profit Margins',
);

$this->menu=array(
	array('label'=>'Create ProfitMargin','url'=>array('create')),
	array('label'=>'Manage ProfitMargin','url'=>array('admin')),
);
?>

<h1>Profit Margins</h1>

<?php $this->widget('\TbListView',array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>