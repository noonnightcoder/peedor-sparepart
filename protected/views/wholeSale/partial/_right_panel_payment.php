<div class="row">
    <div class="sidebar-nav" id="payment_cart">
        <?php if ($count_item <> 0) { ?>
            <?php
            $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                'id' => 'finish_sale_form',
                'action' => Yii::app()->createUrl('wholeSale/completeSale/'),
                'enableAjaxValidation' => false,
                'layout' => TbHtml::FORM_LAYOUT_INLINE,
            ));
            ?>
            <table class="table table-bordered table-condensed">
                <tbody>
                <tr>
                    <td><?php echo Yii::t('app', 'Item in Cart'); ?> :</td>
                    <td><?php echo $count_item; ?></td>
                </tr>

                <?php if ($total_discount!==NULL && $total_discount>0) { ?>
                    <?php foreach ($sub_total_mc as $id => $subtotalmc): ?>
                        <tr>
                            <td><?php echo Yii::t('app', 'Sub Total in ') . $subtotalmc["currency_id"]  ; ?> :</td>
                            <td>
                                            <span class="badge badge-success bigger-120">
                                                <?php echo $subtotalmc['currency_symbol']. $subtotalmc["total"]; ?>
                                            </span>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php } ?>

                <?php foreach ($total_mc as $id => $totalmc): ?>
                    <tr>
                        <td><?php echo Yii::t('app', 'Total in ') . $totalmc["currency_id"]  ; ?> :</td>
                        <td>
                                            <span class="badge badge-primary bigger-120">
                                                <?php echo $totalmc['currency_symbol']. $totalmc["total"]; ?>
                                            </span>
                        </td>
                    </tr>
                <?php endforeach; ?>

                <?php if ($count_payment > 0) { ?>
                    <?php foreach ($payments as $id => $payment): ?>
                        <tr>
                            <td>
                                <?php
                                echo TbHtml::linkButton('', array(
                                    'size' => TbHtml::BUTTON_SIZE_MINI,
                                    'color' => TbHtml::BUTTON_COLOR_DANGER,
                                    'icon' => 'glyphicon-remove',
                                    'url' => Yii::app()->createUrl('wholeSale/DeletePayment', array('currency_code' => $payment['currency_code'])),
                                    'class' => 'delete-payment pull-right',
                                    'title' => Yii::t('app', 'Delete Payment'),
                                ));
                                ?>
                                <?php echo Yii::t('App','Paid Amount') . ' [' . $payment['currency_symbol'] .']'; ?></td>
                            <td>
                                            <span class="badge badge-info bigger-120">
                                                <?php echo $payment['currency_symbol']  . $payment['payment_amount']; ?>
                                            </span>
                            </td>
                        </tr>
                    <?php endforeach; ?>

                <?php } ?>

                <?php if ($account!==null) { ?>
                    <?php foreach ($total_due as $id => $totaldue): ?>
                        <tr>
                            <td><?php echo TbHtml::b(Yii::t('app', 'Outstanding in ') . $totaldue["currency_id"])  ; ?> :</td>
                            <td>
                                                <span class="badge badge-success bigger-140">
                                                    <?php echo $totaldue['currency_symbol']. $totaldue["total"]; ?>
                                                </span>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php } ?>

                <tr style="display: none;">
                    <td><?php //echo Yii::t('app', 'Payment Type'); ?>:</td>
                    <td>
                        <?php //echo $form->dropDownList($model, 'payment_type', InvoiceItem::itemAlias('payment_type'), array('id' => 'payment_type_id')); ?>
                    </td>
                </tr>

                <?php if ($count_payment == 0 || $count_payment == 1 || $count_payment == 2  ) { ?>
                    <tr>
                        <td>
                            <?php echo $form->dropDownList($model,'payment_type', CurrencyType::model()->getCurrency(),array(
                                    'id'=>'currency_type_id',
                                    'options'=>array($selected_currency->code=>array('selected'=>true)),
                                    'class'=>'col-xs-10 col-sm-8')
                            ); ?>
                        </td>
                        <td style='text-align:right'>
                                        <span class="input-icon">
                                            <?php echo $form->textFieldControlGroup($model, 'payment_amount', array(
                                                'class' => 'input-small text-right payment-amount-txt',
                                                'id' => 'payment_amount_id',
                                                'data-url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                                'placeholder'=>Yii::t('app','Payment Amount') . ' ' . $selected_currency->currency_symbol,
                                            ));
                                            ?>
                                            <i class="ace-icon fa fa-money green"><?php echo $selected_currency->currency_symbol; ?></i>
                                        </span>
                        </td>
                    </tr>


                    <!--
                                    <tr>
                                        <td colspan="2" style='text-align:right'>
                                            <?php //foreach ($currency_type as $currency) { ?>
                                                <span class="input-icon">
                                                    <?php /* echo $form->textFieldControlGroup($model, 'payment_amount', array(
                                                        'class' => 'input-small text-right payment-amount-txt',
                                                        //'id' => strtolower($currency["currency_id"]) . '_payment_amount_id',
                                                        'id' => 'payment_amount_' . $currency["code"],
                                                        'data-url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                                        'placeholder'=>Yii::t('app','Payment Amount') . ' ' .  $currency["currency_symbol"],
                                                        //'prepend' => $currency["currency_symbol"],
                                                        ));
                                                     *
                                                     */
                    ?>
                                                    <i class="ace-icon fa fa-money green"><?php //echo $currency["currency_symbol"]; ?></i>
                                                </span>

                                            <?php //} ?>
                                        </td>
                                    </tr>
                                    -->

                    <tr>
                        <td colspan="2" style='text-align:right'><?php
                            echo TbHtml::linkButton(Yii::t('app', 'Add Payment'), array(
                                'color' => TbHtml::BUTTON_COLOR_INFO,
                                'size' => TbHtml::BUTTON_SIZE_MINI,
                                'icon' => 'glyphicon-plus white',
                                'url' => Yii::app()->createUrl('wholeSale/AddPayment/'),
                                'class' => 'add-payment',
                                //'title' => Yii::t('app', 'Add Payment'),
                            ));
                            ?>
                        </td>
                    </tr>
                <?php } ?>

                </tbody>
            </table>

            <?php if ($count_payment > 0) { ?>
                <table class="table table-striped table-condensed">
                    <?php //if ($amount_change<=0) { ?>
                    <td colspan="3" style='text-align:right'>
                        <?php
                        echo TbHtml::linkButton(Yii::t('app', 'Complete Sale'), array(
                            'color' => TbHtml::BUTTON_COLOR_SUCCESS,
                            'icon' => 'glyphicon glyphicon-off white',
                            'class' => 'complete-sale',
                            'id' => 'finish_sale_button',
                            //'title' => Yii::t('app', 'Complete Sale'),
                        ));
                        ?>
                    </td>
                    <!--
                                    <div id="comment_content" align="right">
                                    <?php //echo $form->textArea($model,'comment',array('rows'=>1, 'cols'=>20,'class'=>'input-small','maxlength'=>250,'id'=>'comment_id'));  ?>
                                    </div>
                                    -->
                    <?php //} ?>
                </table>
            <?php } ?>

            <?php $this->endWidget(); ?>
        <?php } ?>

    </div> <!-- /section:custom/widget-main -->

</div>