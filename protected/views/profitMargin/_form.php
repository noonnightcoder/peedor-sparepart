<div class="form">

    <?php $form=$this->beginWidget('\TbActiveForm', array(
	'id'=>'profit-margin-form',
	'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
	'enableAjaxValidation'=>false,
        
)); ?>

    <p class="help-block">Fields with <span class="required">*</span> are required.</p>

   

        <?php echo $form->textFieldControlGroup($model,'name',array('span'=>5,'maxlength'=>100)); ?>

        <?php foreach($price_tiers as $i=>$price_tier): ?>
            <div class="form-group">
                <?php echo CHtml::label($price_tier["tier_name"] , $i, array('class'=>'col-sm-3 control-label no-padding-right')); ?>
                <div class="col-sm-9">
                    <?php echo CHtml::TextField(get_class($model) . 'Price[' . $price_tier["tier_id"] . ']',$price_tier["price"]!==null ? round($price_tier["price"],Common::getDecimalPlace()) : $price_tier["price"],array('class'=>'span3 form-control')); ?>
                </div>
            </div>
        <?php endforeach; ?>


        <div class="form-actions">
            <?php echo TbHtml::submitButton($model->isNewRecord ? 'Create' : 'Save',array(
                        'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
                        'size'=>TbHtml::BUTTON_SIZE_LARGE,
                    )); ?>
        </div>

    <?php $this->endWidget(); ?>

</div><!-- form -->