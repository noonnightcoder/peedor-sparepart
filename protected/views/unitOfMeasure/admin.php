<?php
/* @var $this UnitOfMeasureController */
/* @var $model UnitOfMeasure */

$this->breadcrumbs=array(
	'Unit Of Measures'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List UnitOfMeasure', 'url'=>array('index')),
	array('label'=>'Create UnitOfMeasure', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#unit-of-measure-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Unit Of Measures</h1>

<p>
You may optionally enter a comparison operator (<b>&lt;</b>, <b>&lt;=</b>, <b>&gt;</b>, <b>&gt;=</b>, <b>&lt;&gt;</b>
or <b>=</b>) at the beginning of each of your search values to specify how the comparison should be done.
</p>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('zii.widgets.grid.CGridView', array(
	'id'=>'unit-of-measure-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'uom_code',
		'uom_name',
		'length',
		'width',
		'height',
		/*
		'volume',
		'volume_uom',
		'weight',
		'status',
		'created_at',
		'updated_at',
		'deleted_at',
		'created_by',
		'updated_by',
		'deleted_by',
		*/
		array(
			'class'=>'CButtonColumn',
		),
	),
)); ?>
