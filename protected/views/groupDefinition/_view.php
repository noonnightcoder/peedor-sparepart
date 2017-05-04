<?php
/* @var $this GroupDefinitionController */
/* @var $data GroupDefinition */
?>

<div class="view">

	<b><?php echo CHtml::encode($data->getAttributeLabel('id')); ?>:</b>
	<?php echo CHtml::link(CHtml::encode($data->id), array('view', 'id'=>$data->id)); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('alt_qty')); ?>:</b>
	<?php echo CHtml::encode($data->alt_qty); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('alt_uom_id')); ?>:</b>
	<?php echo CHtml::encode($data->alt_uom_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('base_qty')); ?>:</b>
	<?php echo CHtml::encode($data->base_qty); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('base_uom_id')); ?>:</b>
	<?php echo CHtml::encode($data->base_uom_id); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('created_at')); ?>:</b>
	<?php echo CHtml::encode($data->created_at); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('updated_at')); ?>:</b>
	<?php echo CHtml::encode($data->updated_at); ?>
	<br />

	<?php /*
	<b><?php echo CHtml::encode($data->getAttributeLabel('deleted_at')); ?>:</b>
	<?php echo CHtml::encode($data->deleted_at); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('created_by')); ?>:</b>
	<?php echo CHtml::encode($data->created_by); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('updated_by')); ?>:</b>
	<?php echo CHtml::encode($data->updated_by); ?>
	<br />

	<b><?php echo CHtml::encode($data->getAttributeLabel('deleted_by')); ?>:</b>
	<?php echo CHtml::encode($data->deleted_by); ?>
	<br />

	*/ ?>

</div>