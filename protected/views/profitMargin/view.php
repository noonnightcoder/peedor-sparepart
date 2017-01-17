<h5><?php echo $model->name; ?></h5>

<?php $this->widget('zii.widgets.CDetailView',array(
    'htmlOptions' => array(
        'class' => 'table table-striped table-condensed table-hover',
    ),
    'data'=>$model,
    'attributes'=>array(
		'id',
		'name',
		'create_date',
		'updated_date',
		'created_by',
		'updated_by',
	),
)); ?>