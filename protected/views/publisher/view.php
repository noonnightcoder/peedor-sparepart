<?php
/* @var $this PublisherController */
/* @var $model Publisher */
?>

<h4>Viewing Publisher : <?php echo $model->name; ?></h4>

<?php $this->widget('zii.widgets.CDetailView',array(
    'htmlOptions' => array(
        'class' => 'table table-striped table-condensed table-hover',
    ),
    'data'=>$model,
    'attributes'=>array(
		'id',
		'name',
		'location',
		'contact_name',
		'contact_email',
		'contact_tel',
	),
)); ?>