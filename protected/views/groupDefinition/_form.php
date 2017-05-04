<?php
/* @var $this GroupDefinitionController */
/* @var $model GroupDefinition */
/* @var $form CActiveForm */
?>

<div class="form">

<?php $form=$this->beginWidget('CActiveForm', array(
	'id'=>'group-definition-form',
	// Please note: When you enable ajax validation, make sure the corresponding
	// controller action is handling ajax validation correctly.
	// There is a call to performAjaxValidation() commented in generated controller code.
	// See class documentation of CActiveForm for details on this.
	'enableAjaxValidation'=>false,
)); ?>

	<p class="note">Fields with <span class="required">*</span> are required.</p>

	<?php echo $form->errorSummary($model); ?>

	<div class="row">
		<?php echo $form->labelEx($model,'alt_qty'); ?>
		<?php echo $form->textField($model,'alt_qty',array('size'=>13,'maxlength'=>13)); ?>
		<?php echo $form->error($model,'alt_qty'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'alt_uom_id'); ?>
		<?php echo $form->textField($model,'alt_uom_id'); ?>
		<?php echo $form->error($model,'alt_uom_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'base_qty'); ?>
		<?php echo $form->textField($model,'base_qty',array('size'=>13,'maxlength'=>13)); ?>
		<?php echo $form->error($model,'base_qty'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'base_uom_id'); ?>
		<?php echo $form->textField($model,'base_uom_id'); ?>
		<?php echo $form->error($model,'base_uom_id'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'created_at'); ?>
		<?php echo $form->textField($model,'created_at'); ?>
		<?php echo $form->error($model,'created_at'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'updated_at'); ?>
		<?php echo $form->textField($model,'updated_at'); ?>
		<?php echo $form->error($model,'updated_at'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'deleted_at'); ?>
		<?php echo $form->textField($model,'deleted_at'); ?>
		<?php echo $form->error($model,'deleted_at'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'created_by'); ?>
		<?php echo $form->textField($model,'created_by'); ?>
		<?php echo $form->error($model,'created_by'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'updated_by'); ?>
		<?php echo $form->textField($model,'updated_by'); ?>
		<?php echo $form->error($model,'updated_by'); ?>
	</div>

	<div class="row">
		<?php echo $form->labelEx($model,'deleted_by'); ?>
		<?php echo $form->textField($model,'deleted_by'); ?>
		<?php echo $form->error($model,'deleted_by'); ?>
	</div>

	<div class="row buttons">
		<?php echo CHtml::submitButton($model->isNewRecord ? 'Create' : 'Save'); ?>
	</div>

<?php $this->endWidget(); ?>

</div><!-- form -->