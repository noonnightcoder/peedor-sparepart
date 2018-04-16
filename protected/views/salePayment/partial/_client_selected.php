<?php $this->widget( 'ext.modaldlg.EModalDlg' ); ?>
<?php $form=$this->beginWidget('bootstrap.widgets.TbActiveForm',array(
        'id'=>'client_selected_form',
        'layout'=>TbHtml::FORM_LAYOUT_HORIZONTAL,
        'action'=>Yii::app()->createUrl('salePayment/removeCustomer/'),
)); ?>
 
        <div class="">
            <label class="col-sm-3 control-label required" for="SalePayment_payment_amount">  </label>

            <div class="col-sm-9">

                <div class="clear">
                    <ul class="list-unstyled">
                        <span style="font-size:17px">
                            <li>
                                Balance :
                                <?php foreach ($account as $acc) { ?>
                                    <?php echo $acc["currency_symbol"] . number_format($acc["current_balance"],
                                            Common::getDecimalPlace()) . ' - '; ?>
                                    <?php $account_name = $acc["name"]; ?>
                                <?php } ?>

                                    <?php echo TbHtml::link(ucwords($account_name),
                                        $this->createUrl('Client/View/', array('id' => $client_id)), array(
                                            'class' => 'update-dialog-open-link',
                                            'data-update-dialog-title' => Yii::t('app', 'Customer Information'),
                                        )); ?>

                                    <?php echo TbHtml::linkButton(Yii::t('app', ''), array(
                                        'color' => TbHtml::BUTTON_COLOR_WARNING,
                                        'size' => TbHtml::BUTTON_SIZE_MINI,
                                        'icon' => 'glyphicon-remove white',
                                        'class' => 'btn btn-sm detach-customer',
                                    )); ?>
                            </li>
                        </span>
                    </ul>
                </div>

            </div>
        </div>
        
        <br /> <br /> <br>
        
<?php $this->endWidget(); ?>
