<?php
/* @var $this PriceTierController */
/* @var $model PriceTier */
/* @var $form TbActiveForm */
?>

<div class="form">

    <?php $form = $this->beginWidget('\TbActiveForm', array(
        'id' => 'price-tier-form',
        'enableAjaxValidation' => false,
        'layout' => TbHtml::FORM_LAYOUT_HORIZONTAL,
        'enableClientValidation'=>true,
        'clientOptions' => array(
            'validateOnSubmit'=>true,
            'validateOnChange'=>true,
            'validateOnType'=>false,
        ),
    )); ?>

    <p class="help-block">Fields with <span class="required">*</span> are required.</p>

    <?php //echo $form->errorSummary($model); ?>

    <?php echo $form->textFieldControlGroup($model, 'tier_name', array('span' => 8, 'maxlength' => 30)); ?>

    <?php echo $form->textFieldControlGroup($model, 'sort_order', array('span' => 2)); ?>

    <?php echo $form->textAreaControlGroup($model, 'description', array('span' => 4, 'maxlength' => 1000 )); ?>

    <?php //echo $form->textFieldControlGroup($model,'deleted',array('span'=>5)); ?>

    <div class="form-actions">
        <?php echo TbHtml::submitButton($model->isNewRecord ? Yii::t('app', 'Create') : Yii::t('app', 'Save'), array(
            'color' => TbHtml::BUTTON_COLOR_PRIMARY,
            //'size'=>TbHtml::BUTTON_SIZE_SMALL,
        )); ?>
    </div>

    <?php $this->endWidget(); ?>

</div><!-- form -->