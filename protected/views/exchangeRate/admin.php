<?php

$this->breadcrumbs=array(
	Yii::t('app','Exchange Rate')=>array('admin'),
	Yii::t('app','Manage'),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#exchange-rate-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget('ext.modaldlg.EModalDlg'); ?>

<?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
	'id'=>'exchange-rate-grid',
	'dataProvider'=>$model->search(),
	//'filter'=>$model,
	'columns'=>array(
		//'id',
		array('name' => 'base_currency_code',
			'value' => '$data["base_val"] . " "  . $data->base_currency->currency_id',
		),
		//'base_val',
		'to_val',
		array('name' => 'to_currency_code',
			'value' => '$data->to_currency->currency_name',
		),
		array(
			'class' => 'bootstrap.widgets.TbButtonColumn',
			'template' => '<div class="btn-group">{update}</div>',
			'buttons' => array(
				'update' => array(
					'click' => 'updateDialogOpen',
					'label' => Yii::t('app', 'Update'),
					'url' => 'Yii::app()->createUrl("exchangeRate/update", array("id"=>$data->id))',
					'options' => array(
						'data-toggle' => 'tooltip',
						'data-update-dialog-title' => Yii::t('app','Update'),
						'class' => 'btn btn-xs btn-primary',
						'title' => Yii::t('app','Update'),
						'data-refresh-grid-id'=>'exchange-rate-grid',
					),
				),
			)
		)
	),
)); ?>