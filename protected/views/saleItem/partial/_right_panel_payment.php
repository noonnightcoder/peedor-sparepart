<div class="row">
    <div class="sidebar-nav" id="payment_cart">
        <?php if ($count_item <> 0) { ?>
            <?php
            $form = $this->beginWidget('bootstrap.widgets.TbActiveForm', array(
                'id' => 'finish_sale_form',
                'action' => Yii::app()->createUrl('saleItem/completeSale/'),
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
                <?php if ($total_discount !== null && $total_discount > 0) { ?>
                    <tr>
                        <td><?php echo Yii::t('app', 'Sub Total'); ?> :</td>
                        <td><span class="badge badge-info bigger-120">
                                <?php number_format($sub_total_kh, 0, '.', ','); ?>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td><?php echo $total_discount . '% ' . Yii::t('app', 'Discount'); ?> :</td>
                        <td>
                            <span class="badge badge-info bigger-120">
                                <?php echo number_format($discount_amount, 0, '.', ','); ?>
                            </span>
                        </td>
                    </tr>
                <?php } ?>
                <tr>
                    <td><?php echo Yii::t('app', 'Total'); ?> :</td>
                    <td>
                        <span class="badge badge-info bigger-120">
                            <?php echo number_format($total_kh, 0, '.', ','); ?>
                        </span>
                    </td>
                </tr>

                <?php foreach (SaleOrder::model()->getAllTotal() as $record): ?>
                    <tr>
                        <td><?= Yii::t('app','Total') . ' ' .  $record['currency_symbol'] ?> </td>
                        <td><?= $record['currency_symbol'] . ' ' . number_format($record['total'],0,'.',',') ?></td>
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
                                    'url' => Yii::app()->createUrl('SaleItem/DeletePayment',
                                        array('payment_id' => $payment['payment_type'])),
                                    'class' => 'delete-payment pull-right',
                                    'title' => Yii::t('app', 'Delete Payment'),
                                ));
                                ?>
                                <?php echo Yii::t('App', 'Paid Amount') . ' [' . $payment['payment_type'] . ']'; ?></td>
                            <td>
                                <span class="badge badge-info bigger-120">
                                    <?php echo number_format($payment['payment_amount'], 0, '.', ','); ?>
                                </span>
                            </td>
                        </tr>
                    <?php endforeach; ?>

                    <?php if ($amount_change <= 0) { ?>
                        <tr>
                            <td>
                                <?php echo Yii::t('app', 'Change Due'); ?>:
                            </td>
                            <td>
                            <span class="badge badge-info bigger-120">
                                <?php echo  number_format($amount_change, Common::getDecimalPlaceRS(), '.', ','); ?>
                            </span>
                            </td>
                        </tr>
                    <?php } else { ?>
                        <tr>
                            <td>
                                <span class="label label-danger">
                                    <?php echo TbHtml::b(Yii::t('app', 'Change Owe')); ?>
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-important bigger-120">
                                    <strong>
                                        <?php echo number_format($amount_change, Common::getDecimalPlaceRS(), '.', ','); ?>
                                    </strong>
                                </span>
                            </td>
                        </tr>
                    <?php } ?>
                <?php } ?>


                <tr style="display: none;">
                    <td><?php echo Yii::t('app', 'Payment Type'); ?>:</td>
                    <td>
                        <?php echo $form->dropDownList($model, 'payment_type', InvoiceItem::itemAlias('payment_type'),
                            array('id' => 'payment_type_id')); ?>
                    </td>
                </tr>


                <?php if ($count_payment == 0) { ?>
                    <tr>
                        <td colspan="2" style='text-align:right'>
                            <?php echo $form->textFieldControlGroup($model, 'payment_amount', array(
                                'value' => '', //$amount_change,
                                'class' => 'input-mini text-right payment-amount-txt',
                                'id' => 'payment_amount_id',
                                'data-url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
                                'placeholder' => Yii::t('app', 'Payment Amount'),
                                //'prepend' => Yii::app()->settings->get('site', 'currencySymbol'),
                            ));
                            ?>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" style='text-align:right'><?php
                            echo TbHtml::linkButton(Yii::t('app', 'Add Payment'), array(
                                'color' => TbHtml::BUTTON_COLOR_INFO,
                                'size' => TbHtml::BUTTON_SIZE_MINI,
                                'icon' => 'glyphicon-plus white',
                                'url' => Yii::app()->createUrl('SaleItem/AddPayment/'),
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
                    <td colspan="3" style='text-align:right'>
                        <?php
                        echo TbHtml::linkButton(Yii::t('app', 'Complete Sale'), array(
                            'color' => TbHtml::BUTTON_COLOR_SUCCESS,
                            'icon' => 'glyphicon glyphicon-off white',
                            //'url' => Yii::app()->createUrl('SaleItem/CompleteSale/'),
                            'class' => 'complete-sale',
                            'id' => 'finish_sale_button',
                            //'title' => Yii::t('app', 'Complete Sale'),
                        ));
                        ?>
                    </td>
                </table>
            <?php } ?>
            <?php $this->endWidget(); ?>
        <?php } ?>
    </div>
</div>