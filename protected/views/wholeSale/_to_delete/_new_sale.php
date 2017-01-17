<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
        'id'=>'client_form',
        'method'=>'post',
        'action' => Yii::app()->createUrl('wholeSale/selectCustomer/'),
        'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
)); ?>
          <?php 
            $this->widget('zii.widgets.jui.CJuiAutoComplete', array(
                    'model'=>$model,
                    'attribute'=>'client_id',
                    'source'=>$this->createUrl('request/suggestClient'), 
                    'htmlOptions'=>array(
                        'size'=>'30'
                    ),
                    'options'=>array(
                        'showAnim'=>'fold',
                        'minLength'=>'1',
                        'delay' => 10,
                        'autoFocus'=> false,
                        'select'=>'js:function(event, ui) {
                            event.preventDefault();
                            $("#SaleItem_client_id").val(ui.item.id);
                            $("#client_form").ajaxSubmit({target: "#register_container", beforeSubmit: salesBeforeSubmit});
                        }',
                    ),
                ));
          ?>

        </p>
        
<?php $this->endWidget(); ?>
