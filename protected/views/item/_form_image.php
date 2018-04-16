<div id="item_container">

<?php if(Yii::app()->user->hasFlash('success')):?>
    <?php $this->widget('bootstrap.widgets.TbAlert'); ?>
<?php endif; ?>

    <?php /*$form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
        'id'=>'item-form',
        'enableAjaxValidation'=>true,
        'enableClientValidation'=>true,
        'clientOptions' => array(
            'validateOnSubmit'=>true,
            'validateOnChange'=>true,
            'validateOnType'=>false,
        ),
        'layout' => TbHtml::FORM_LAYOUT_HORIZONTAL,
        'htmlOptions'=>array('enctype' => 'multipart/form-data'),
    )); */?>


    <?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
        'id'=>'item-form',
        'enableAjaxValidation'=>false,
        'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
    )); ?>

	<p class="help-block"><?php echo Yii::t('app', 'Fields with'); ?> <span class="required">*</span> <?php echo Yii::t('app', 'are required'); ?></p>

        <?php $this->renderPartial('_form_basic', array(
                'model' => $model,
                'form' => $form,
                'price_tiers' => $price_tiers,
            )
        ) ?>


        <?php $this->renderPartial('_form_custom', array(
                'model' => $model,
                'form' => $form,
            )
        ) ?>

	<div class="form-actions">
                 <?php echo TbHtml::submitButton($model->isNewRecord ? Yii::t('app','Create') : Yii::t('app','Save'),array(
		    'color'=>TbHtml::BUTTON_COLOR_PRIMARY,
		    //'size'=>TbHtml::BUTTON_SIZE_SMALL,
		)); ?>
	</div>

<?php $this->endWidget(); ?>

<?php Yii::app()->clientScript->registerScript('setFocus',  '$("#Item_name").focus();'); ?>

 <script>
 $("form").submit(function () {
      if($(this).data("allreadyInput")){
            return false;
      }else{
        $("input[type=submit]", this).hide();
        $(this).data("allreadyInput", true);
        // regular checks and submit the form here
      }
});

/*window.setTimeout(function() {
    $(".alert").fadeTo(1000, 0).slideUp(1000, function(){
        $(this).remove(); 
    });
}, 1000);*/

 </script>

 <?php 
    Yii::app()->clientScript->registerScript( 'profitMarginOption', "
        jQuery( function($){
            $('div#item_container').on('change','#Item_profit_margin_id',function(e) {
                e.preventDefault();
                var profitmarginId=$(this).val();
                var url =$(this).data('url');
                var costPrice=$('#Item_cost_price').val();
                $.ajax({url: url,
                        data : {profit_margin_id : profitmarginId, cost_price : costPrice},
                        type : 'post',
                        beforeSend: function() { $('.waiting').show(); },
                        complete: function() { $('.waiting').hide(); },
                        success : function(data) {
                           $('#pricetier_cart').html(data);
                        }
                });
            });
         });
      ");
 ?> 

</div>
