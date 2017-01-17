<?php

$this->breadcrumbs=array(
	Yii::t('app','Profit Margin')=>array('admin'),
	Yii::t('app','Manage'),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#profit-margin-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<div class="row" id="pricetier_cart">

	<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
				  'title' => Yii::t('app','List of Profit Margin'),
				  'headerIcon' => 'ace-icon fa fa-list',
				  'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
	)); ?>

		<?php $this->widget('ext.modaldlg.EModalDlg'); ?>

		<div class="page-header">
			<!-- Admin Header layouts.admin._header -->
			<?php $this->renderPartial('//layouts/admin/_header',array(
				'model' => $model,
				'check_access' => 'item.create',
				'create_url' => 'create',
			));?>

		</div>

		<?php $this->renderPartial('//layouts/alert/_flash'); ?>

		<?php $this->widget('yiiwheels.widgets.grid.WhGridView',array(
			'id'=>'profit-margin-grid',
			'dataProvider'=>$model->search(),
			'columns'=>array(
				'name',
				'created_date',
				'modified_date',
				'modified_by',
				array(
					'class' => 'bootstrap.widgets.TbButtonColumn',
					'header' => Yii::t('app', 'Action'),
					'template' => '<div class="hidden-sm hidden-xs btn-group">{view}{update}{delete}</div>',
					'htmlOptions' => array('class' => 'nowrap'),
					'buttons' => array(
						'view' => array(
							'click' => 'updateDialogOpen',
							'url' => 'Yii::app()->createUrl("profitMargin/view/",array("id"=>$data->id))',
							'options' => array(
								'class' => 'btn btn-xs btn-success',
								'data-update-dialog-title' => Yii::t('app', 'View Profit Margin'),
							),
						),
						'update' => array(
							'icon' => 'ace-icon fa fa-edit',
							'label' => Yii::t('app', 'Update'),
							'options' => array(
								'class' => 'btn btn-xs btn-info',
							),
						),
						'delete' => array(
							'label' => Yii::t('app', 'Delete'),
							'options' => array(
								'class' => 'btn btn-xs btn-danger',
							),
						),
					),
				),
			),
		)); ?>

	<?php $this->endWidget(); ?>

</div>
