<?php
/* @var $this ExchangeRateController */
/* @var $data ExchangeRate */
?>

<div class="view">

    	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id),array('view','id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('base_currency_code')); ?>:</b>
	<?php echo CHtml::encode($data->base_currency_code); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('to_currency_code')); ?>:</b>
	<?php echo CHtml::encode($data->to_currency_code); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('base_val')); ?>:</b>
	<?php echo CHtml::encode($data->base_val); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('to_val')); ?>:</b>
	<?php echo CHtml::encode($data->to_val); ?>
	<br />


</div>