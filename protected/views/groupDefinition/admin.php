<?php
/* @var $this GroupDefinitionController */
/* @var $model GroupDefinition */

$this->breadcrumbs=array(
	'Group Definitions'=>array('index'),
	'Manage',
);

$this->menu=array(
	array('label'=>'List GroupDefinition', 'url'=>array('index')),
	array('label'=>'Create GroupDefinition', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#group-definition-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<h1>Manage Group Definitions</h1>

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
	'id'=>'group-definition-grid',
	'dataProvider'=>$model->search(),
	'filter'=>$model,
	'columns'=>array(
		'id',
		'alt_qty',
		'alt_uom_id',
		'base_qty',
		'base_uom_id',
		'created_at',
		/*
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
