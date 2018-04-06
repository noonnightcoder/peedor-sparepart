<?php echo $form->textFieldControlGroup($model,'item_number',array('class'=>'span3','maxlength'=>255)); ?>

<?php echo $form->textFieldControlGroup($model,'name',array('class'=>'span3','maxlength'=>100)); ?>

<?php echo $form->textFieldControlGroup($model,'isbn',array('class'=>'span3','maxlength'=>100)); ?>

<div class="unittype-wrapper" style="display:none">
    <?php //echo $form->textFieldControlGroup($model,'sub_quantity',array('class'=>'span2','prepend'=>'$')); ?>
</div>

<?php echo $form->dropDownListControlGroup($model,'currency_code', CurrencyType::model()->getCurrencyCode(),array('class'=>'span3')); ?>

<?php echo $form->textFieldControlGroup($model,'cost_price',array('class'=>'span3')); ?>

<?php echo $form->dropDownListControlGroup($model,'profit_margin_id', ProfitMargin::model()->getProfitMargin(),
    array('class'=>'span3','empty' => '-- Select Profit Margin --','data-url'=>Yii::app()->createUrl('item/f5pricetier'))); ?>

<?php //echo $form->textFieldControlGroup($model,'unit_price',array('class'=>'span3')); ?>

<div id="pricetier_cart">
    <?php foreach($price_tiers as $i=>$price_tier): ?>
        <div class="form-group">
            <?php echo CHtml::label($price_tier["tier_name"]  , $i, array('class'=>'col-sm-3 control-label no-padding-right')); ?>
            <div class="col-sm-9">
                <?php echo CHtml::TextField(get_class($model) . 'Price[' . $price_tier["tier_id"] . ']', $price_tier["price"] !== null ? round($price_tier["price"], Common::getDecimalPlace()) : $price_tier["price"],
                    array(
                        'value' => $price_tier['price'],
                        'class' => 'span3 form-control'
                    )
                );
                ?>
            </div>
        </div>
    <?php endforeach; ?>
</div>