<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
	'id'=>'client-form',
	'enableAjaxValidation'=>false,
        'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
        'htmlOptions'=>array('data-validate'=>'parsley'),
)); ?>

	<p class="help-block"><?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?></p>

	<?php //echo $form->errorSummary($model); ?>
        
        <?php echo $form->textFieldControlGroup($model,'mobile_no',array('class'=>'span8','maxlength'=>15)); ?>

	<?php echo $form->textFieldControlGroup($model,'first_name',array('class'=>'span8','maxlength'=>60)); ?>
        
        <?php echo $form->textFieldControlGroup($model,'last_name',array('class'=>'span8','maxlength'=>60)); ?>
        
        <?php //echo $form->dropDownListRow($model,'debter_id', DebtCollector::model()->getDebterInfo(), array('class'=>'span8','prompt'=>'Select Debt Colletor')); ?>

	<?php echo $form->textFieldControlGroup($model,'address1',array('class'=>'span8','maxlength'=>60)); ?>

	<?php echo $form->textFieldControlGroup($model,'address2',array('class'=>'span8','maxlength'=>60)); ?>

	<?php //echo $form->textFieldControlGroup($model,'city_id',array('class'=>'span8')); ?>

	<?php //echo $form->textFieldControlGroup($model,'country_code',array('class'=>'span8','maxlength'=>2)); ?>

	<?php //echo $form->textFieldControlGroup($model,'email',array('class'=>'span8','maxlength'=>30)); ?>

	<?php echo $form->textAreaControlGroup($model,'notes',array('rows'=>2, 'cols'=>20, 'class'=>'span8')); ?>

	<div class="form-actions">
            <?php echo TbHtml::submitButton($model->isNewRecord ? Yii::t('app','Create') : Yii::t('app','Save'),array(
               'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
               //'size'=>TbHtml::BUTTON_SIZE_SMALL,
           )); ?>
        </div>

<?php $this->endWidget(); ?>
