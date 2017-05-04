<?php
/* @var $this GroupDefinitionController */
/* @var $model GroupDefinition */

$this->breadcrumbs=array(
	'Group Definitions'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List GroupDefinition', 'url'=>array('index')),
	array('label'=>'Create GroupDefinition', 'url'=>array('create')),
	array('label'=>'View GroupDefinition', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage GroupDefinition', 'url'=>array('admin')),
);
?>

<h1>Update GroupDefinition <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>