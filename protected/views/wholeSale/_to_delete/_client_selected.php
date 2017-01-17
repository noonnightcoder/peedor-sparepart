<?php $this->widget( 'ext.modaldlg.EModalDlg' ); ?>
<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
        'id'=>'client_selected_form',
        'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
        'action'=>Yii::app()->createUrl('wholeSale/removeCustomer/'),
)); ?>

        <div class="clear">
            <ul class="list-unstyled">
                <span style="font-size:14px">
                <li>
                    Balance :
                    <?php foreach ($account as $acc) { ?>
                        <?php echo $acc["currency_symbol"]  . number_format($acc["current_balance"],Yii::app()->wshoppingCart->getDecimalPlace()) . ' - '; ?>
                        <?php $account_name = $acc["name"]; ?>
                    <?php } ?>

                    <?php echo TbHtml::link(ucwords($account_name),$this->createUrl('Client/View/',array('id'=>$customer_id)), array(
                        'class'=>'update-dialog-open-link',
                        'data-update-dialog-title' => Yii::t('app','Customer Information'),
                    )); ?>


                </li>
                </span>
            </ul>
        </div>

        <?php echo TbHtml::linkButton(Yii::t( 'app', 'Edit' ),array(
            'color'=>TbHtml::BUTTON_COLOR_SUCCESS,
            'size'=>TbHtml::BUTTON_SIZE_MINI,
            'icon'=>'glyphicon-edit white',
            'class'=>'btn btn-sm edit-customer',
            'url'=>Yii::app()->createUrl("client/update/",array("id"=>$customer_id,'sale_mode'=>'Y')),
        )); ?>

        <?php echo TbHtml::linkButton(Yii::t( 'app', 'Remove' ),array(
            'color'=>TbHtml::BUTTON_COLOR_WARNING,
            'size'=>TbHtml::BUTTON_SIZE_MINI,
            'icon'=>'glyphicon-remove white',
            'class'=>'btn btn-sm detach-customer',
        )); ?>
    
        <?php if (PriceTier::model()->checkExists()<>0) { ?>
            <p>
                <?php echo $form->dropDownListControlGroup($model,'tier_id', PriceTier::model()->getPriceTier(),array('id'=>'price_tier_id',
                    'options'=>array(Yii::app()->wshoppingCart->getPriceTier()=>array('selected'=>true)),
                    'class'=>'col-xs-10 col-sm-8','empty'=>'None','labelOptions'=>array('label'=>Yii::t('app','Item Tier')))); ?>

            </p>
        <?php } ?>
        
<?php $this->endWidget(); ?>
