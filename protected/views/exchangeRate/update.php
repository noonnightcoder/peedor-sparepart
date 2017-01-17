<?php
/* @var $this ExchangeRateController */
/* @var $model ExchangeRate */
?>

<?php
$this->breadcrumbs=array(
	'Exchange Rates'=>array('index'),
	$model->id=>array('view','id'=>$model->id),
	'Update',
);

$this->menu=array(
	array('label'=>'List ExchangeRate', 'url'=>array('index')),
	array('label'=>'Create ExchangeRate', 'url'=>array('create')),
	array('label'=>'View ExchangeRate', 'url'=>array('view', 'id'=>$model->id)),
	array('label'=>'Manage ExchangeRate', 'url'=>array('admin')),
);
?>

    <h1>Update ExchangeRate <?php echo $model->id; ?></h1>

<?php $this->renderPartial('_form', array('model'=>$model)); ?>