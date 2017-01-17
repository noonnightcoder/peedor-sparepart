<?php
/* @var $this PublisherController */
/* @var $model Publisher */

$this->breadcrumbs=array(
	Yii::t('app','Publisher')=>array('publisher/admin'),
	Yii::t('app','Publisher'),
);

$this->menu=array(
	array('label'=>'List Publisher', 'url'=>array('index')),
	array('label'=>'Create Publisher', 'url'=>array('create')),
);

Yii::app()->clientScript->registerScript('search', "
$('.search-button').click(function(){
	$('.search-form').toggle();
	return false;
});
$('.search-form form').submit(function(){
	$('#publisher-grid').yiiGridView('update', {
		data: $(this).serialize()
	});
	return false;
});
");
?>

<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
    'title' => Yii::t('app', 'List of Publisher'),
    'headerIcon' => 'fa-icon fa fa-users',
    'htmlHeaderOptions' => array('class' => 'widget-header-flat widget-header-small'),
)); ?>


<?php echo CHtml::link('Advanced Search','#',array('class'=>'search-button btn')); ?>
<div class="search-form" style="display:none">
<?php $this->renderPartial('_search',array(
	'model'=>$model,
)); ?>
</div><!-- search-form -->

<?php $this->widget( 'ext.modaldlg.EModalDlg' ); ?>

<?php echo TbHtml::linkButton(Yii::t( 'app', 'Add New' ),array(
        'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
        'size'=>TbHtml::BUTTON_SIZE_SMALL,
        'icon'=>'ace-icon fa fa-plus white',
        'url'=>$this->createUrl('create'),
        'class'=>'update-dialog-open-link',
        'data-update-dialog-title' => Yii::t('app','Create Publisher'),
        'data-refresh-grid-id'=>'publisher-grid',
)); ?>

<?php $this->widget('\TbGridView',array(
	'id'=>'publisher-grid',
	'dataProvider'=>$model->search(),
	//'filter'=>$model,
	'columns'=>array(
		array('name'=>'id',
                      'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                      'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                ),
		'name',
		array('name'=>'location',
                      'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                      'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                ),    
		'contact_name',
                array('name'=>'contact_email',
                      'headerHtmlOptions'=>array('class'=>'hidden-480 hidden-xs'),
                      'htmlOptions'=>array('class' => 'hidden-480 hidden-xs'),
                ), 
                array('name'=>'contact_tel',
                      'headerHtmlOptions'=>array('class'=>'hidden-480'),
                      'htmlOptions'=>array('class' => 'hidden-480'),
                ),
                array('class'=>'bootstrap.widgets.TbButtonColumn',
                    'template'=>'<div class="hidden-sm hidden-xs btn-group">{view}{update}{delete}</div>',  
                    'htmlOptions'=>array('class'=>'nowrap'),
                    'buttons' => array(
                        'view' => array(
                          'click' => 'updateDialogOpen',    
                          'url'=>'Yii::app()->createUrl("publisher/view/",array("id"=>$data->id))',
                          'options' => array(
                              'class'=>'btn btn-xs btn-success',
                              'data-update-dialog-title' => Yii::t( 'app', 'View Publisher' ),
                            ),   
                        ),
                        'update' => array(
                          'icon' => 'ace-icon fa fa-edit',
                          'click' => 'updateDialogOpen',  
                          'options' => array(
                              'class'=>'btn btn-xs btn-info',
                               'data-update-dialog-title' => Yii::t( 'app', 'Update Publisher' ),
                               'data-refresh-grid-id'=>'publisher-grid',
                            ), 
                        ),   
                        'delete' => array(
                           'label'=>'Delete',
                           'options' => array(
                              'class'=>'btn btn-xs btn-danger',
                            ), 
                        ),
                     ),
                ),
                array('class'=>'bootstrap.widgets.TbButtonColumn',
                    'template'=>'<div class="hidden-md hidden-lg"><div class="inline position-relative">
                                    <button class="btn btn-minier btn-primary dropdown-toggle" data-toggle="dropdown" data-position="auto"><i class="ace-icon fa fa-cog icon-only bigger-110"></i></button>
                                    <ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">
                                    <li>{view}</li><li>{update}</li><li>{delete}</li>
                                    </ul></div></div>',
                    'htmlOptions'=>array('class'=>'nowrap'),
                    'buttons' => array(
                        'view' => array(
                          'click' => 'updateDialogOpen',    
                          'url'=>'Yii::app()->createUrl("publisher/view/",array("id"=>$data->id))',
                          'options' => array(
                              'class'=>'btn btn-xs btn-success',
                              'data-update-dialog-title' => Yii::t( 'app', 'View Publisher' ),
                            ),   
                        ),
                        'update' => array(
                          'icon' => 'ace-icon fa fa-edit',
                          'click' => 'updateDialogOpen',  
                          'options' => array(
                              'class'=>'btn btn-xs btn-info',
                               'data-update-dialog-title' => Yii::t( 'app', 'Update Publisher' ),
                               'data-refresh-grid-id'=>'publisher-grid',
                            ), 
                        ),   
                        'delete' => array(
                           'label'=>'Delete',
                           'options' => array(
                              'class'=>'btn btn-xs btn-danger',
                            ), 
                        ),
                     ),
                ),
	),
)); ?>

<?php $this->endWidget(); ?>