<?php
/* @var $this GroupDefinitionController */
/* @var $dataProvider CActiveDataProvider */

$this->breadcrumbs=array(
	'Group Definitions',
);

$this->menu=array(
	array('label'=>'Create GroupDefinition', 'url'=>array('create')),
	array('label'=>'Manage GroupDefinition', 'url'=>array('admin')),
);
?>

<h1>Group Definitions</h1>

<?php $this->widget('zii.widgets.CListView', array(
	'dataProvider'=>$dataProvider,
	'itemView'=>'_view',
)); ?>
