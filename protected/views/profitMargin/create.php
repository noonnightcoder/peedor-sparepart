<?php
$this->breadcrumbs=array(
	Yii::t('app','Profit Margin')=>array('admin'),
	Yii::t('app','Create'),
);

?>

<?php $this->renderPartial('//layouts/alert/_flash'); ?>

<?php $box = $this->beginWidget('yiiwheels.widgets.box.WhBox', array(
              'title' => Yii::t('app','Create Profit Margin'),
              'headerIcon' => 'ace-icon fa fa-cube',
              'htmlHeaderOptions'=>array('class'=>'widget-header-flat widget-header-small'),
              'content' => $this->renderPartial('_form', array('model'=>$model,'price_tiers'=>$price_tiers), true),
 )); ?>  

<?php $this->endWidget(); ?>