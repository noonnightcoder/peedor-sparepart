<?php
/* @var $this UnitOfMeasureController */
/* @var $model UnitOfMeasure */

$this->breadcrumbs=array(
	'Unit Of Measures'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List UnitOfMeasure', 'url'=>array('index')),
	array('label'=>'Create UnitOfMeasure', 'url'=>array('create')),
	array('label'=>'View UnitOfMeasure', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage UnitOfMeasure', 'url'=>array('admin')),
);
?>

<h1>Update UnitOfMeasure <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>