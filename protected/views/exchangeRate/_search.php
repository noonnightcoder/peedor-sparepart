<?php
/* @var $this ExchangeRateController */
/* @var $model ExchangeRate */
/* @var $form CActiveForm */
?>

<div class="wide form">

    <?php $form=$this->beginWidget('\TbActiveForm', array(
	'action'=>Yii::app()->createUrl($this->route),
	'method'=>'get',
)); ?>

                    <?php echo $form->textFieldControlGroup($model,'id',array('span'=>5)); ?>

                    <?php echo $form->textFieldControlGroup($model,'base_currency_code',array('span'=>5)); ?>

                    <?php echo $form->textFieldControlGroup($model,'to_currency_code',array('span'=>5)); ?>

                    <?php echo $form->textFieldControlGroup($model,'base_val',array('span'=>5)); ?>

                    <?php echo $form->textFieldControlGroup($model,'to_val',array('span'=>5)); ?>

        <div class="form-actions">
        <?php echo TbHtml::submitButton('Search',  array('color' => TbHtml::BUTTON_COLOR_PRIMARY,));?>
    </div>

    <?php $this->endWidget(); ?>

</div><!-- search-form -->