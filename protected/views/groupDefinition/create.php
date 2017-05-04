<?php
/* @var $this GroupDefinitionController */
/* @var $model GroupDefinition */

$this->breadcrumbs=array(
	'Group Definitions'=>array('index'),
	'Create',
);

$this->menu=array(
	array('label'=>'List GroupDefinition', 'url'=>array('index')),
	array('label'=>'Manage GroupDefinition', 'url'=>array('admin')),
);
?>

<h1>Create GroupDefinition</h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>