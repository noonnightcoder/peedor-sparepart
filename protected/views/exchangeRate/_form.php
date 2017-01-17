<?php
/* @var $this ExchangeRateController */
/* @var $model ExchangeRate */
/* @var $form TbActiveForm */
?>

<div class="form">

    <?php $form = $this->beginWidget('\TbActiveForm', array(
        'id' => 'exchange-rate-form',
        'enableAjaxValidation' => false,
        'layout' => TbHtml::FORM_LAYOUT_HORIZONTAL,
    )); ?>

    <p class="help-block">Fields with <span class="required">*</span> are required.</p>

    <?php echo $form->errorSummary($model); ?>

        <div style="display:none"">
            <?php echo $form->textFieldControlGroup($model,'base_currency_code',array('span'=>5)); ?>

            <?php echo $form->textFieldControlGroup($model,'to_currency_code',array('span'=>5)); ?>

            <?php echo $form->textFieldControlGroup($model,'base_val',array('span'=>5)); ?>
        </div>

            <?php echo $form->textFieldControlGroup($model,'to_val',array('span'=>5)); ?>

        <div class="form-actions">
        <?php echo TbHtml::submitButton($model->isNewRecord ? 'Create' : 'Save',array(
		    'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
		    'size'=>TbHtml::BUTTON_SIZE_LARGE,
		)); ?>
    </div>

    <?php $this->endWidget(); ?>

</div><!-- form -->